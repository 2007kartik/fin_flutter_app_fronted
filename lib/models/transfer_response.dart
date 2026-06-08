class TransferResponse {
  final String transactionId;
  final String status;
  final double riskScore;
  final String message;

  TransferResponse({
    required this.transactionId,
    required this.status,
    required this.riskScore,
    required this.message,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
      transactionId: json["transactionId"] ?? "",
      status: json["status"] ?? "",
      riskScore: (json["riskScore"] ?? 0).toDouble(),
      message: json["message"] ?? "",
    );
  }
}
