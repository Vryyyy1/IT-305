import 'package:flutter/material.dart';

import 'package:futurebuilder_example/model/user.dart';

class UserPage extends StatelessWidget {
  final User user;

  const UserPage({
    super.key,
    required this.user,
  });

  // Helper method to get correct ImageProvider (Asset or Network)
  ImageProvider? _getImageProvider(String path) {
    if (path.isEmpty) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return NetworkImage(path);
    }
    final assetPath = path.startsWith('assets/') ? path : 'assets/$path';
    return AssetImage(assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: _getImageProvider(user.urlAvatar),
                child: user.urlAvatar.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 60,
                      )
                    : null,
              ),
              const SizedBox(height: 32),
              Text(
                user.username,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.email,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Email sending is not configured yet.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.email),
                label: const Text('Send Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}