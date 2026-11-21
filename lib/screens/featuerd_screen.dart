import 'package:chordefine/constants/color.dart';
import 'package:chordefine/models/category.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kBgLight,
        body: Column(
          children: [
            _AppBar(),
            const SizedBox(height: 8),
            Expanded(child: _Body()),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    return Container(
      height: h * 0.22,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kOrangeGradientStart,
            kOrangeGradientEnd,
          ],
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
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w400,
                fontSize: Responsive.titleSmall(context),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "CHORDEFINE",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: Responsive.titleLarge(context),
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    offset: const Offset(1, 2),
                    blurRadius: 4,
                    color: Colors.black.withValues(alpha: 0.2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
      child: Column(
        children: [
          SizedBox(height: Responsive.height(context) * 0.02),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: Responsive.height(context) * 0.02),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: Responsive.width(context) * 0.04,
                mainAxisSpacing: Responsive.width(context) * 0.04,
              ),
              itemBuilder: (context, index) => _CategoryCard(
                category: categoryList[index],
              ),
              itemCount: categoryList.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFFFCF6F0),
      const Color(0xFFF0F7F4),
      const Color(0xFFF5F0F7),
      const Color(0xFFF0F4F7),
    ];
    final color = colors[categoryList.indexOf(category) % colors.length];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => category.destinationScreen),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
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
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  category.thumbnail,
                  height: Responsive.width(context) * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.cardPadding(context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: Responsive.titleMedium(context),
                        fontWeight: FontWeight.w700,
                        color: kTextPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Responsive.height(context) * 0.006),
                    Text(
                      category.definition,
                      style: TextStyle(
                        fontSize: Responsive.captionText(context),
                        color: kTextSecondary,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
