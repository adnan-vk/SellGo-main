import 'dart:developer';

import 'package:authentication/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String chatCollection = 'Chats';
  Reference storage = FirebaseStorage.instance.ref();
  String generateChatRoomId({
    required String uId1,
    required String uId2,
  }) {
    List<String> uIds = [uId1, uId2];
    uIds.sort();
    String chatId = uIds.join();
    return chatId;
  }

  sendMessage(MessageModel data) async {
    String chatRoomId = generateChatRoomId(
        uId1: firebaseAuth.currentUser!.uid, uId2: data.recieverId!);
    String senderId =
        data.senderId! + DateTime.now().millisecondsSinceEpoch.toString();
    log(chatRoomId);
    try {
      await firestore
          .collection(chatCollection)
          .doc(chatRoomId)
          .collection("Messeges")
          .doc(senderId)
          .set(data.toJson());
    } catch (e) {
      throw e;
    }
    ;
  }

  Future<List<MessageModel>> getMessages(String receiverId) async {
    try {
      List<MessageModel> messages = [];
      String chatRoomId = generateChatRoomId(
          uId1: firebaseAuth.currentUser!.uid, uId2: receiverId);
      var snapshot = await firestore
          .collection(chatCollection)
          .doc(chatRoomId)
          .collection('Messeges')
          .orderBy('timeStamp', descending: false)
          .get();

      messages = snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();

      return messages;
    } catch (e) {
      throw e;
    }
  }

  // Future<List<MessageModel>> getAllChat(String receiverId) async {
  //   try {
  //     List<MessageModel> messages = [];
  //     String chatRoomId = generateChatRoomId(
  //         uId1: firebaseAuth.currentUser!.uid, uId2: receiverId);
  //     var snapshot = await firestore
  //         .collection(chatCollection)
  //         .doc(chatRoomId)
  //         .collection('Messeges')
  //         .orderBy('timeStamp', descending: true)
  //         .get();

  //     return messages;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
