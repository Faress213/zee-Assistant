import 'package:flutter/material.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/screens/ChatScreen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const zeeAssistant());
}

class zeeAssistant extends StatefulWidget {
  const zeeAssistant({super.key});

  @override
  State<zeeAssistant> createState() => _zeeAssistantState();
}

class _zeeAssistantState extends State<zeeAssistant> {
  late ChatProvider chatProvider;

  @override
  void initState() {
    super.initState();
    chatProvider = ChatProvider();
    // Start monitoring internet connectivity when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatProvider.checkChatStatus(context);
    });
  }

  @override
  void dispose() {
    // Stop monitoring when app closes
    chatProvider.disposeConnectionListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Follows system theme
      home: ChangeNotifierProvider.value(
        value: chatProvider,
        child: Chatscreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
