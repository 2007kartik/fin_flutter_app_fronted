# Financial Advisory UPI App

A secure Flutter-based UPI payment application integrated with Financial Advisory features. The application allows users to send and receive money, view transaction history, manage their profile, and access personalized financial guidance through an integrated advisory platform.

## Features

### UPI Payments

* Send money using UPI ID
* Receive money using QR Code
* QR Code scanning for quick payments
* UPI PIN verification before transactions
* Real-time transaction processing

### Wallet Management

* View account balance
* Track transaction history
* Detailed transaction information
* Credit and debit transaction tracking

### Security Features

* Secure JWT-based authentication
* PIN-protected transactions
* Fraud detection integration
* Secure local token storage
* Risk score evaluation for transactions

### Financial Advisory

* Integrated financial advisory portal
* Personalized financial guidance
* Investment and financial planning resources

### User Management

* User registration and login
* Profile management
* Secure session handling

## Technology Stack

### Frontend

* Flutter
* Dart
* Material Design

### Backend Integration

* REST APIs
* JWT Authentication
* Dio HTTP Client

### Packages Used

* flutter_secure_storage
* dio
* flutter_bloc
* mobile_scanner
* qr_flutter
* share_plus
* url_launcher

## Project Structure

```
lib/
├── models/
├── screens/
│   ├── auth/
│   ├── home/
│   ├── money/
│   ├── profile/
│   ├── send_money/
│   └── receive_money/
├── services/
├── widgets/
└── main.dart
```

## Screens

* Splash Screen
* Login Screen
* Signup Screen
* Home Dashboard
* Send Money
* Receive Money
* QR Scanner
* Transaction History
* Transaction Details
* Profile Screen

## Installation

1. Clone the repository

```bash
git clone <repository-url>
```

2. Navigate to project directory

```bash
cd financial_advisory
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the application

```bash
flutter run
```

## Build APK

```bash
flutter build apk --release
```

Generated APK:

```
build/app/outputs/flutter-apk/app-release.apk
```

## Future Enhancements

* Push Notifications
* Dark Mode Support
* Biometric Authentication
* Expense Analytics Dashboard
* AI-Based Financial Recommendations
* Multi-Bank Account Support

## Author

Kartik Mahanor

## License

This project is developed for educational and learning purposes.
