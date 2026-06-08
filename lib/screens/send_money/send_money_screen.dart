import 'package:flutter/material.dart';

import 'confirm_pin_screen.dart';
import 'qr_scanner_screen.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController receiverController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  String selectedCategory = "GENERAL";

  final List<String> categories = [
    "GENERAL",
    "FOOD",
    "SHOPPING",
    "TRAVEL",
    "BILLS",
    "EDUCATION",
  ];

  Future<void> scanQr() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );

    if (result != null && result is String) {
      setState(() {
        receiverController.text = result;
      });
    }
  }

  void proceedPayment() {
    String receiver = receiverController.text.trim();

    String amountText = amountController.text.trim();

    String message = messageController.text.trim();

    if (receiver.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter Receiver UPI")));
      return;
    }

    if (amountText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter Amount")));
      return;
    }

    double amount = double.tryParse(amountText) ?? 0;

    if (amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid Amount")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmPinScreen(
          receiverId: receiver,
          amount: amount,
          category: selectedCategory,
          message: message,
        ),
      ),
    );
  }

  @override
  void dispose() {
    receiverController.dispose();
    amountController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send Money")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: receiverController,
                    decoration: const InputDecoration(
                      labelText: "Receiver UPI ID",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: scanQr,
                    icon: const Icon(Icons.qr_code_scanner),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: categories
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Message (Optional)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: proceedPayment,
                child: const Text("Proceed To Pay"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
