import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:newvirus/models/Message.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:newvirus/utils/texts.dart';

class ChatProvider extends ChangeNotifier {
  // Private fields
  Brightness _brightness = Brightness.light;
  bool _isLoading = false;
  bool _isEditing = false;
  String _error = "";
  String _response = "";
  int? _indexOfEditingMessage;
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  // Controllers
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Messages list
  final List<Message> messages = [
    Message(role: Role.system, content: Texts.systemmessage),
  ];

  // Getters
  Brightness get brightness => _brightness;
  bool get isLoading => _isLoading;
  bool get isEditing => _isEditing;
  String get error => _error;
  int? get indexOfEditingMessage => _indexOfEditingMessage;
  bool get isOnline => _connectivityStatus != ConnectivityResult.none;

  Color get messagebubblecolor => _brightness == Brightness.light
      ? AppColors.messagebubblecolorLIGHTMODE
      : AppColors.messagebubblecolorDARKMODE;

  // Constants
  static const String _brightnessKey = 'brightness_mode';

  

  // Brightness Management with SharedPreferences
  void setBrightness(Brightness value) {
    _brightness = value;
    notifyListeners();
  }
  void setEditing(bool value) {
    _isEditing = value;
    notifyListeners();
  }
  

  
  // Message Management
  Future<void> sendMessage(BuildContext context) async {
    if (!isOnline) {
      _showConnectionToast(context, "Please check your internet connection");
      return;
    }

    if (controller.text.trim().isEmpty) return;

    if (_isEditing) {
      await _handleEditMessage(context);
      return;
    }

    await _handleNewMessage(context);
  }

  Future<void> _handleEditMessage(BuildContext context) async {
    _isEditing = false;
    notifyListeners();

    // Remove messages after the editing index
    while (messages.length > _indexOfEditingMessage!) {
      messages.removeLast();
    }

    messages.add(Message(role: Role.user, content: controller.text.trim()));
    _clearController(context);
    await _getResponse(context);
  }

  Future<void> _handleNewMessage(BuildContext context) async {
    messages.add(Message(role: Role.user, content: controller.text.trim()));
    _clearController(context);
    await _scrollToBottom();
    await _getResponse(context);
  }

  void _clearController(BuildContext context) {
    controller.clear();
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  // API Communication
  Future<void> _getResponse(BuildContext context) async {
    _setLoading(true);
    
    debugPrint("Sending API request with ${messages.length} messages");
    
    try {
      final response = await http.post(
        Uri.parse(Texts.endpoint),
        headers: {
          'Authorization': 'Bearer ${Texts.apikey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile",
          "messages": messages.map((message) => {
            "role": message.role.name,
            "content": message.content,
          }).toList(),
          "temperature": 0.7,
          "max_tokens": 1000,
        }),
      );

      await _handleApiResponse(response, context);
    } catch (e) {
      await _handleApiError(e, context);
    }

    _setLoading(false);
    await _scrollToBottom();
  }

  Future<void> _handleApiResponse(http.Response response, BuildContext context) async {
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final reply = data['choices'][0]['message']['content'];
      
      _response = reply.trim();
      messages.add(Message(role: Role.assistant, content: _response));
      debugPrint("API Success - Response: $_response");
    } else {
      messages.removeLast();
      debugPrint("API Error - Status Code: ${response.statusCode}");
      debugPrint("API Error - Response: ${response.body}");
      
      _response = 'Error: ${response.statusCode} - ${response.body}';
      _showConnectionToast(context, "Something went wrong, please try again.");
    }
  }

  Future<void> _handleApiError(dynamic error, BuildContext context) async {
    messages.removeLast();
    debugPrint("Exception occurred: $error");
    
    _response = 'Exception: $error';
    _showConnectionToast(context, "Exception: $error");
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> _scrollToBottom() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Connectivity Management
  void initializeConnectivity() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _connectivityStatus = results.isNotEmpty ? results.first : ConnectivityResult.none;
      notifyListeners();
      debugPrint("📶 Connection changed: $_connectivityStatus");
    });
  }

  void disposeConnectivity() {
    _connectivitySubscription?.cancel();
  }

  // Message Actions
  void copyMessage(BuildContext context, Message message) {
    Clipboard.setData(ClipboardData(text: message.content));
    Navigator.of(context).pop();
    FocusScope.of(context).unfocus();
  }

  void editMessage(BuildContext context, Message message) {
    _indexOfEditingMessage = messages.indexOf(message);
    _isEditing = true;
    Navigator.of(context).pop();
    controller.text = message.content;
    notifyListeners();
  }

  // UI Helpers
  void _showConnectionToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade400, Colors.red.shade600],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.wifi_off, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Timer(const Duration(seconds: 3), () => overlayEntry.remove());
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    disposeConnectivity();
    super.dispose();
  }
}

