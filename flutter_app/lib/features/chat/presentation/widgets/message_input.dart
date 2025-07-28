import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final void Function()? onPressed;
  final TextEditingController controller;
  const MessageInput({super.key, this.onPressed, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.send), onPressed: onPressed),
        ],
      ),
    );
  }
}
