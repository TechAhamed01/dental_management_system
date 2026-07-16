import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dental_client/dental_client.dart' as dc;

import '../controllers/login_controller.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'basic_info.dart';
import 'confirmation.dart';
import 'home_screen.dart';
import 'rejected_screen.dart';

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({super.key});

  @override
  State<DoctorLogin> createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(LoginController controller) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text;

    debugPrint("[DoctorLogin] Login button pressed for email: $email");

    final dentist = await controller.login(email, password);

    if (!mounted) return;

    if (dentist != null) {
      debugPrint("[DoctorLogin] Dentist status received: ${dentist.status}");
      if (dentist.status == dc.DentistStatus.approved) {
        debugPrint("[DoctorLogin] Navigation decision: Approved -> Navigating to Home Screen");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(dentist: dentist)),
        );
      } else if (dentist.status == dc.DentistStatus.pending) {
        debugPrint("[DoctorLogin] Navigation decision: Pending -> Navigating to Under Review Screen");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Confirmation()),
        );
      } else if (dentist.status == dc.DentistStatus.rejected) {
        debugPrint("[DoctorLogin] Navigation decision: Rejected -> Navigating to Rejected Screen");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RejectedScreen()),
        );
      } else {
        debugPrint("[DoctorLogin] Navigation decision: Unknown status (${dentist.status}) -> Showing error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unknown account status: ${dentist.status}')),
        );
      }
    } else {
      final errorMsg = controller.errorMessage ?? 'Login failed. Please check your credentials.';
      debugPrint("[DoctorLogin] Login returned null/error -> Showing SnackBar: $errorMsg");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Doctor Login",
          style: TextStyle(
            color: AppColors.heading,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SafeArea(
        child: Consumer<LoginController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        "Welcome Back",
                        style: AppTextStyles.heading,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Center(
                      child: Text(
                        "Sign in to continue",
                        style: AppTextStyles.subtitle,
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Text("Email"),
                    const SizedBox(height: 8),

                    CustomTextField(
                      controller: emailController,
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      readOnly: controller.isLoading,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    const Text("Password"),
                    const SizedBox(height: 8),

                    CustomTextField(
                      controller: passwordController,
                      hintText: "Enter your password",
                      obscureText: true,
                      readOnly: controller.isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: controller.isLoading ? null : () {},
                        child: const Text("Forgot Password?"),
                      ),
                    ),

                    const SizedBox(height: 20),

                    CustomButton(
                      text: controller.isLoading ? "Logging in..." : "Login",
                      onPressed: controller.isLoading
                          ? () {}
                          : () => _handleLogin(controller),
                    ),

                    const SizedBox(height: 25),

                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 25),

                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: controller.isLoading ? null : () {},
                      icon: Image.asset(
                        "assets/icons/google.png",
                        width: 22,
                      ),
                      label: const Text(
                        "Continue with Google",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Text("Don't have an account? "),

                        GestureDetector(
                          onTap: controller.isLoading
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const BasicInfo(),
                                    ),
                                  );
                                },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}