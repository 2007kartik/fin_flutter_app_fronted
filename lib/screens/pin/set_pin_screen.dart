import 'package:flutter/material.dart';

import '../../models/set_pin_request.dart';
import '../../services/api_service.dart';
import '../home/main_screen.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController pinController = TextEditingController();

  final ApiService apiService = ApiService();

  bool isLoading = false;

  Future<void> attemptSetPin() async {
    String password = passwordController.text.trim();

    String pin = pinController.text.trim();

    if (password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter account password")));
      return;
    }

    if (pin.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PIN must be exactly 4 digits")),
      );
      return;
    }

    SetPinRequest request = SetPinRequest(password: password, newPin: pin);

    setState(() {
      isLoading = true;
    });

    bool success = await apiService.setPin(request);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("PIN Set Successfully")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to Set PIN")));
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set PIN")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),

            const Text(
              "Set Your Secure PIN",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text("This PIN will be required for every payment"),

            const SizedBox(height: 40),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Account Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "4 Digit PIN",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : attemptSetPin,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Set PIN"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
