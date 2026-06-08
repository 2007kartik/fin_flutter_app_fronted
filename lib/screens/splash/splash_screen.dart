import 'dart:async';

import 'package:flutter/material.dart';
import 'package:financial_advisory/screens/auth/login_screen.dart';
import 'package:financial_advisory/screens/main/main_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../auth/login_screen.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  late AnimationController logoController;
  late AnimationController glowController;
  late AnimationController circleController;
  late AnimationController loadingController;

  @override
  void initState() {
    super.initState();

    logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    navigateUser();
  }

  Future<void> navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));

    String? token = await secureStorage.read(key: "jwt_token");

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    logoController.dispose();
    glowController.dispose();
    circleController.dispose();
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff2D1B69), Color(0xff673AB7), Color(0xff4A148C)],
          ),
        ),

        child: Stack(
          children: [
            /// Top Circle
            AnimatedBuilder(
              animation: circleController,
              builder: (_, child) {
                return Positioned(
                  top: -80,
                  right: -80,
                  child: Transform.rotate(
                    angle: circleController.value * 2 * pi,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffD5B244).withOpacity(0.10),
                ),
              ),
            ),

            /// Bottom Circle
            AnimatedBuilder(
              animation: circleController,
              builder: (_, child) {
                return Positioned(
                  bottom: -50,
                  left: -50,
                  child: Transform.rotate(
                    angle: -(circleController.value * 2 * pi),
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffD5B244).withOpacity(0.10),
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Logo Section
                  AnimatedBuilder(
                    animation: glowController,
                    builder: (_, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 240 + (glowController.value * 20),
                            height: 240 + (glowController.value * 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffD5B244).withOpacity(0.20),
                            ),
                          ),

                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xffD5B244),
                                width: 4,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: AnimatedBuilder(
                              animation: logoController,
                              builder: (_, child) {
                                return Transform.rotate(
                                  angle:
                                      sin(logoController.value * 2 * pi) * 0.08,
                                  child: child,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Image.asset(
                                  "assets/images/applogo.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "UPI App",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffD5B244),
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Fast • Secure • Simple",
                    style: TextStyle(color: Colors.white70, letterSpacing: 2),
                  ),
                ],
              ),
            ),

            /// Bottom Loading Section
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: loadingController,
                    builder: (_, child) {
                      return Transform.scale(
                        scale: 1 + (loadingController.value * 0.2),
                        child: child,
                      );
                    },
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        color: Color(0xffD5B244),
                        strokeWidth: 3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  FadeTransition(
                    opacity: loadingController,
                    child: const Text(
                      "Loading...",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "v1.0.0",
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Powered by ",
                        style: TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                      TextSpan(
                        text: "UPI Technology",
                        style: TextStyle(
                          color: Color(0xffD5B244),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

//   @override
//   void initState() {
//     super.initState();

//     navigateUser();
//   }

//   Future<void> navigateUser() async {
//     await Future.delayed(const Duration(seconds: 3));

//     String? token = await secureStorage.read(key: "jwt_token");

//     if (!mounted) return;

//     if (token != null && token.isNotEmpty) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => MainScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF1A237E), Color(0xFF283593)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.account_balance_wallet,
//               size: 120,
//               color: Colors.white,
//             ),

//             const SizedBox(height: 20),

//             const Text(
//               "UPI App",
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),

//             const SizedBox(height: 10),

//             const Text(
//               "Fast • Secure • Simple",
//               style: TextStyle(color: Colors.white70, fontSize: 14),
//             ),

//             const SizedBox(height: 50),

//             const CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }
