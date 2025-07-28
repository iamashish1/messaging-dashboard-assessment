/* SEND MESSAGE USE CASE
   - Handles sending messages in the chat application
   - Implements UseCase interface with Message as input and output
   - Uses MessageRepository to send the message
*/

import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/chat/domain/entities/message.dart';
import 'package:flutter_app/features/chat/domain/repositories/message_repository.dart';

class SendMessage implements UseCase<Message, Message> {
  final MessageRepository repository;
  SendMessage(this.repository);

  @override
  Future<Message> call(Message message) async {
    return await repository.sendMessage(message);
  }
}
