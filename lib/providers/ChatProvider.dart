import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:newvirus/utils/texts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier{
  
  Brightness brightness = Brightness.light; // Default value
  
  Color get messagebubblecolor => brightness == Brightness.light ? AppColors.messagebubblecolorLIGHTMODE : AppColors.messagebubblecolorDARKMODE;
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  String error = "";
  String _response = "";
  final List<Message> messages = [Message(role: Role.system, content: Texts.systemmessage),];
 ConnectivityResult _connectivityStatus = ConnectivityResult.none;
StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

bool get isOnline => _connectivityStatus != ConnectivityResult.none;

  void updateBrightness(Brightness newBrightness) {
    if (brightness != newBrightness) {
      brightness = newBrightness;
      notifyListeners();
    }
  }

  // Initialize with system brightness
  void initializeSystemBrightness(BuildContext context) {
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    updateBrightness(systemBrightness);
  }

  Future<void> getResponse(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    
    print("Sending API request with ${messages.length} messages");
    
try {
      final response = await http.post(
        Uri.parse(Texts.endpoint),
        headers: {
          'Authorization': 'Bearer ${Texts.apikey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile", // or 
          "messages": messages.map((message) => {
            "role": message.role.name,
            "content": message.content,
          }).toList(),
          "temperature": 0.7,
          "max_tokens": 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final reply = data['choices'][0]['message']['content'];
       
          _response = reply.trim();
          messages.add(Message(role: Role.assistant, content: _response));
          print("API Success - Response: $_response");

        
      } else {
        messages.removeLast();
          print("API Error - Status Code: ${response.statusCode}");
          print("API Error - Response: ${response.body}");
          _response = 'Error: ${response.statusCode} - ${response.body}';
          _showConnectionToast(context,"something wrong happened , please try again.");
          
      
      }
    } catch (e) {
      messages.removeLast();
        print("Exception occurred: $e");
        _response = 'Exception: $e';
        _showConnectionToast(context,"Exception: $e");
   
    }

   isLoading=false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  });
   notifyListeners();
 
  }


    void sendMessage(BuildContext context){
      if(!isOnline) 
      {
      _showConnectionToast(context,"Please check your internet connection");
      return;
      }
  
    if(controller.text.trim().isEmpty) return;
    messages.add(Message(role: Role.user, content: controller.text.trim()));
    controller.clear();
    controller.text = "";
    FocusScope.of(context).unfocus();
    notifyListeners();
   WidgetsBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  });
  getResponse(context);
  }

  void checkChatStatus(BuildContext context){
    _connectivitySubscription = Connectivity()
      .onConnectivityChanged
      .listen((List<ConnectivityResult> results) {
    _connectivityStatus = results.isNotEmpty ? results.first : ConnectivityResult.none;
    notifyListeners();
    print("📶 Connection changed: $_connectivityStatus");
  });
}

void disposeConnectionListener() {
  _connectivitySubscription?.cancel();
}

void _showConnectionToast(BuildContext context,String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top:  100,
      left: 20,
      right: 20,
     
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade400, Colors.red.shade600],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Timer(Duration(seconds: 3), () => overlayEntry.remove());
}

}

