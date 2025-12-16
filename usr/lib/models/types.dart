class Character {
  final String id;
  final String name;
  final String description;
  final String personality;
  final String avatarColor; // Storing as string for simplicity (e.g., "0xFF...")

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.personality,
    required this.avatarColor,
  });
}

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
