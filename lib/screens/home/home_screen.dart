import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Future<void> openFinancialAdvisory() async {
  //   final Uri url = Uri.parse("https://finance-advisory.netlify.app/");

  //   await launchUrl(url, mode: LaunchMode.externalApplication);
  // }

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
              height: 180,

              alignment: Alignment.center,

              child: const Text(
                "Secure UPI Payments",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Send Money Screen Coming Soon")),
              );
            },
          ),

          actionCard(
            icon: Icons.arrow_downward,
            title: "Receive Money",
            subtitle: "Request payment from anyone",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Receive Money Screen Coming Soon"),
                ),
              );
            },
          ),

          // actionCard(
          //   icon: Icons.account_balance_wallet,
          //   title: "Financial Advisory",
          //   subtitle: "Get expert financial guidance",
          //  onTap: openFinancialAdvisory,
          // ),
          // const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Why Choose UPI App?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  Text("✓ Bank-level security encryption"),

                  SizedBox(height: 8),

                  Text("✓ Visual money insights"),

                  SizedBox(height: 8),

                  Text("✓ Personalized financial guidance"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
