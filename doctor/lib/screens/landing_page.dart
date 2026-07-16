import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';
import 'doctor_login.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 18,
          ),
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: const Color(0xffEEF4FF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/tooth.png",
                    width: 90,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Healthy Smile,\nBetter Life",
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 15),

              const Text(
                "Smart Dental Diagnosis",
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  indicator(true),
                  const SizedBox(width: 8),
                  indicator(false),
                  const SizedBox(width: 8),
                  indicator(false),
                ],
              ),

              const Spacer(),

              CustomButton(
                text: "Get Started →",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DoctorLogin(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget indicator(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: active ? 18 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active
            ? AppColors.primary
            : AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}