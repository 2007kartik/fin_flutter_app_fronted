import 'package:flutter/material.dart';

import '../../models/profile_response.dart';
import '../../services/api_service.dart';
import '../../services/secure_storage_service.dart';
import '../auth/login_screen.dart';
import '../pin/set_pin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService apiService = ApiService();

  ProfileResponse? profile;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final result = await apiService.getProfile();

    if (!mounted) return;

    setState(() {
      profile = result;
      isLoading = false;
    });
  }

  Future<void> logout() async {
    await SecureStorageService().clearData();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          const SizedBox(height: 20),

          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

          const SizedBox(height: 30),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),

                    title: const Text("Username"),

                    subtitle: Text(profile?.name ?? "N/A"),
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),

                    title: const Text("UPI ID"),

                    subtitle: Text(profile?.upiId ?? "N/A"),
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.phone),

                    title: const Text("Mobile Number"),

                    subtitle: Text("+91 ${profile?.mobile ?? ''}"),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 55,

            child: ElevatedButton.icon(
              icon: const Icon(Icons.lock),

              label: const Text("Change UPI PIN"),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SetPinScreen()),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 55,

            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),

              label: const Text("Logout"),

              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),

              onPressed: logout,
            ),
          ),
        ],
      ),
    );
  }
}
