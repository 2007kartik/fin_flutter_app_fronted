import 'package:flutter/material.dart';

import '../main/main_screen.dart';

class TransactionResultScreen extends StatelessWidget {
  final String transactionId;
  final String status;
  final double riskScore;
  final String reason;

  const TransactionResultScreen({
    super.key,
    required this.transactionId,
    required this.status,
    required this.riskScore,
    required this.reason,
  });

  // Color getStatusColor() {
  //   if (status.toUpperCase() == "APPROVED") {
  //     return Colors.green;
  //   }

  //   if (status.toUpperCase() == "FLAGGED") {
  //     return Colors.orange;
  //   }

  //   return Colors.red;
  // }

  // IconData getStatusIcon() {
  //   if (status.toUpperCase() == "APPROVED") {
  //     return Icons.check_circle;
  //   }

  //   if (status.toUpperCase() == "FLAGGED") {
  //     return Icons.warning_amber_rounded;
  //   }

  //   return Icons.cancel;
  // }

  // String getTitle() {
  //   if (status.toUpperCase() == "APPROVED") {
  //     return "Payment Successful";
  //   }

  //   if (status.toUpperCase() == "FLAGGED") {
  //     return "Suspicious Activity Detected";
  //   }

  //   return "Transaction Blocked";
  // }

  Color getStatusColor() {
    String s = status.toUpperCase();

    if (s == "APPROVED" || s == "SUCCESS") {
      return Colors.green;
    }

    if (s == "FLAGGED") {
      return Colors.orange;
    }

    return Colors.red;
  }

  IconData getStatusIcon() {
    String s = status.toUpperCase();

    if (s == "APPROVED" || s == "SUCCESS") {
      return Icons.check_circle;
    }

    if (s == "FLAGGED") {
      return Icons.warning_amber_rounded;
    }

    return Icons.cancel;
  }

  String getTitle() {
    String s = status.toUpperCase();

    if (s == "APPROVED" || s == "SUCCESS") {
      return "Payment Successful";
    }

    if (s == "FLAGGED") {
      return "Suspicious Activity Detected";
    }

    return "Transaction Blocked";
  }

  @override
  Widget build(BuildContext context) {
    print("STATUS = $status");
    print("REASON = $reason");
    print("RISK SCORE = $riskScore");
    Color color = getStatusColor();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 60),

              CircleAvatar(
                radius: 60,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(getStatusIcon(), size: 70, color: color),
              ),

              const SizedBox(height: 30),

              Text(
                getTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "$reason\n\nRisk Score : $riskScore",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 40),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Transaction ID",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        transactionId,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Done / Go To Home",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
