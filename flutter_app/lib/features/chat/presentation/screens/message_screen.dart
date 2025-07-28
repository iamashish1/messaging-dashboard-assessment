import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/core/theme/app_theme_mode_adapter.dart';
import 'package:flutter_app/core/theme/theme_provider.dart';
import 'package:flutter_app/features/dashboard/presentation/internal_tools_screen.dart'
    show InternalToolsScreen;
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/message_input.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _previousMessageCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<ChatProvider>();
    provider.addListener(_handleProviderUpdate);
    _previousMessageCount = provider.messages.length;
  }

  @override
  void dispose() {
    final provider = context.read<ChatProvider>();
    provider.removeListener(_handleProviderUpdate);
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleProviderUpdate() {
    final currentCount = context.read<ChatProvider>().messages.length;
    if (currentCount > _previousMessageCount) {
      _previousMessageCount = currentCount;
      _scrollToBottom();
    }
  }

  Future<void> _scrollToBottom() async {
    if (!_scrollController.hasClients || !mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    _textController.clear();
    context.read<ChatProvider>().sendMessageToAssistant(text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();
    final messages = provider.messages;
    final isTyping = provider.isTyping;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Support Chat'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.mode == AppThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.dashboard),
            tooltip: 'Internal Tools',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InternalToolsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              controller: _scrollController,
              reverse: true,
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                final messageIndex = isTyping ? index - 1 : index;

                if (isTyping && index == 0) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      'Typing...',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                return ChatBubble(message: messages[messageIndex]);
              },
            ),
          ),
          MessageInput(
            onPressed: () => _handleSubmitted(_textController.text),
            controller: _textController,
          ),
        ],
      ),
    );
  }
}
