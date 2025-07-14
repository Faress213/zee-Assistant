import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:newvirus/widgets/messages_ui/AiMessage.dart';
import 'package:newvirus/widgets/moving_messages/messagecenter.dart';
import 'package:newvirus/widgets/moving_messages/messagefullscreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Assistantmessage extends StatelessWidget {
  const Assistantmessage({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ChatProvider>();
    return Column(
      children: [
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ClipRRect(
                  child: Icon(
                    FontAwesomeIcons.robot,
                    color: AppColors.iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: GestureDetector(
                    onDoubleTap: () {
                      Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          transitionDuration: Duration(milliseconds: 300),
                          reverseTransitionDuration: Duration(milliseconds: 300),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return MessageFullScreen(
                              maxWidth: 1,
                              isFullScreen: true,
                              message: message,
                              provider: provider,
                            );
                          },
                        ));
                       
                    },
                   
                    onLongPress: () {
                       Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          transitionDuration: Duration(milliseconds: 300),
                          reverseTransitionDuration: Duration(milliseconds: 300),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return MessageFullScreen(
                              maxWidth: .7,
                              isFullScreen: false,
                              message: message,
                              provider: provider,
                            );
                          },
                        )
                       );
                       
                    },
                    child: Hero(
                      tag: 'message-${message.content.hashCode}',
                      child: AiMessage(provider: provider, message: message),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}


