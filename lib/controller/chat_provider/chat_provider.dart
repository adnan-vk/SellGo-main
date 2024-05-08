import 'dart:developer';

import 'package:authentication/model/message_model.dart';
import 'package:authentication/service/chat_service/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();
  ChatService chatService = ChatService();
  // late ScrollController scrollController;
  List<MessageModel> allMessage = [];

  sendMessage(String receiverId) async {
    final data = MessageModel(
        senderId: firebaseAuth.currentUser!.uid,
        recieverId: receiverId,
        message: messageController.text,
        timestamp: DateTime.now());
    await chatService.sendMessage(data);
    messageController.clear();
    getMessages(receiverId);
    log("$allMessage");
  }

  getMessages(String recieverId) async {
    String chatRoomId = chatService.generateChatRoomId(
        uId1: firebaseAuth.currentUser!.uid, uId2: recieverId);
    await chatService.firestore
        .collection("Chats")
        .doc(chatRoomId)
        .collection('Messeges')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .listen((message) {
      allMessage =
          message.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
      // scrollDown();
      notifyListeners();
    });
  }

  // void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (scrollController.hasClients) {
  //         scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //       }
  //     });
}
