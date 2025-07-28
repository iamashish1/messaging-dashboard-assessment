/* MESSAGE ENTITY
   - Represents a message in the chat application
   - Contains text, timestamp, and sender type
   - Used throughout the app to manage chat messages
 */

import 'package:hive_flutter/hive_flutter.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
enum MessageSender {
  @HiveField(0)
  user,
  @HiveField(1)
  agent,
}

@HiveType(typeId: 1)
class Message {
  @HiveField(2)
  final String text;
  @HiveField(3)
  final DateTime timestamp;
  @HiveField(4)
  final MessageSender sender;

  Message({required this.text, required this.timestamp, required this.sender});
}
