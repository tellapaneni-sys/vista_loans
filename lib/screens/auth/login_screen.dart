import 'package:agent_application/constant/app_colors.dart';
import 'package:agent_application/constant/custom_textfield.dart';
import 'package:agent_application/constant/top_snackbar.dart';
import 'package:agent_application/screens/auth/auth_provider.dart';
import 'package:agent_application/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/vista_loans_new_logo.png',
                height: MediaQuery.of(context).size.height * 0.17,
              ),

              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.greyBorder, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: const Text(
                        "Sign in to your account to continue",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.greyText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Email Address",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hint: "abc@gmail.com",
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),

                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hint: "Password",
                      controller: passController,
                      obscure: _obscurePassword,
                      suffix: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () async {
                          final auth = context.read<AuthProvider>();

                          final res = await auth.login(
                            emailController.text.trim(),
                            passController.text.trim(),
                          );

                          if (res != null) {
                            showTopSnackBar(
                              context: context,
                              message: "Logged In Successfully",
                              backgroundColor: Colors.green,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DashboardScreen(),
                              ),
                            );
                          } else {
                            showTopSnackBar(
                              context: context,
                              message: auth.error ?? "Logged Failed",
                              backgroundColor: Colors.green,
                            );
                          }
                        },

                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white, // Force text color
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SignupScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
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
            ],
          ),
        ),
      ),
    );
  }
}
