class TransferRequest {
  final String toUpi;
  final int amount;
  final String pin;
  final String transactionType;
  final String category;

  final Device device;
  final Location location;

  TransferRequest({
    required this.toUpi,
    required this.amount,
    required this.pin,
    required this.transactionType,
    required this.category,
    required this.device,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      "toUpi": toUpi,
      "amount": amount,
      "pin": pin,
      "transactionType": transactionType,
      "category": category,
      "device": device.toJson(),
      "location": location.toJson(),
    };
  }
}

class Device {
  final String deviceId;
  final String deviceType;

  Device({required this.deviceId, required this.deviceType});

  Map<String, dynamic> toJson() {
    return {"deviceId": deviceId, "deviceType": deviceType};
  }
}

class Location {
  final String city;
  final String country;

  Location({required this.city, required this.country});

  Map<String, dynamic> toJson() {
    return {"city": city, "country": country};
  }
}
