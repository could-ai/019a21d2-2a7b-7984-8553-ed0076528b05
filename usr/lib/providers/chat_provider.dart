import 'package:flutter/material.dart';

class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String? profilePicture;
  final bool isGroup;
  final bool isPinned;
  final bool isMuted;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.profilePicture,
    this.isGroup = false,
    this.isPinned = false,
    this.isMuted = false,
  });
}

class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final bool isSent;
  final String? mediaUrl;
  final String? mediaType; // 'image', 'video', 'document', 'voice'

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.isSent,
    this.mediaUrl,
    this.mediaType,
  });
}

class ChatProvider extends ChangeNotifier {
  List<Chat> _chats = [
    Chat(
      id: '1',
      name: 'Alice Johnson',
      lastMessage: 'Hey, how are you?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
      profilePicture: 'assets/images/avatar1.png',
    ),
    Chat(
      id: '2',
      name: 'Family Group',
      lastMessage: 'Dinner at 8pm',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 1,
      isGroup: true,
    ),
    Chat(
      id: '3',
      name: 'Bob Smith',
      lastMessage: 'Thanks for the help!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<Message> _messages = [];

  List<Chat> get chats => _chats;
  List<Message> get messages => _messages;

  void addChat(Chat chat) {
    _chats.insert(0, chat);
    notifyListeners();
  }

  void removeChat(String chatId) {
    _chats.removeWhere((chat) => chat.id == chatId);
    notifyListeners();
  }

  void pinChat(String chatId) {
    final index = _chats.indexWhere((chat) => chat.id == chatId);
    if (index != -1) {
      _chats[index] = _chats[index].copyWith(isPinned: !_chats[index].isPinned);
      _sortChats();
      notifyListeners();
    }
  }

  void muteChat(String chatId) {
    final index = _chats.indexWhere((chat) => chat.id == chatId);
    if (index != -1) {
      _chats[index] = _chats[index].copyWith(isMuted: !_chats[index].isMuted);
      notifyListeners();
    }
  }

  void markAsRead(String chatId) {
    final index = _chats.indexWhere((chat) => chat.id == chatId);
    if (index != -1) {
      _chats[index] = _chats[index].copyWith(unreadCount: 0);
      notifyListeners();
    }
  }

  void _sortChats() {
    _chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.lastMessageTime.compareTo(a.lastMessageTime);
    });
  }

  void loadMessages(String chatId) {
    // TODO: Load messages for specific chat
    _messages = [
      Message(
        id: '1',
        chatId: chatId,
        senderId: 'user123',
        content: 'Hello!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        isSent: true,
      ),
      Message(
        id: '2',
        chatId: chatId,
        senderId: 'other',
        content: 'Hi there!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isSent: false,
      ),
    ];
    notifyListeners();
  }

  void sendMessage(String chatId, String content, {String? mediaUrl, String? mediaType}) {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chatId,
      senderId: 'user123', // Current user
      content: content,
      timestamp: DateTime.now(),
      isSent: true,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
    );
    _messages.add(message);
    
    // Update chat's last message
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(
        lastMessage: content,
        lastMessageTime: DateTime.now(),
      );
      _sortChats();
    }
    
    notifyListeners();
  }
}

extension ChatExtension on Chat {
  Chat copyWith({
    String? id,
    String? name,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    String? profilePicture,
    bool? isGroup,
    bool? isPinned,
    bool? isMuted,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      profilePicture: profilePicture ?? this.profilePicture,
      isGroup: isGroup ?? this.isGroup,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}