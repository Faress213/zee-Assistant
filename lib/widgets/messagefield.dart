import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:provider/provider.dart';

class Messagefield extends StatelessWidget {
  const Messagefield({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: provider.controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: "Ask anything...",
                hintStyle: TextStyle(
                  color: isDark ? Colors.white54 : Colors.grey,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          provider.isLoading
              ?  SizedBox(
                  height: 30,
                  width: 30,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Lottie.asset('assets/animation/animation.json'),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    context.read<ChatProvider>().sendMessage(context);
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.iconColor,
                    child: const Icon(Icons.send, size: 18, color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }
}
