import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newvirus/utils/texts.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Icon(
                  FontAwesomeIcons.robot,
                  size: 40,
                ),
                const Spacer(),
                Container(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Text(Texts.about)),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Icon(
                  FontAwesomeIcons.phone,
                  size: 40,
                ),
                const Spacer(),
                Container(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Column(
                      children: [
                        Text("Contact us at "),
                        FittedBox(
                            child: GestureDetector(
                              onTap: (){
                                launchUrl(Uri.parse("mailto:fareskaram268@gmail.com"));
                              },
                              child: Text(
                                                        "fareskaram268@gmail.com",
                                                        style: TextStyle(color: Colors.blue),
                                                      ),
                            )),
                      ],
                    )),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
