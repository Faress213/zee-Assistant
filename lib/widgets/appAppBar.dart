import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/utils/colors.dart';
import 'package:newvirus/utils/texts.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget appBar(BuildContext context) {
 bool isOnline = context.watch<ChatProvider>().isOnline;
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 1,
    leading: const Icon(
      FontAwesomeIcons.robot,
      color: AppColors.iconColor,
      size: 20,
    ),
    titleSpacing: 2,
    title: const Text(
      Texts.appname,
      style: TextStyle(
          color: AppColors.iconColor, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    actions: [
       CircleAvatar(radius: 3, backgroundColor: isOnline? Colors.green:Colors.red),
      const SizedBox(
        width: 10,
      ),
       Text(
       isOnline ? "Online" : "Offline",
        style: TextStyle(
            color: isOnline ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        width: 10,
      ),
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      const SizedBox(
        width: 5,
      )
    ],
  );
}
