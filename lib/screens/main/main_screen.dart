import 'package:flutter/material.dart';

import '../../services/secure_storage_service.dart';
import '../auth/login_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Future<void> logout(BuildContext context) async {
    await SecureStorageService().clearData();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => logout(context),
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
