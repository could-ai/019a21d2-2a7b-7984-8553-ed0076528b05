import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String chatName;

  const ChatScreen({super.key, required this.chatId, required this.chatName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.loadMessages(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chatName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // TODO: Start voice call
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // TODO: Start video call
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // TODO: Handle menu actions
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'view_contact',
                  child: Text('View Contact'),
                ),
                const PopupMenuItem<String>(
                  value: 'media',
                  child: Text('Media'),
                ),
                const PopupMenuItem<String>(
                  value: 'search',
                  child: Text('Search'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.all(10),
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[chatProvider.messages.length - 1 - index];
                return MessageBubble(
                  message: message,
                  onLongPress: () => _showMessageOptions(context, message),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: _showAttachmentOptions,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              maxLines: null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.sendMessage(widget.chatId, _messageController.text.trim());

    _messageController.clear();
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption(Icons.image, 'Gallery', _pickImage),
                _buildAttachmentOption(Icons.camera_alt, 'Camera', _takePhoto),
                _buildAttachmentOption(Icons.video_library, 'Video', _pickVideo),
                _buildAttachmentOption(Icons.audiotrack, 'Audio', _recordAudio),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption(Icons.insert_drive_file, 'Document', _pickDocument),
                _buildAttachmentOption(Icons.location_on, 'Location', _shareLocation),
                _buildAttachmentOption(Icons.contact_page, 'Contact', _shareContact),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _showMessageOptions(BuildContext context, dynamic message) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy'),
              onTap: () {
                // TODO: Copy message
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.reply),
              title: const Text('Reply'),
              onTap: () {
                // TODO: Reply to message
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.forward),
              title: const Text('Forward'),
              onTap: () {
                // TODO: Forward message
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                // TODO: Delete message
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Report'),
              onTap: () {
                // TODO: Report message
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Info'),
              onTap: () {
                // TODO: Show message info
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() {
    // TODO: Implement image picker
    Navigator.pop(context);
  }

  void _takePhoto() {
    // TODO: Implement camera
    Navigator.pop(context);
  }

  void _pickVideo() {
    // TODO: Implement video picker
    Navigator.pop(context);
  }

  void _recordAudio() {
    // TODO: Implement audio recording
    Navigator.pop(context);
  }

  void _pickDocument() {
    // TODO: Implement document picker
    Navigator.pop(context);
  }

  void _shareLocation() {
    // TODO: Implement location sharing
    Navigator.pop(context);
  }

  void _shareContact() {
    // TODO: Implement contact sharing
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class MessageBubble extends StatelessWidget {
  final dynamic message;
  final VoidCallback onLongPress;

  const MessageBubble({super.key, required this.message, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final isSent = message.isSent;
    final alignment = isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final margin = isSent
        ? const EdgeInsets.only(left: 60, bottom: 8)
        : const EdgeInsets.only(right: 60, bottom: 8);

    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: margin,
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSent
                    ? const Color(0xFFDCF8C6)
                    : const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: isSent ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: isSent ? const Radius.circular(4) : const Radius.circular(18),
                ),
              ),
              child: Text(
                message.content,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _formatTime(message.timestamp),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}