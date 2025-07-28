import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/date_formats.dart';
import 'package:flutter_app/features/chat/domain/entities/message.dart'
    show Message, MessageSender;

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  bool get isUser => message.sender == MessageSender.user;

  Color get bubbleColor =>
      isUser ? Colors.blueAccent.shade200 : Colors.grey.shade200;

  Color get textColor => isUser ? Colors.white : Colors.black87;

  Alignment get alignment =>
      isUser ? Alignment.centerRight : Alignment.centerLeft;

  BorderRadius get borderRadius => BorderRadius.only(
    topLeft: const Radius.circular(16),
    topRight: const Radius.circular(16),
    bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
    bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(16),
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: borderRadius,
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message.text,
                style: TextStyle(color: textColor, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 4.0,
                left: isUser ? 0 : 8.0,
                right: isUser ? 8.0 : 0,
              ),
              child: Text(
                AppDateFormats.timeOnly.format(message.timestamp),
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
