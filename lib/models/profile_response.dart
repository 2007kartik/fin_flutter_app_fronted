class ProfileResponse {
  final String upiId;
  final String name;
  final String mobile;

  ProfileResponse({
    required this.upiId,
    required this.name,
    required this.mobile,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      upiId: json['upiId'] ?? '',
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }
}
