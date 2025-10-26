import 'package:flutter/material.dart';

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

class CommunityProvider extends ChangeNotifier {
  List<Community> _communities = [
    Community(
      id: '1',
      name: 'Flutter Developers',
      description: 'A community for Flutter developers to share knowledge and projects.',
      coverImage: 'assets/images/community1.png',
      memberCount: 1250,
      rules: ['Be respectful', 'Share useful content', 'No spam'],
    ),
    Community(
      id: '2',
      name: 'Tech News',
      description: 'Latest technology news and discussions.',
      coverImage: 'assets/images/community2.png',
      memberCount: 3400,
    ),
  ];

  List<Community> get communities => _communities;
  List<Community> get joinedCommunities => _communities.where((c) => c.isJoined).toList();

  void joinCommunity(String communityId) {
    final index = _communities.indexWhere((c) => c.id == communityId);
    if (index != -1) {
      _communities[index] = Community(
        id: _communities[index].id,
        name: _communities[index].name,
        description: _communities[index].description,
        coverImage: _communities[index].coverImage,
        memberCount: _communities[index].memberCount + 1,
        isJoined: true,
        rules: _communities[index].rules,
      );
      notifyListeners();
    }
  }

  void leaveCommunity(String communityId) {
    final index = _communities.indexWhere((c) => c.id == communityId);
    if (index != -1) {
      _communities[index] = Community(
        id: _communities[index].id,
        name: _communities[index].name,
        description: _communities[index].description,
        coverImage: _communities[index].coverImage,
        memberCount: _communities[index].memberCount - 1,
        isJoined: false,
        rules: _communities[index].rules,
      );
      notifyListeners();
    }
  }

  void createCommunity(String name, String description, String coverImage, List<String> rules) {
    final newCommunity = Community(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      coverImage: coverImage,
      memberCount: 1,
      isJoined: true,
      isAdmin: true,
      rules: rules,
    );
    _communities.add(newCommunity);
    notifyListeners();
  }
}