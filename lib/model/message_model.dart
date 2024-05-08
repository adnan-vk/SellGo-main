class MessageModel {
  String? message;
  String? senderId;
  String? senderemail;
  String? recieverId;
  DateTime? timestamp;

  MessageModel({
    this.message,
    this.recieverId,
    this.senderId,
    this.timestamp,
    this.senderemail,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderemail: json["senderemail"],
      message: json["content"],
      recieverId: json["recieverId"],
      senderId: json["senderId"],
      timestamp: json["timestamp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderemail': senderemail,
      "content": message,
      "recieverId": recieverId,
      "senderId": senderId,
      "timestamp": timestamp,
    };
  }
}
