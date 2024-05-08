import 'dart:developer';

import 'package:authentication/controller/chat_provider/chat_provider.dart';
import 'package:authentication/model/authmodel.dart';
import 'package:authentication/service/chat_service/chat_service.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/text_widget.dart';
import '../call/call.dart';
import 'widgets/message_widget.dart';

class ChatPage extends StatefulWidget {
  UserModel? userinfo;
  ChatPage({Key? key, this.userinfo}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatservice = ChatService();

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).messageController =
        TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: TextWidget().text(data: "John", size: size.width * .05),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              NavigatorHelper().pop(context: context);
            },
            icon: Icon(EneftyIcons.arrow_left_3_outline)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallingPage(),
                    ));
              },
              icon: Icon(EneftyIcons.call_outline),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, value, child) => ListView.builder(
                  itemCount: value.allMessage.length,
                  itemBuilder: (context, index) {
                    // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                    // bool isSender = value.allMessage[index].senderId ==
                    //     firebaseAuth.currentUser!.uid;
                    // DateTime timestamp = value.allMessage[index].timestamp!;
                    // String formattedTime =
                    //     DateFormat("hh:mm:ss").format(timestamp);
                    return MessageWidget(
                      message: value.allMessage[index].message!,
                      messageType: index % 2 == 0
                          ? MessageType.Sent
                          : MessageType.Received,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: pro.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (pro.messageController.text.isNotEmpty) {
                        await pro.sendMessage(widget.userinfo?.uId ?? "");
                        log("message sent");
                      } else {
                        log("message is empty");
                      }
                    },
                    icon: Icon(EneftyIcons.send_3_outline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
