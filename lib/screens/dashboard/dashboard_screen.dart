import 'package:agent_application/constant/app_prefs.dart';
import 'package:agent_application/screens/auth/login_screen.dart';
import 'package:agent_application/screens/add_customer_screens/customer_onboarding.dart';
import 'package:agent_application/screens/pending_loan_status.dart/pending_application_screen.dart';
import 'package:agent_application/screens/profile/profile_api.dart';
import 'package:agent_application/screens/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:agent_application/constant/app_colors.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  User? profileUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() => isLoading = true);

    try {
      final profileService = ProfileService();
      final user = await profileService.fetchProfile();

      setState(() {
        profileUser = user;
      });
    } catch (e) {
      debugPrint("Profile API error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to load profile")));
    } finally {
      setState(() => isLoading = false); // stop loading
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (profileUser == null) {
      return const Scaffold(
        body: Center(child: Text("Failed to load profile")),
      );
    }
    final firstName = profileUser!.firstName?.trim();
    final lastName = profileUser!.lastName?.trim();
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/vista_loans_new_logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfileScreen()),
          ),
          child: SizedBox(
            width: 26,
            height: 26,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryBlue,
              child: Text(
                userInitials,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              AppPrefs.clear();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            child: Text("Logout", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Complete Your Profile\nBank account and PAN card information are pending.",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: Colors.orange.shade300, // Border color
                          width: 1, // Border thickness
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProfileScreen()),
                        );
                      },
                      child: Text(
                        "Complete Now",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Text(
                  "Welcome, ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                Text(
                  "$firstName $lastName !",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                Text(
                  " Get Started!!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 💰 Money Earned Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Money Earned This Month",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Keep growing!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            menuCard(
              icon: Icons.person_add_alt_1,
              title: "Add New Customer",
              subtitle: "Add new customers to the system",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddCustomerScreen()),
                );
              },
            ),

            // 📄 Loan Status Card
            menuCard(
              icon: Icons.trending_up,
              title: "Loan Status",
              subtitle: "Track and manage loan applications",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ApplicationDetailScreen()),
                );
              },
            ),

            // 📊 Dashboard Card
            menuCard(
              icon: Icons.dashboard,
              title: "Dashboard",
              subtitle: "View customer data and analytics",
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => AddCustomerScreen()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryBlue, width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 28),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: AppColors.greyText, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get userInitials {
    if (profileUser == null) return "DU";

    final firstName = profileUser!.firstName?.trim();
    final lastName = profileUser!.lastName?.trim();

    String firstInitial = firstName!.isNotEmpty
        ? firstName[0].toUpperCase()
        : "";
    String lastInitial = lastName!.isNotEmpty ? lastName[0].toUpperCase() : "";

    return "$firstInitial$lastInitial";
  }
}
