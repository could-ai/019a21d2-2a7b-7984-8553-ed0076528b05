import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/community_provider.dart';
import 'create_community_screen.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: communityProvider.communities.length,
        itemBuilder: (context, index) {
          final community = communityProvider.communities[index];
          return CommunityCard(
            community: community,
            onJoinLeave: () {
              if (community.isJoined) {
                communityProvider.leaveCommunity(community.id);
              } else {
                communityProvider.joinCommunity(community.id);
              }
            },
            onTap: () {
              // TODO: Navigate to community page
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateCommunityScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  final dynamic community;
  final VoidCallback onJoinLeave;
  final VoidCallback onTap;

  const CommunityCard({
    super.key,
    required this.community,
    required this.onJoinLeave,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(community.coverImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      community.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${community.memberCount} members',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: onJoinLeave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: community.isJoined
                      ? Colors.grey
                      : Theme.of(context).primaryColor,
                ),
                child: Text(
                  community.isJoined ? 'Leave' : 'Join',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}