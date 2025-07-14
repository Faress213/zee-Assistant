import 'package:flutter/material.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/screens/ChatScreen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Get initial brightness BEFORE runApp
  final systemBrightness = WidgetsBinding.instance.window.platformBrightness;

  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final provider = ChatProvider();
        provider.setBrightness(systemBrightness); // Immediate set
        provider.initializeConnectivity();
        return provider;
      },
      child: const ZeeAssistant(),
    ),
  );
}

class ZeeAssistant extends StatelessWidget {
  const ZeeAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Follows system theme
      debugShowCheckedModeBanner: false,
      home: const Chatscreen(),
    );
  }
}
