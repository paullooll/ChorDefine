import 'package:chordefine/constants/color.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const SettingsPage(
      {super.key, required this.isDarkMode, required this.onDarkModeChanged});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kBgLight,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SettingsHeader(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.horizontalPadding(context),
                    vertical: Responsive.height(context) * 0.025,
                  ),
                  child: Column(
                    children: [
                      _SettingsCard(
                        icon: Icons.groups_2,
                        label: 'About Us',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutUsPage()),
                          );
                        },
                      ),
                      SizedBox(
                          height: Responsive.height(context) * 0.015),
                      _SettingsCard(
                        icon: Icons.contact_support,
                        label: 'About the App',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutAppPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Responsive.height(context) * 0.06,
        bottom: Responsive.height(context) * 0.03,
        left: Responsive.horizontalPadding(context),
        right: Responsive.horizontalPadding(context),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kOrangeGradientStart, kOrangeGradientEnd],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Responsive.titleLarge(context),
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.006),
          Text(
            'App info and preferences',
            style: TextStyle(
              fontSize: Responsive.bodyText(context),
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingsCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Responsive.cardPadding(context)),
        decoration: BoxDecoration(
          color: kCardWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 28, color: primaryColor),
            ),
            SizedBox(width: Responsive.width(context) * 0.035),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: Responsive.titleSmall(context),
                  fontWeight: FontWeight.w600,
                  color: kTextPrimary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: Responsive.iconSize(context) * 0.6,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> developers = [
      {
        "name": "Richie Paul Aquiño",
        "image": "assets/images/richie.jpeg",
        "description": "Developer 1"
      },
      {
        "name": "Willie Deadio Jr.",
        "image": "assets/images/willie.jpg",
        "description": "Developer 2"
      },
      {
        "name": "Job Russel Destor",
        "image": "assets/images/job.jpg",
        "description": "Developer 3"
      },
      {
        "name": "Ron Philip Magpantay",
        "image": "assets/images/ron.jpg",
        "description": "Developer 4"
      },
      {
        "name": "Jose Miguell Monsale",
        "image": "assets/images/miggy.jpg",
        "description": "Developer 5"
      },
      {
        "name": "Ralph Voltaire Dayot",
        "image": "assets/images/dayot.jpg",
        "description": "Thesis Adviser"
      },
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kBgLight,
        body: SafeArea(
          child: Column(
            children: [
              _AboutHeader(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.horizontalPadding(context),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          height: Responsive.height(context) * 0.02),
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.only(
                            bottom: Responsive.height(context) * 0.02,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing:
                                Responsive.width(context) * 0.04,
                            crossAxisSpacing:
                                Responsive.width(context) * 0.04,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: developers.length,
                          itemBuilder: (context, index) {
                            return _DeveloperCard(
                              name: developers[index]['name']!,
                              imagePath: developers[index]['image']!,
                              description:
                                  developers[index]['description']!,
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: Responsive.height(context) * 0.025,
                        ),
                        padding: EdgeInsets.all(
                            Responsive.cardPadding(context)),
                        decoration: BoxDecoration(
                          color: kCardWhite,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'ChordDefine is developed by five BSIT students at West Visayas State University. '
                          'Our mission is to create an accessible, engaging, and user-friendly mobile application for guitar enthusiasts.',
                          style: TextStyle(
                            fontSize: Responsive.bodyText(context),
                            height: 1.5,
                            color: kTextPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Responsive.height(context) * 0.04,
        bottom: Responsive.height(context) * 0.03,
        left: Responsive.horizontalPadding(context),
        right: Responsive.horizontalPadding(context),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kOrangeGradientStart, kOrangeGradientEnd],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back,
                  color: Colors.white, size: 22),
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.015),
          Text(
            'About Us',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Responsive.titleLarge(context),
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.006),
          Text(
            'Meet the team behind ChordDefine',
            style: TextStyle(
              fontSize: Responsive.bodyText(context),
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeveloperCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String description;

  const _DeveloperCard({
    required this.name,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.cardPadding(context) * 0.8),
      decoration: BoxDecoration(
        color: kCardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              imagePath,
              height: Responsive.width(context) * 0.25,
              width: Responsive.width(context) * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.012),
          Text(
            name,
            style: TextStyle(
              fontSize: Responsive.bodyText(context),
              fontWeight: FontWeight.w700,
              color: kTextPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Responsive.height(context) * 0.004),
          Text(
            description,
            style: TextStyle(
              fontSize: Responsive.captionText(context),
              color: kTextSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kBgLight,
        body: SafeArea(
          child: Column(
            children: [
              _AboutAppHeader(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.horizontalPadding(context),
                    vertical: Responsive.height(context) * 0.025,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/logo.png',
                          height: Responsive.width(context) * 0.5,
                          width: Responsive.width(context) * 0.5,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                            height: Responsive.height(context) * 0.03),
                        Container(
                          padding: EdgeInsets.all(
                              Responsive.cardPadding(context)),
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
                          child: Text(
                            'ChordDefine is an innovative mobile application specifically designed to assist beginner guitarists in mastering their instrument through real-time chord recognition. '
                            'This app offers a comprehensive solution by integrating advanced computer vision and audio recognition technologies to enhance the learning experience.',
                            style: TextStyle(
                              fontSize: Responsive.bodyText(context),
                              height: 1.5,
                              color: kTextPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}

class _AboutAppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Responsive.height(context) * 0.04,
        bottom: Responsive.height(context) * 0.03,
        left: Responsive.horizontalPadding(context),
        right: Responsive.horizontalPadding(context),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kOrangeGradientStart, kOrangeGradientEnd],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back,
                  color: Colors.white, size: 22),
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.015),
          Text(
            'About the App',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Responsive.titleLarge(context),
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.006),
          Text(
            'Learn more about ChordDefine',
            style: TextStyle(
              fontSize: Responsive.bodyText(context),
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
