/*LOCAL DATA SOURCE
   - Uses Hive to store and retrieve messages
   - Provides methods to get messages and add new messages
 */

import 'package:flutter_app/core/constants/app_constants.dart';
import 'package:hive_flutter/hive_flutter.dart' show Box, Hive;

import '../../domain/entities/message.dart';



class LocalMessageDataSource {
  final Box<Message> _box = Hive.box<Message>(AppConstants.hiveBoxName);

  List<Message> getMessages() {
    final messages = _box.values.toList();
    return messages.reversed.toList(); 
  }

  Future<Message> addMessage(Message message) async {
    await _box.add(message);
    
    await Future.delayed(const Duration(seconds: 1));
    final agentResponse = getAgentResponse();
    await _box.add(agentResponse);
    return agentResponse;
  }

 /* SIMULATE AGENT RESPONSE
  - Shuffle a predefined list of responses
  - Return the first item from a predefined list of responses
 */
  Message getAgentResponse() {
   
    final responses = [
      "Thanks for reaching out! How can I help you today?",
      "Let me look into that for you.",
      "Could you please provide more details?",
      "I'm connecting you with a specialist. Please wait a moment.",
      "Got it! I'll do my best to assist you.",
      "Is there anything else I can help with?",
      "Sorry, I didn't quite catch that.",
      "We appreciate your patience!",
    ];

    responses.shuffle();
    final agentMessage = Message(
      text: responses.first,
      timestamp: DateTime.now(),
      sender: MessageSender.agent,
    );

    return agentMessage;
  }
} 