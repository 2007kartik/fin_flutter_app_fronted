import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String transactionId;
  final String fromUpi;
  final String toUpi;
  final int amount;
  final String status;
  final String category;
  final String createdAt;
  final bool isCredit;

  const TransactionDetailsScreen({
    super.key,
    required this.transactionId,
    required this.fromUpi,
    required this.toUpi,
    required this.amount,
    required this.status,
    required this.category,
    required this.createdAt,
    required this.isCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transaction Details")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    Text(
                      isCredit ? "Money Received" : "Money Sent",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "₹ $amount",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            buildRow("Transaction ID", transactionId),
            buildRow("From", fromUpi),
            buildRow("To", toUpi),
            buildRow("Category", category),
            buildRow("Status", status),
            buildRow("Date", createdAt),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value) {
    return Card(
      child: ListTile(title: Text(title), subtitle: Text(value)),
    );
  }
}
