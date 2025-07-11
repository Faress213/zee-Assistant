import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newvirus/providers/ChatProvider.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final ChatProvider provider;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: provider.brightness == Brightness.light
              ? Colors.white.withOpacity(0.9)
              : Colors.grey[800]?.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: provider.brightness == Brightness.light
                  ? Colors.black87
                  : Colors.white,
              size: 15,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: provider.brightness == Brightness.light
                    ? Colors.black87
                    : Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
