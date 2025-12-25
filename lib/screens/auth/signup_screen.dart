import 'package:agent_application/constant/app_colors.dart';
import 'package:agent_application/constant/custom_textfield.dart';
import 'package:agent_application/constant/top_snackbar.dart';
import 'package:agent_application/screens/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Image.asset(
                'assets/vista_loans_new_logo.png',
                height: MediaQuery.of(context).size.height * 0.17,
              ),

              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                // margin: const EdgeInsets.all(20),
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
                        "Create Account",
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
                        "Sign up to get started",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.greyText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    fieldTitle("First Name"),
                    CustomTextField(controller: nameController, hint: "Ravi"),
                    const SizedBox(height: 15),

                    fieldTitle("Last Name"),
                    CustomTextField(
                      controller: surnameController,
                      hint: "Kumar",
                    ),
                    const SizedBox(height: 15),

                    fieldTitle("Email"),
                    CustomTextField(
                      controller: emailController,
                      hint: "example@email.com",
                    ),
                    const SizedBox(height: 15),

                    fieldTitle("Phone Number"),
                    CustomTextField(
                      controller: phoneController,
                      hint: "+91 9876543210",
                    ),
                    const SizedBox(height: 15),

                    fieldTitle("Address Line 1"),
                    CustomTextField(
                      controller: address1Controller,
                      hint: "House / Flat No.",
                    ),
                    const SizedBox(height: 15),

                    fieldTitle("Address Line 2"),
                    CustomTextField(
                      controller: address2Controller,
                      hint: "Street, Area, Landmark",
                    ),
                    const SizedBox(height: 15),

                    fieldTitle("Pincode"),
                    CustomTextField(
                      controller: pincodeController,
                      hint: "500075",
                    ),
                    const SizedBox(height: 15),

                    fieldTitle("City"),
                    CustomTextField(
                      controller: cityController,
                      hint: "Hyderabad",
                    ),
                    const SizedBox(height: 15),

                    fieldTitle("Password"),
                    CustomTextField(
                      controller: passwordController,
                      hint: "Password",
                      obscure: true,
                    ),
                    const SizedBox(height: 15),

                    fieldTitle("Confirm Password"),
                    CustomTextField(
                      controller: confirmPassController,
                      hint: "Confirm Password",
                      obscure: true,
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Checkbox(
                          value: checked,
                          onChanged: (v) {
                            setState(() => checked = v!);
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: "I accept the ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: "terms and conditions",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: auth.loading
                            ? null
                            : () async {
                                if (!checked) {
                                  showError(
                                    context,
                                    "You must accept terms & conditions",
                                  );
                                  return;
                                }
                                if (passwordController.text.trim() !=
                                    confirmPassController.text.trim()) {
                                  showError(context, "Passwords do not match");
                                  return;
                                }

                                try {
                                  await auth.register(
                                    firstName: nameController.text.trim(),
                                    lastName: surnameController.text.trim(),
                                    address1: address1Controller.text.trim(),
                                    address2: address2Controller.text.trim(),
                                    pincode: pincodeController.text.trim(),
                                    city: cityController.text.trim(),
                                    email: emailController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );

                                  showSuccess(
                                    context,
                                    "Account created successfully",
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginScreen(),
                                    ),
                                  );
                                } catch (e) {
                                  showError(context, e.toString());
                                }
                              },
                        child: auth.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.white,
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
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: [
                              TextSpan(
                                text: "Sign in",
                                style: TextStyle(
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

  // FIELD TITLE WIDGET
  Widget fieldTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.darkText,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void showError(BuildContext context, String msg) {
    showTopSnackBar(
      context: context,
      message: msg,
      backgroundColor: Colors.red,
    );
  }

  void showSuccess(BuildContext context, String msg) {
    showTopSnackBar(
      context: context,
      message: msg,
      backgroundColor: Colors.green,
    );
  }
}
