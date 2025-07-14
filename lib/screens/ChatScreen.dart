import 'package:flutter/material.dart';
import 'package:newvirus/models/Message.dart';
import 'package:newvirus/providers/ChatProvider.dart';
import 'package:newvirus/widgets/drawer/draweritems.dart';
import 'package:newvirus/widgets/messages_ui/Chatmessage.dart';
import 'package:newvirus/widgets/appAppBar.dart';
import 'package:newvirus/widgets/textfield.dart';
import 'package:provider/provider.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize system brightness on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().setBrightness(Theme.of(context).brightness);
    });
    
    List<Message> messages = context.watch<ChatProvider>().messages;
    final provider = context.watch<ChatProvider>();
      return SafeArea(
        child: Scaffold(
          endDrawerEnableOpenDragGesture: true,
          onEndDrawerChanged: (isOpened) {
            if(isOpened){
              FocusScope.of(context).unfocus();
            }
          },
          endDrawer:  Drawer(
            
            width: MediaQuery.sizeOf(context).width*.65,
            child: Draweritems()
          ),
          backgroundColor: context.watch<ChatProvider>().brightness == Brightness.light ? Colors.white : Colors.black,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Builder(
                
                builder: (context) {
                  return appBar(context,(){
                    Scaffold.of(context).openEndDrawer();
                  });
                }
              ),
            ),
            body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
         
          SliverFillRemaining(
            hasScrollBody: true,
        
            child: Container(
              color:context.watch<ChatProvider>().brightness == 
              Brightness.light ? Colors.white : Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    messages.length <= 1
                        ? const Expanded(
                            child: Center(
                              child: Text("Ask me anything "),
                            ),
                          )
                        : Chatmessage(messages: messages),
                    if (provider.isEditing)
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  context.watch<ChatProvider>().controller.text,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(onPressed: (){
                              provider.setEditing(false);
                              provider.notifyListeners();
                            }, icon: Icon(Icons.close))
                          ],
                        ),
                      ),
                   const SizedBox(height: 10,),
                       const Messagefield()
        
                  ]
                  
                ),
              ),
            ),
          ),
         
        ],
            ),
          ),
          
          
      );
  }
}
