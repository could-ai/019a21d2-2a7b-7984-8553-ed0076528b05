import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../providers/chat_provider.dart';
import '../chat/chat_screen.dart';
import '../../models/models.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of&lt;ChatProvider&gt;(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: chatProvider.chats.length,
        itemBuilder: (context, index) {
          final chat = chatProvider.chats[index];
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) =&gt; chatProvider.pinChat(chat.id),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: chat.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  label: chat.isPinned ? 'Unpin' : 'Pin',
                ),
                SlidableAction(
                  onPressed: (_) =&gt; chatProvider.muteChat(chat.id),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  icon: chat.isMuted ? Icons.volume_up : Icons.volume_off,
                  label: chat.isMuted ? 'Unmute' : 'Mute',
                ),
              ],
            ),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) =&gt; _deleteChat(context, chatProvider, chat.id),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (_) =&gt; _archiveChat(context, chatProvider, chat.id),
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
              ],
            ),
            child: ChatListItem(
              chat: chat,
              onTap: () {
                chatProvider.markAsRead(chat.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =&gt; ChatScreen(chatId: chat.id, chatName: chat.name),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =&gt; _showNewChatDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteChat(BuildContext context, ChatProvider provider, String chatId) {
    provider.removeChat(chatId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat deleted')),
    );
  }

  void _archiveChat(BuildContext context, ChatProvider provider, String chatId) {
    // TODO: Implement archive functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat archived')),
    );
  }

  void _showNewChatDialog(BuildContext context) {
    // TODO: Navigate to contacts screen for new chat
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New chat feature coming soon')),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const ChatListItem({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: chat.profilePicture != null
            ? AssetImage(chat.profilePicture!)
            : null,
        child: chat.profilePicture == null
            ? Text(chat.name[0].toUpperCase())
            : null,
      ),
      title: Text(
        chat.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        chat.lastMessage,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatTime(chat.lastMessageTime),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          if (chat.unreadCount &gt; 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                chat.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: onTap,
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays &gt; 0) {
      return '${time.day}/${time.month}';
    } else if (difference.inHours &gt; 0) {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      return '${time.minute}m ago';
    }
  }
}