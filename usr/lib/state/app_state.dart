import 'package:flutter/material.dart';
import '../models/types.dart';

class AppState extends ChangeNotifier {
  // Singleton pattern for easy access
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  bool _isGuest = true;
  bool get isGuest => _isGuest;

  final List<Character> _characters = [
    Character(
      id: '1',
      name: 'Wise Wizard',
      description: 'A mysterious wizard who knows the secrets of the universe.',
      personality: 'Cryptic, wise, patient, speaks in riddles.',
      avatarColor: '0xFF673AB7', // Deep Purple
    ),
    Character(
      id: '2',
      name: 'Cyber Punk',
      description: 'A rebel hacker from the year 2077.',
      personality: 'Sarcastic, tech-savvy, rebellious, uses slang.',
      avatarColor: '0xFF00BCD4', // Cyan
    ),
  ];

  List<Character> get characters => _characters;

  // Map to store chat history for each character ID
  final Map<String, List<ChatMessage>> _chatHistories = {};

  List<ChatMessage> getChatHistory(String characterId) {
    if (!_chatHistories.containsKey(characterId)) {
      _chatHistories[characterId] = [];
    }
    return _chatHistories[characterId]!;
  }

  void login() {
    _isGuest = false;
    notifyListeners();
  }

  void logout() {
    _isGuest = true;
    notifyListeners();
  }

  void addCharacter(Character character) {
    _characters.add(character);
    notifyListeners();
  }

  void addMessage(String characterId, ChatMessage message) {
    if (!_chatHistories.containsKey(characterId)) {
      _chatHistories[characterId] = [];
    }
    _chatHistories[characterId]!.add(message);
    notifyListeners();
  }
}
