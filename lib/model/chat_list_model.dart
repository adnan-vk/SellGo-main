class ChatListModel {
  String? senderId;
  String? recieverId;
  String? chatRoomId;
  DateTime? timestamp; 

  ChatListModel(
      {this.recieverId, this.chatRoomId, this.senderId, this.timestamp});

  factory ChatListModel.fromJson(json) {
    return ChatListModel(
        recieverId: json["recieverId"],
        senderId: json["recieverId"],
        timestamp:
            json['timestamp'] != null ? (json['timestamp']).toDate() : null,
        chatRoomId: json['chatroomid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "recieverId": recieverId,
      "senderId": senderId,
      "timestamp": timestamp,
      "chatroomid": chatRoomId,
    };
  }
}
