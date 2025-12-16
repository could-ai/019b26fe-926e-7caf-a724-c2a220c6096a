import 'package:flutter/material.dart';
import '../models/types.dart';
import '../state/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState(),
      builder: (context, child) {
        final state = AppState();
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Characters'),
            actions: [
              IconButton(
                icon: Icon(state.isGuest ? Icons.person_outline : Icons.person),
                onPressed: () {
                  // Show simple profile dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(state.isGuest ? 'Guest User' : 'Logged In User'),
                      content: Text(state.isGuest 
                        ? 'You are using the app as a guest. Sign in to sync your characters across devices.' 
                        : 'You are signed in with Google.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                        if (!state.isGuest)
                          TextButton(
                            onPressed: () {
                              state.logout();
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: const Text('Logout'),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: state.characters.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_off_outlined, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No characters yet',
                        style: TextStyle(color: Colors.grey[600], fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      const Text('Tap the + button to create one!'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.characters.length,
                  itemBuilder: (context, index) {
                    final character = state.characters[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(int.parse(character.avatarColor)),
                          child: Text(
                            character.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          character.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              character.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/chat',
                            arguments: character,
                          );
                        },
                        trailing: const Icon(Icons.chat_bubble_outline),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
            label: const Text('New Character'),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
