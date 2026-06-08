import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final String myUpiId;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.myUpiId,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCredit =
        transaction.toUpi.toLowerCase() == myUpiId.toLowerCase();

    Color amountColor;

    if (transaction.status.toUpperCase() == "BLOCKED" ||
        transaction.status.toUpperCase() == "FLAGGED" ||
        transaction.status.toUpperCase() == "FAILURE") {
      amountColor = Colors.red;
    } else if (isCredit) {
      amountColor = Colors.green;
    } else {
      amountColor = Colors.grey;
    }

    Color statusColor;

    switch (transaction.status.toUpperCase()) {
      case "SUCCESS":
      case "APPROVED":
        statusColor = Colors.green;
        break;

      case "PENDING":
      case "FLAGGED":
        statusColor = Colors.orange;
        break;

      default:
        statusColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),

      child: ListTile(
        leading: CircleAvatar(
          child: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward),
        ),

        title: Text(isCredit ? transaction.fromUpi : transaction.toUpi),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            Text(transaction.category),

            Text(transaction.createdAt),

            const SizedBox(height: 4),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),

              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Text(
                transaction.status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        trailing: Text(
          "₹ ${transaction.amount}",
          style: TextStyle(
            color: amountColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
