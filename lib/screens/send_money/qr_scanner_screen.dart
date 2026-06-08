import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool scanned = false;

  String extractUpiId(String qrData) {
    try {
      // Case 1: Structured QR
      // UPI:
      // ID=ganesh@mockupi;
      // NAME=Ganesh;

      if (qrData.contains("ID=")) {
        final RegExp exp = RegExp(r'ID=([^;]+)');
        final Match? match = exp.firstMatch(qrData);

        if (match != null) {
          return match.group(1)?.trim() ?? "";
        }
      }

      // Case 2: QR directly contains UPI ID
      if (qrData.contains("@")) {
        return qrData.trim();
      }
    } catch (e) {
      debugPrint("QR Parse Error: $e");
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR")),
      body: MobileScanner(
        onDetect: (capture) {
          if (scanned) return;

          final barcode = capture.barcodes.first;

          final String qrData = barcode.rawValue ?? "";

          final String upiId = extractUpiId(qrData);

          if (upiId.isNotEmpty) {
            scanned = true;

            Navigator.pop(context, upiId);
          }
        },
      ),
    );
  }
}
