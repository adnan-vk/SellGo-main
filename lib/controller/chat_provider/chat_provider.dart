import 'dart:developer';

import 'package:authentication/model/message_model.dart';
import 'package:authentication/service/chat_service/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:authentication/utils/utils.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();
  ChatService chatService = ChatService();
  late ScrollController scrollController;
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
    notifyListeners();
  }

  getMessages(String receiverId) async {
    allMessage.clear();
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        await chatService.getMessages(receiverId);
    snapshot.listen((message) {
      allMessage =
          message.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
      log("all messages are  : ${allMessage.length}");
      notifyListeners();
    });
  }

  createChat(String receiverId) async {
    String chatRoomId = await generateChatRoomId(
        uId1: firebaseAuth.currentUser!.uid, uId2: receiverId);

    final data = MessageModel(
      chatRoomId: chatRoomId,
      recieverId: receiverId,
      senderId: firebaseAuth.currentUser!.uid,
      timestamp: DateTime.now(),
    );
    return await chatService.createChat(data);
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
}
