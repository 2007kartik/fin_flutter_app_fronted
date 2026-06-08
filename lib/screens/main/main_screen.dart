// // import 'package:flutter/material.dart';

// // import '../../services/secure_storage_service.dart';
// // import '../auth/login_screen.dart';

// // class MainScreen extends StatelessWidget {
// //   const MainScreen({super.key});

// //   Future<void> logout(BuildContext context) async {
// //     await SecureStorageService().clearData();

// //     if (!context.mounted) return;

// //     Navigator.pushAndRemoveUntil(
// //       context,
// //       MaterialPageRoute(builder: (context) => const LoginScreen()),
// //       (route) => false,
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Main Screen"),
// //         actions: [
// //           IconButton(
// //             onPressed: () => logout(context),
// //             icon: const Icon(Icons.logout),
// //           ),
// //         ],
// //       ),

// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () => logout(context),
// //           child: const Text("Logout"),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// import '../../services/secure_storage_service.dart';
// import '../auth/login_screen.dart';
// import '../home/home_screen.dart';
// import '../money/money_screen.dart';
// import '../profile/profile_screen.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int currentIndex = 0;

//   final List<Widget> screens = [HomeScreen(), MoneyScreen(), ProfileScreen()];

//   Future<void> logout(BuildContext context) async {
//     await SecureStorageService().clearData();

//     if (!context.mounted) return;

//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Finance App"),
//         actions: [
//           IconButton(
//             onPressed: () => logout(context),
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),

//       body: screens[currentIndex],

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,

//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },

//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_balance_wallet),
//             label: "Money",
//           ),

//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../money/money_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [HomeScreen(), MoneyScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Finance App")),

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "Money",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
