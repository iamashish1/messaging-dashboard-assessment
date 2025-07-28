/* GET INITIAL MESSAGES USE CASE
   - Fetches initial messages from the message repository
   - Implements UseCase interface with NoParams
   - Returns a list of Message entities
*/

import 'package:flutter_app/core/usecase/usecase.dart' show NoParams, UseCase;
import 'package:flutter_app/features/chat/domain/entities/message.dart';
import 'package:flutter_app/features/chat/domain/repositories/message_repository.dart';

class GetinitialMessage implements UseCase<List<Message>, NoParams> {
  final MessageRepository repository;

  GetinitialMessage(this.repository);

  @override
  Future<List<Message>> call(NoParams params) async {
    return await repository.getInitialMessages();
  }
}
