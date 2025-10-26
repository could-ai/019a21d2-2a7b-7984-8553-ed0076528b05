import 'package:flutter/material.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Call history
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text('Contact ${index + 1}'),
                subtitle: Text('Yesterday, 2:30 PM • ${index % 2 == 0 ? 'Incoming' : 'Outgoing'}'),
                trailing: Icon(
                  index % 2 == 0 ? Icons.call_received : Icons.call_made,
                  color: index % 2 == 0 ? Colors.green : Colors.blue,
                ),
                onTap: () {
                  // TODO: Call contact
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewCallDialog,
        child: const Icon(Icons.add_call),
      ),
    );
  }

  void _showNewCallDialog() {
    // TODO: Show contacts for new call
  }
}