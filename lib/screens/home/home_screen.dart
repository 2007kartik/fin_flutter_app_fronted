import 'package:flutter/material.dart';
import '../send_money/send_money_screen.dart';
import '../receive_money/receive_money_screen.dart';

import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> openFinancialAdvisory() async {
    final Uri url = Uri.parse("https://finance-advisory.netlify.app/");

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Widget actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Row(
            children: [
              CircleAvatar(radius: 28, child: Icon(icon)),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(subtitle),
                  ],
                ),
              ),

              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                child: Icon(Icons.account_balance_wallet),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "UPI App",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text("Secure • Fast • Reliable"),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No new notifications")),
                  );
                },

                icon: const Icon(Icons.notifications),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 5,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/banner.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          actionCard(
            icon: Icons.send,
            title: "Send Money",
            subtitle: "Transfer funds instantly",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SendMoneyScreen()),
              );
            },
          ),

          actionCard(
            icon: Icons.arrow_downward,
            title: "Receive Money",
            subtitle: "Request payment from anyone",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReceiveMoneyScreen()),
              );
            },
          ),

          actionCard(
            icon: Icons.account_balance_wallet,
            title: "Financial Advisory",
            subtitle: "Get expert financial guidance",
            onTap: openFinancialAdvisory,
          ),
          const SizedBox(height: 10),

          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Why Choose UPI App?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(Icons.verified_user, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Bank-level security encryption",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.analytics, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Visual money insights",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.support_agent, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Personalized financial guidance",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
