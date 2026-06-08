class WalletResponse {
  final int balance;

  WalletResponse({required this.balance});

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(balance: json["balance"] ?? 0);
  }
}
