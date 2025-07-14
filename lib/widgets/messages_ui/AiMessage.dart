import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AiMessage extends StatelessWidget {
  const AiMessage({
    super.key,
    required this.provider,
    required this.message,
  });

  final ChatProvider provider;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: provider.brightness == Brightness.light
            ? AppColors.messagebubblecolorLIGHTMODE
            : AppColors.messagebubblecolorDARKMODE,
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: MarkdownBody(
              data: message.content,
              styleSheet: MarkdownStyleSheet(
                
                p: TextStyle(
                  fontSize: 16,
                  color: provider.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
                strong:
                    const TextStyle(fontWeight: FontWeight.bold),
                listBullet: TextStyle(
                  fontSize: 16,
                  color: provider.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              onTapLink: (text, href, title) async {
                if (href != null &&
                    await canLaunchUrl(Uri.parse(href))) {
                  await launchUrl(Uri.parse(href),
                      mode: LaunchMode.externalApplication);
                }
              },
              builders: {},
            ),
          )),
    );
  }
}