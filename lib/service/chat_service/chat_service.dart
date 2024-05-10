import 'dart:developer';

import 'package:authentication/model/message_model.dart';
import 'package:authentication/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String chatCollection = 'Chats';
  Reference storage = FirebaseStorage.instance.ref();

  sendMessage(MessageModel data) async {
    String chatRoomId = generateChatRoomId(
        uId1: firebaseAuth.currentUser!.uid, uId2: data.recieverId!);
    String senderId =
        data.senderId! + DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await firestore
          .collection(chatCollection)
          .doc(chatRoomId)
          .collection("Messeges")
          .doc(senderId)
          .set(data.toJson());
      log(firebaseAuth.currentUser!.uid);
      log(data.recieverId!);
      log(chatRoomId);
    } catch (e) {
      throw e;
    }
    ;
  }

  createChat(MessageModel data) async {
    try {
      await firestore
          .collection(chatCollection)
          .doc(data.chatRoomId)
          .set(data.toJson());
      log('chat created');
    } catch (e) {
      throw e;
    }
    ;
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getMessages(
      String receiverId) async {
    try {
      String chatRoomId = generateChatRoomId(
          uId1: firebaseAuth.currentUser!.uid, uId2: receiverId);
      log("getMessages : ${chatRoomId}");
      var snapshot = await firestore
          .collection("Chats")
          .doc(chatRoomId)
          .collection('Messeges')
          .orderBy('timestamp', descending: true)
          .snapshots();
      return snapshot;
    } catch (e) {
      throw e;
    }
  }
}
