import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/widgets/messages_ui/Assistantmessage.dart';
import 'package:newvirus/widgets/moving_messages/LoadingMessage.dart';
import 'package:newvirus/widgets/messages_ui/Usermessage.dart';
import 'package:provider/provider.dart';

class Chatmessage extends StatefulWidget {
  const Chatmessage({super.key, required this.messages});
  final List<Message> messages;

  @override
  State<Chatmessage> createState() => _ChatmessageState();
}

class _ChatmessageState extends State<Chatmessage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();

    return Expanded(
      child: ListView.builder(
        controller: provider.scrollController,
        itemCount: widget.messages.length + (provider.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if(index==0) return SizedBox.shrink();
          if (index == widget.messages.length && provider.isLoading) {
            return  AssistantmessageLoading();
          }

          final message = widget.messages[index];
          return message.role == Role.user
              ? Usermessage(message: message)
              : Assistantmessage(message: message);
        },
      ),
    );
  }
}
