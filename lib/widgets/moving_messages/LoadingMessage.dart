import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:provider/provider.dart';

class AssistantmessageLoading extends StatelessWidget {
  const AssistantmessageLoading({super.key});

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
                      child: Lottie.asset('assets/animation/animation.json',height: 30,width: 30),
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