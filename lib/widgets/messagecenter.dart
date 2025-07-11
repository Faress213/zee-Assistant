
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:newvirus/widgets/actionbutton.dart';

class MessageCenterAnimation extends StatelessWidget {
  final Message message;
  final ChatProvider provider;

  const MessageCenterAnimation({
    Key? key,
    required this.message,
    required this.provider,
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
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: provider.brightness == Brightness.light
                              ? AppColors.messagebubblecolorLIGHTMODE
                              : AppColors.messagebubblecolorDARKMODE,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          message.content,
                          style: TextStyle(
                            color: provider.brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Action buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Copy button
                      ActionButton(
                        icon: Icons.copy,
                        label: 'Copy',
                        provider: provider,
                        onTap: () {
                         provider.Copymessage(context,message);
                        },
                      ),
                      const SizedBox(height: 13),
                      // Edit button
                      ActionButton(
                        icon: Icons.edit,
                        label: 'Edit',
                        provider: provider,
                        onTap: () {

                           provider.Editmessage(context,message);
                        },
                      ),
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
