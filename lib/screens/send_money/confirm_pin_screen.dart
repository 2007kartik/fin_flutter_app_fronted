import 'package:flutter/material.dart';

import '../../models/transfer_request.dart';
import '../../models/transfer_response.dart';
import '../../services/api_service.dart';
import 'transaction_result_screen.dart';

class ConfirmPinScreen extends StatefulWidget {
  final String receiverId;
  final double amount;
  final String category;
  final String message;

  const ConfirmPinScreen({
    super.key,
    required this.receiverId,
    required this.amount,
    required this.category,
    required this.message,
  });

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  final TextEditingController pinController = TextEditingController();

  final ApiService apiService = ApiService();

  bool isLoading = false;

  Future<void> confirmPayment() async {
    String pin = pinController.text.trim();

    if (pin.length != 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter 4 Digit PIN")));
      return;
    }

    TransferRequest request = TransferRequest(
      toUpi: widget.receiverId,
      amount: widget.amount.round(),
      pin: pin,
      transactionType: "TRANSFER",
      category: widget.category,
      device: Device(deviceId: "DEVICE_A", deviceType: "ANDROID"),
      location: Location(city: "Mumbai", country: "IN"),
    );

    setState(() {
      isLoading = true;
    });

    TransferResponse? response = await apiService.transfer(request);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (response == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Transaction Failed")));
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionResultScreen(
          transactionId: response.transactionId,
          status: response.status,
          riskScore: response.riskScore,
          reason: response.message,
        ),
      ),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Payment")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 50),

            Text(
              "Paying ₹${widget.amount.toStringAsFixed(2)} to ${widget.receiverId}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: "Enter UPI PIN",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : confirmPayment,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Confirm Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
