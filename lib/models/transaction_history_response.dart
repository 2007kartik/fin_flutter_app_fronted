import 'transaction.dart';

class TransactionHistoryResponse {
  final List<Transaction> transactions;

  TransactionHistoryResponse({required this.transactions});

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      transactions:
          (json["transactions"] as List?)
              ?.map((e) => Transaction.fromJson(e))
              .toList() ??
          [],
    );
  }
}
