/* ACTUAL REPOSITORY IMPLEMENTATION
   - Uses LocalMessageDataSource to fetch and send messages
 */

import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../data_sources/local_data_source.dart';

class MessageRepositoryImpl implements MessageRepository {
  final LocalMessageDataSource dataSource;

  MessageRepositoryImpl(this.dataSource);

  @override
  Future<List<Message>> getInitialMessages() async {
    return dataSource.getMessages();
  }

  @override
  Future<Message> sendMessage(Message message) async {
    return dataSource.addMessage(message);
  }
}
