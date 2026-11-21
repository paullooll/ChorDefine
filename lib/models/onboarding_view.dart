import 'package:chordefine/constants/color.dart';
import 'package:chordefine/models/onboarding_items.dart';
import 'package:chordefine/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgLight,
      bottomSheet: Container(
        color: kBgLight,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: isLastPage ? _getStarted() : _bottomNav(),
      ),
      body: SafeArea(
        child: PageView.builder(
          onPageChanged: (index) => setState(
              () => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Image.asset(
                    controller.items[index].image,
                    height: MediaQuery.of(context).size.width * 0.65,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: kCardWhite,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          controller.items[index].title,
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.065,
                            fontWeight: FontWeight.w800,
                            color: kTextPrimary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.015,
                        ),
                        Text(
                          controller.items[index].descriptions,
                          style: TextStyle(
                            color: kTextSecondary,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.04,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bottomNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () =>
              pageController.jumpToPage(controller.items.length - 1),
          child: Text(
            "Skip",
            style: TextStyle(
              fontSize: 16,
              color: kTextSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: controller.items.length,
          onDotClicked: (index) => pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeIn,
          ),
          effect: const WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: primaryColor,
            dotColor: Color(0xFFE0E0E0),
          ),
        ),
        TextButton(
          onPressed: () => pageController.nextPage(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeIn,
          ),
          child: Text(
            "Next",
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getStarted() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool("onboarding", true);
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BaseScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Get Started",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
