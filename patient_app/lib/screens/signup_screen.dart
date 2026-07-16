import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Consumer<AuthController>(
              builder: (context, controller, child) {
                return Column(
                  children: [
                    const SizedBox(height: 40),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2155D6),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Sign up to get started",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 35),

                    // Full Name
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Full Name",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: nameController,
                      readOnly: controller.isLoading,
                      decoration: InputDecoration(
                        hintText: "Enter your full name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your full name";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    // Email
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: controller.isLoading,
                      decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Gmail address";
                        }

                        if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
                        ).hasMatch(value)) {
                          return "Enter a valid Gmail address";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    // Mobile Number
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mobile Number",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      readOnly: controller.isLoading,
                      decoration: InputDecoration(
                        hintText: "Enter mobile number",
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter mobile number";
                        }

                        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return "Mobile number must contain exactly 10 digits";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    // Password
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      readOnly: controller.isLoading,
                      decoration: InputDecoration(
                        hintText: "Minimum 8 characters",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }

                        if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    // Confirm Password
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfirmPassword,
                      readOnly: controller.isLoading,
                      decoration: InputDecoration(
                        hintText: "Re-enter password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureConfirmPassword =
                                  !obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm password";
                        }

                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2D6BFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: controller.isLoading
                            ? null
                            : () async {
                                debugPrint("[SignupScreen] Signup button pressed");
                                if (_formKey.currentState!.validate()) {
                                  final success = await controller.register(
                                    fullName: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    password: passwordController.text,
                                  );

                                  if (!context.mounted) return;

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Account Created Successfully"),
                                      ),
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                    );
                                  } else {
                                    final error = controller.errorMessage ??
                                        "Registration failed. Please try again.";
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(error),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                        child: controller.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: controller.isLoading
                              ? null
                              : () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Color(0xff2155D6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}