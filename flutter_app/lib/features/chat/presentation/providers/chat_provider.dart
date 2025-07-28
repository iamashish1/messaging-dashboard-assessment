import 'package:flutter/material.dart';
import 'package:flutter_app/features/chat/domain/entities/message.dart';
import 'package:flutter_app/features/chat/domain/repositories/message_repository.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  final MessageRepository _messageRepository;

  bool _isTyping = false;
  bool get isTyping => _isTyping;

  List<Message> get messages => List.unmodifiable(_messages);

  ChatProvider(this._messageRepository) {
    _initializeChat();
  }
  // Initializes the chat by loading initial messages
  // If no messages are found, adds a welcome message
  Future<void> _initializeChat() async {
    final storedMessages = await _messageRepository.getInitialMessages();
    _messages.addAll(storedMessages);

    if (storedMessages.isEmpty) {
      _messages.insert(
        0,
        Message(
          text: "Hello! Welcome to our support chat. How may I assist you?",
          timestamp: DateTime.now(),
          sender: MessageSender.agent,
        ),
      );
    }
    notifyListeners();
  }
//Method to send a message to the assistant
//Receives user input, adds it to the message list, and fetches a reply from the assistant
  Future<void> sendMessageToAssistant(String text) async {
    final userMessage = Message(
      text: text,
      timestamp: DateTime.now(),
      sender: MessageSender.user,
    );

    _messages.insert(0, userMessage);
    notifyListeners();

    _isTyping = true;
    notifyListeners();

    final replyFromAssistant = await _messageRepository.sendMessage(
      userMessage,
    );

    _isTyping = false;
    notifyListeners();

    _messages.insert(0, replyFromAssistant);
    notifyListeners();
  }
}
