import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/profile_response.dart';
import '../../services/api_service.dart';

class ReceiveMoneyScreen extends StatefulWidget {
  const ReceiveMoneyScreen({super.key});

  @override
  State<ReceiveMoneyScreen> createState() => _ReceiveMoneyScreenState();
}

class _ReceiveMoneyScreenState extends State<ReceiveMoneyScreen> {
  final ApiService apiService = ApiService();

  bool isLoading = true;

  String upiId = "";
  String userName = "";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      ProfileResponse? profile = await apiService.getProfile();

      if (profile != null) {
        setState(() {
          upiId = profile.upiId;
          userName = profile.name;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void shareUpi() {
    Share.share("Pay me using my UPI ID:\n$upiId");
  }

  String getQrData() {
    // return "UPI:\nID=$upiId;\nNAME=$userName;";
    return upiId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receive Money"), centerTitle: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(blurRadius: 8, color: Colors.black12),
                      ],
                    ),
                    child: QrImageView(
                      data: getQrData(),
                      version: QrVersions.auto,
                      size: 250,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Your UPI ID",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        upiId,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: shareUpi,
                      child: const Text("Share UPI ID"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
