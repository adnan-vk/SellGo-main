import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType { chat, product, payment }

class NotificationModel {
  String? senderId;
  String? id;
  String? receiverId;
  String? title;
  NotificationType? type;
  String? content;
  DateTime? timeStamp;

  NotificationModel({
    this.senderId,
    this.id,
    this.receiverId,
    this.title,
    this.type,
    this.content,
    this.timeStamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      senderId: json['senderId'],
      id: json['id'],
      type: _parseNotificationType(json['type']),
      receiverId: json['receiverId'],
      title: json['title'],
      content: json['content'],
      timeStamp: json['timeStamp'] != null
          ? (json['timeStamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'id': id,
      'receiverId': receiverId,
      'type': type?.toString().split('.').last,
      'title': title,
      'content': content,
      'timeStamp': timeStamp,
    };
  }

  static NotificationType _parseNotificationType(String? type) {
    switch (type) {
      case 'chat':
        return NotificationType.chat;
      case 'product':
        return NotificationType.product;
      case 'payment':
        return NotificationType.payment;
      default:
        return NotificationType.chat;
    }
  }
}
