import 'package:authentication/widgets/text_widget.dart';
import 'package:flutter/material.dart';

enum MessageType {
  Sent,
  Received,
}

class MessageWidget extends StatelessWidget {
  final String message;
  final MessageType messageType;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: messageType == MessageType.Sent
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              messageType == MessageType.Sent ? Colors.grey[200] : Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextWidget().text(
          data: message,
          size: size.width * .04,
          color: messageType == MessageType.Sent ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
