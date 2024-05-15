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
    Provider.of<ChatController>(context, listen: false).getAllChats();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget().text(data: "Chats"),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ChatController>(
        builder: (context, value, child) => value.myAllChat.isEmpty
            ? Center(child: Text("No chats available"))
            : ListView.builder(
                itemCount: value.myAllChat.length,
                itemBuilder: (context, index) {
                  final user = value.myAllChat[index];
                  // final lastmessage = value.allMessage[0];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage:
                            NetworkImage(user.userInfo!.image ?? ''),
                        child: user.userInfo!.image == null
                            ? Icon(Icons.person, color: Colors.white)
                            : null,
                      ),
                      title: TextWidget().text(
                          data: user.userInfo!.firstname,
                          size: 18.0,
                          weight: FontWeight.bold),
                      // subtitle: Text(
                      //   "Last message: ${lastmessage}",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey[600],
                      //   ),
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      onTap: () {
                        NavigatorHelper().push(
                          context: context,
                          page: ChatPage(userinfo: user.userInfo!),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
