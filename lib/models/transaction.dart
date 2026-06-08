class Transaction {
  final String transactionId;
  final String fromUpi;
  final String toUpi;
  final int amount;
  final String status;
  final String createdAt;
  final String category;

  Transaction({
    required this.transactionId,
    required this.fromUpi,
    required this.toUpi,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json["transactionId"] ?? "",
      fromUpi: json["fromUpi"] ?? "",
      toUpi: json["toUpi"] ?? "",
      amount: json["amount"] ?? 0,
      status: json["status"] ?? "",
      createdAt: json["createdAt"] ?? "",
      category: json["category"] ?? "",
    );
  }
}
