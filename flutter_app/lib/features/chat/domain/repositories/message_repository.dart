import 'package:flutter_app/features/chat/domain/entities/message.dart';

abstract class MessageRepository {
  Future<Message> sendMessage(Message text);
  Future<List<Message>> getInitialMessages();
}
