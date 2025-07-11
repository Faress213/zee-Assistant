import 'package:flutter/material.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:newvirus/utils/texts.dart';
import 'package:newvirus/widgets/Assistantmessage.dart';
import 'package:newvirus/widgets/Chatmessage.dart';
import 'package:newvirus/widgets/Usermessage.dart';
import 'package:newvirus/widgets/appAppBar.dart';
import 'package:newvirus/widgets/messagefield.dart';
import 'package:provider/provider.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize system brightness on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().initializeSystemBrightness(context);
    });
    
    List<Message> messages = context.watch<ChatProvider>().messages;

      return Scaffold(
        backgroundColor: context.watch<ChatProvider>().brightness == Brightness.light ? Colors.white : Colors.black,
    appBar: appBar(context),
    body: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
       
        SliverFillRemaining(
          hasScrollBody: true,

          child: Container(
            color:context.watch<ChatProvider>().brightness == 
            Brightness.light ? Colors.white : Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  messages.length <= 1
                      ? const Expanded(
                          child: Center(
                            child: Text("Ask me anything "),
                          ),
                        )
                      : Chatmessage(messages: messages),
                     const Messagefield()

                ],
                
              ),
            ),
          ),
        ),
       
      ],
    ),
  );
  }
}
