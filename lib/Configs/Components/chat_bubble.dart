import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for formatting timestamp

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final DateTime timestamp; // Add a timestamp property

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isCurrentUser ? const Color(0xff028A0F) : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column( // Wrap message and timestamp in a Column
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
          children: [
            Text(message, style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 1), // Add some spacing between text and timestamp
            Text(
              DateFormat('hh:mm a').format(timestamp), // Format timestamp for time
              style: const TextStyle(color: Colors.white70, fontSize: 10), // Smaller, lighter text
            ),
          ],
        ),
      ),
    );
  }
}
