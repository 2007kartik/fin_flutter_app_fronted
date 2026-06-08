import 'package:flutter/material.dart';

import '../../models/profile_response.dart';
import '../../models/transaction.dart';
import '../../models/transaction_history_response.dart';
import '../../models/wallet_response.dart';
import '../../services/api_service.dart';
import '../../widgets/transaction_card.dart';

class MoneyScreen extends StatefulWidget {
  const MoneyScreen({super.key});

  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  final ApiService apiService = ApiService();

  bool isLoading = true;

  String myUpiId = "";

  int balance = 0;

  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      ProfileResponse? profile = await apiService.getProfile();

      WalletResponse? wallet = await apiService.getBalance();

      TransactionHistoryResponse? history = await apiService
          .getTransactionHistory();

      setState(() {
        myUpiId = profile?.upiId ?? "";

        balance = wallet?.balance ?? 0;

        transactions = history?.transactions ?? [];

        isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildBalanceCard() {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Account Balance", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 10),

            Text(
              "₹ $balance",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,

              child: IconButton(
                onPressed: loadData,

                icon: const Icon(Icons.refresh),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.receipt_long, size: 80, color: Colors.grey),

          const SizedBox(height: 15),

          const Text(
            "No Transactions Found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ElevatedButton(onPressed: () {}, child: const Text("Send Money")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: loadData,

      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(16), child: buildBalanceCard()),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transactions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Text(
                  "${transactions.length} txns",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: transactions.isEmpty
                ? buildEmptyState()
                : ListView.builder(
                    itemCount: transactions.length,

                    itemBuilder: (context, index) {
                      return TransactionCard(
                        transaction: transactions[index],
                        myUpiId: myUpiId,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
