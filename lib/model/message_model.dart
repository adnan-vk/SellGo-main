import 'package:authentication/model/authmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? message; 
  String? senderId;
  String? recieverId;
  DateTime? timestamp;
  UserModel? userInfo;
  String? chatRoomId;

  MessageModel({
    this.message,
    this.recieverId,
    this.senderId,
    this.timestamp,
    this.userInfo,
    this.chatRoomId,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
        message: json["content"],
        recieverId: json["recieverId"],
        senderId: json["senderId"],
        timestamp: json['timestamp'] != null
            ? (json['timestamp'] as Timestamp).toDate()
            : null,
        chatRoomId: json['chatroomid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "content": message,
      "recieverId": recieverId,
      "senderId": senderId,
      "timestamp": timestamp,
      "chatroomid": chatRoomId,
    };
  }
}
