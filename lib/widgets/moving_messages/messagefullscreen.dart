
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:newvirus/widgets/actionbutton.dart';

class MessageFullScreen extends StatelessWidget {
  final Message message;
  final ChatProvider provider;
  final double maxWidth;
  final double ?maxHeight;
  final bool isFullScreen;
  

  const MessageFullScreen({
    Key? key,
   
    required this.message,
    required this.provider, required this.maxWidth, this.maxHeight, required this.isFullScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
        
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Tap anywhere to close
          GestureDetector(
            onTap: () { 
              Navigator.of(context).pop();
              FocusScope.of(context).unfocus();
            },
          
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
          // Centered message with actions
          Center(
            child: GestureDetector(
              onTap: () {}, // Prevent background tap from propagating
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hero animated message
                  Hero(
                    tag: 'message-${message.content.hashCode}',
                    child: Material(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * maxWidth,
                            
                           
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: provider.brightness == Brightness.light
                                ? AppColors.messagebubblecolorLIGHTMODE
                                : AppColors.messagebubblecolorDARKMODE,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: MarkdownBody(
                          
                            data: message.content,
                            styleSheet: MarkdownStyleSheet(
                              p: TextStyle(
                                color: provider.brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                                                   
                          ),
                        ),
                      ),
                    ),
                  ),
                !isFullScreen?  const SizedBox(width: 14):SizedBox.shrink(),
                  // Action buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Copy button
                   ! isFullScreen? ActionButton(
                        icon: Icons.copy,
                        label: 'Copy',
                        provider: provider,
                        onTap: () {
                         provider.copyMessage(context, message);
                        },
                      ):SizedBox.shrink(),
                     
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 

 
}
