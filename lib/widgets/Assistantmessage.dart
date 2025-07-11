import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:provider/provider.dart';

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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: provider.brightness == Brightness.light
                          ? AppColors.messagebubblecolorLIGHTMODE
                          : AppColors.messagebubblecolorDARKMODE,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MarkdownBody(
                        data: message.content,
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            fontSize: 16,
                            color: provider.brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          strong: const TextStyle(fontWeight: FontWeight.bold),
                          listBullet: TextStyle(
                            fontSize: 16,
                            color: provider.brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
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

