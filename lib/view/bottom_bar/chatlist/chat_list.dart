import 'dart:developer';
import 'package:authentication/controller/chat_provider/chat_provider.dart';
import 'package:authentication/view/details/chatpage/chat.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:flutter/material.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ChatList extends StatelessWidget {
  ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context, listen: false).getAllChats();
    log("chat liast");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget().text(data: "Chats"),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ChatProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.myAllChat.length,
          itemBuilder: (context, index) {
            final user = value.myAllChat[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 17),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  "${user.userInfo!.firstname}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  NavigatorHelper().push(
                      context: context,
                      page: ChatPage(userinfo: user.userInfo!));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
