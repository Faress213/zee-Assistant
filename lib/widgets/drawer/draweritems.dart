import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/screens/About.dart';
import 'package:provider/provider.dart';

class Draweritems extends StatelessWidget {
  const Draweritems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Column(
          children: [
            Icon(FontAwesomeIcons.robot),
            SizedBox(
              height: 10,
            ),
            Text("Zee Assistant"),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        ListTile(
          title: Text("Home"),
          trailing: Icon(Icons.home),
          onTap: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
        ),
        
        Divider(),
        ListTile(
          title: Text("About"),
          trailing: Icon(Icons.info),
          onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }
}
