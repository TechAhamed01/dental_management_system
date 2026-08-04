import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) return;

    final auth = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final success = await auth.login(email, password);

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            auth.errorMessage ?? "Login failed",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF5F8FF),
      body: Stack(
        children: [

          /// Background
          const Positioned.fill(
            child: LoginBackground(),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                child: Container(
                  width: size.width > 700 ? 430 : double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.12),
                        blurRadius: 40,
                        spreadRadius: 5,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 40,
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        //---------------------------------------
                        // LOGO
                        //---------------------------------------

                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(.12),
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.medical_services_rounded,
                            color: AppTheme.primaryColor,
                            size: 40,
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          "Admin Login",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff173B8F),
                              ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Welcome back!\nSign in to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 35),

                        //---------------------------------------
                        // EMAIL
                        //---------------------------------------

                        TextField(
                          controller: _emailController,
                          keyboardType:
                              TextInputType.emailAddress,

                          decoration: InputDecoration(
                            hintText: "Email Address",

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                            ),

                            filled: true,

                            fillColor:
                                const Color(0xffF7F9FC),

                            contentPadding:
                                const EdgeInsets.symmetric(
                              vertical: 18,
                            ),

                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                              borderSide:
                                  BorderSide.none,
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                              borderSide:
                                  BorderSide.none,
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                              borderSide:
                                  const BorderSide(
                                color:
                                    AppTheme.primaryColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        //---------------------------------------
                        // PASSWORD
                        //---------------------------------------

                        TextField(
                          controller:
                              _passwordController,

                          obscureText:
                              _obscurePassword,

                          decoration: InputDecoration(
                            hintText: "Password",

                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            ),

                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword =
                                      !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons
                                        .visibility_off_outlined
                                    : Icons
                                        .visibility_outlined,
                              ),
                            ),

                            filled: true,

                            fillColor:
                                const Color(0xffF7F9FC),

                            contentPadding:
                                const EdgeInsets.symmetric(
                              vertical: 18,
                            ),

                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                              borderSide:
                                  BorderSide.none,
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                              borderSide:
                                  BorderSide.none,
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                              borderSide:
                                  const BorderSide(
                                color:
                                    AppTheme.primaryColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        //---------------------------------------
                        // FORGOT PASSWORD
                        //---------------------------------------

                        Align(
                          alignment:
                              Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},

                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color:
                                    AppTheme.primaryColor,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        //---------------------------------------
                        // LOGIN BUTTON
                        //---------------------------------------

                        SizedBox(
                          width: double.infinity,
                          height: 55,

                          child: ElevatedButton(
                            onPressed:
                                isLoading ? null : _login,

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(
                                      0xff173B8F),

                              elevation: 0,

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(18),
                              ),
                            ),

                            child: isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child:
                                        CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color:
                                          Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                          ),
                        ),

                       

                       
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Background Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffF5F8FF),
                Color(0xffEEF4FF),
                Color(0xffF9FBFF),
              ],
            ),
          ),
        ),

        // Top Left Circle
        Positioned(
          left: -120,
          top: -100,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff1E3A8A).withOpacity(.08),
            ),
          ),
        ),

        // Bottom Right Circle
        Positioned(
          right: -130,
          bottom: -120,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff2563EB).withOpacity(.08),
            ),
          ),
        ),

        // Decorative Left Card
        if (size.width > 900)
          Positioned(
            left: 80,
            top: size.height * .28,
            child: _floatingCard(),
          ),

        // Decorative Right Card
        if (size.width > 900)
          Positioned(
            right: 80,
            top: size.height * .22,
            child: _floatingCard(reverse: true),
          ),

        // Blue Square
        Positioned(
          left: 70,
          bottom: 100,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xff2563EB).withOpacity(.15),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // Small Dot
        Positioned(
          left: 120,
          top: 130,
          child: Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff2563EB),
            ),
          ),
        ),

        Positioned(
          right: 120,
          bottom: 180,
          child: Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff1E3A8A),
            ),
          ),
        ),

        // Medical Crosses
        const Positioned(
          left: 200,
          top: 150,
          child: _PlusDecoration(),
        ),

        const Positioned(
          right: 220,
          top: 120,
          child: _PlusDecoration(),
        ),

        const Positioned(
          left: 260,
          bottom: 180,
          child: _PlusDecoration(),
        ),

        const Positioned(
          right: 260,
          bottom: 120,
          child: _PlusDecoration(),
        ),

        // Decorative Curves
        Positioned(
          left: 50,
          top: 220,
          child: CustomPaint(
            size: const Size(90, 40),
            painter: CurvePainter(),
          ),
        ),

        Positioned(
          right: 60,
          top: 170,
          child: CustomPaint(
            size: const Size(90, 40),
            painter: CurvePainter(),
          ),
        ),
      ],
    );
  }

  Widget _floatingCard({bool reverse = false}) {
    return Transform.rotate(
      angle: reverse ? -.08 : .08,
      child: Container(
        width: 95,
        height: 75,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(.08),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 35,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xff2563EB).withOpacity(.30),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 5,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 5),
            Container(
              width: 45,
              height: 5,
              color: Colors.grey.shade300,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xff2563EB).withOpacity(.15),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PlusDecoration extends StatelessWidget {
  const _PlusDecoration();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.add,
      color: const Color(0xff2563EB).withOpacity(.30),
      size: 22,
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff2563EB).withOpacity(.20)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height / 2);

    path.quadraticBezierTo(
      size.width * .15,
      0,
      size.width * .30,
      size.height / 2,
    );

    path.quadraticBezierTo(
      size.width * .45,
      size.height,
      size.width * .60,
      size.height / 2,
    );

    path.quadraticBezierTo(
      size.width * .75,
      0,
      size.width,
      size.height / 2,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}