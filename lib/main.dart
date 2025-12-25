import 'package:agent_application/constant/app_prefs.dart';
import 'package:agent_application/screens/dashboard/dashboard_screen.dart';
import 'package:agent_application/screens/pending_loan_status.dart/agent_provider.dart';
import 'package:agent_application/screens/auth/auth_provider.dart';
import 'package:agent_application/screens/auth/login_screen.dart';
import 'package:agent_application/screens/add_customer_screens/customer_provider.dart';
import 'package:agent_application/screens/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PendingApplicationsProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthGate());
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _isLoggedIn() async {
    final token = await AppPrefs.getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return const DashboardScreen(); // ✅ user stays logged in
        }

        return const LoginScreen(); // ❌ no token → login
      },
    );
  }
}
