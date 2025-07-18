import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newvirus/main.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:newvirus/widgets/moving_messages/messagecenter.dart';
import 'package:provider/provider.dart';

class Usermessage extends StatelessWidget {
  const Usermessage({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ChatProvider>();
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: GestureDetector(
                    onLongPress: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          transitionDuration: const Duration(milliseconds: 300),
                          reverseTransitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return MessageCenterAnimation(
                              maxWidth: .7,
                              message: message,
                              provider: provider,
                            );
                          },
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'message-${message.content.hashCode}',
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: provider.brightness == Brightness.light
                              ? AppColors.messagebubblecolorLIGHTMODE
                              : AppColors.messagebubblecolorDARKMODE,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              message.content,
                              style: TextStyle(
                                  color: provider.brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const ClipRRect(
                  child: Icon(
                    Icons.person,
                    color: AppColors.iconColor,
                    size: 20,
                  ),
                  clipBehavior: Clip.none,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

