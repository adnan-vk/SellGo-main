import 'dart:developer';

import 'package:authentication/model/authmodel.dart';
import 'package:authentication/model/message_model.dart';
import 'package:authentication/service/authentication/auth_service.dart';
import 'package:authentication/service/chat_service/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:authentication/utils/utils.dart';
import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();
  ChatService chatService = ChatService();
  AuthService userservice = AuthService();
  late ScrollController scrollController;
  List<MessageModel> allMessage = [];
  List<MessageModel> myAllChat = [];

  sendMessage(String receiverId) async {
    await createChat(receiverId);
    final data = MessageModel(
        senderId: firebaseAuth.currentUser!.uid,
        recieverId: receiverId,
        message: messageController.text,
        timestamp: DateTime.now());
    await chatService.sendMessage(data);
    messageController.clear();
    getAllChats();
    getMessages(receiverId);
  }

  getMessages(String receiverId) async {
    allMessage.clear();
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        await chatService.getMessages(receiverId);
    snapshot.listen((message) {
      allMessage =
          message.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
      scrollDown();
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

  getAllChats() async {
    List<UserModel> allUser = await userservice.getAllUser();
    List<MessageModel> allChats = [];
    myAllChat.clear();
    try {
      allChats = await chatService.getAllChats();
      for (var chat in allChats) {
        if (chat.senderId == firebaseAuth.currentUser!.uid ||
            chat.recieverId == firebaseAuth.currentUser!.uid) {
          UserModel? user = allUser.firstWhere(
              (user) =>
                  user.uId == chat.recieverId ||
                  user.uId == chat.senderId &&
                      user.uId != firebaseAuth.currentUser!.uid,
              orElse: () => UserModel());
          // List<MessageModel> message = await getMessages(user.uId!);

          final chatInfo = MessageModel(
              message: /* message[0].message ??  */ 'No Messages',
              userInfo: user);
          myAllChat.add(chatInfo);
          notifyListeners();
        }
      }
    } catch (e) {
      log("Error from Get all chats : ${e.toString()}");
    }
  }
}
