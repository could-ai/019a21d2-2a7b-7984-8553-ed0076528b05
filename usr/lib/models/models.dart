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

class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final bool isSent;
  final String? mediaUrl;
  final String? mediaType;

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

class Community {
  final String id;
  final String name;
  final String description;
  final String coverImage;
  final int memberCount;
  final bool isJoined;
  final bool isAdmin;
  final List<String> rules;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.memberCount,
    this.isJoined = false,
    this.isAdmin = false,
    this.rules = const [],
  });
}