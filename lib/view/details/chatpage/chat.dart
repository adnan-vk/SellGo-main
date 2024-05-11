// ignore_for_file: must_be_immutable

import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/chat_provider/chat_provider.dart';
import 'package:authentication/model/authmodel.dart';
import 'package:authentication/service/chat_service/chat_service.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../widgets/text_widget.dart';
import '../call/call.dart';

class ChatPage extends StatefulWidget {
  UserModel userinfo;
  ChatPage({Key? key, required this.userinfo}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatservice = ChatService();

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).scrollController =
        ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<ChatProvider>(context, listen: false);
    final authpro = Provider.of<AuthenticationProvider>(context, listen: false);
    pro.getMessages(widget.userinfo.uId!);
    return Scaffold(
      appBar: AppBar(
        title: TextWidget()
            .text(data: authpro.sortedUser!.firstname, size: size.width * .05),
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
                builder: (context, value, child) {
                  return value.allMessage.isEmpty
                      ? Center(
                          child: Text('Type a message...'),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: value.allMessage.length,
                          itemBuilder: (context, index) {
                            FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                            bool isSender = value.allMessage[index].senderId ==
                                firebaseAuth.currentUser!.uid;
                            DateTime timestamp =
                                value.allMessage[index].timestamp!;
                            String formattedTime =
                                DateFormat('hh:mm a').format(timestamp);
                            return ChatBubble(
                              isSent: isSender,
                              message: value.allMessage[index].message!,
                              time: formattedTime,
                            );
                          },
                        );
                },
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
                        await pro.sendMessage(widget.userinfo.uId!);
                      }
                    },
                    icon: Icon(Icons.send),
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

class MediaQueryWidget {
  double width(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * size;
  }

  double height(BuildContext context, double size) {
    return MediaQuery.of(context).size.height * size;
  }
}

class ChatBubble extends StatelessWidget {
  final bool isSent;
  final String message;
  final String time;

  const ChatBubble({
    Key? key,
    required this.isSent,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQueryWidget().width(context, .03),
          top: MediaQueryWidget().width(context, .03),
          left: isSent
              ? MediaQueryWidget().width(context, .15)
              : MediaQueryWidget().width(context, .03),
          right: isSent
              ? MediaQueryWidget().width(context, .03)
              : MediaQueryWidget().width(context, .15)),
      child: Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(MediaQueryWidget().width(context, .03)),
          decoration: BoxDecoration(
            color: isSent
                ? Color.fromARGB(255, 188, 223, 238)
                : Color.fromARGB(255, 76, 147, 94),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MediaQueryWidget().width(context, .045)),
              topRight:
                  Radius.circular(MediaQueryWidget().width(context, .045)),
              bottomLeft: isSent
                  ? Radius.circular(MediaQueryWidget().width(context, .045))
                  : Radius.circular(MediaQueryWidget().width(context, .01)),
              bottomRight: isSent
                  ? Radius.circular(MediaQueryWidget().width(context, .01))
                  : Radius.circular(MediaQueryWidget().width(context, .045)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              // TextsWidget().costumParagraphText(context,
              //     text: message,
              //     bold: false,
              //     trimLength: 300,
              //     textAlign: TextAlign.justify,
              //     color: isSent ? Colors.black : Colors.white),
              SizedBox(height: MediaQueryWidget().width(context, .02)),
              Text(time),
              // CustomText(
              //     text: time,
              //     bold: false,
              //     size: 13,
              //     textAlign: TextAlign.right,
              //     color: isSent ? Colors.black : Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
