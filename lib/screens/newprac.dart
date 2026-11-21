import 'package:chordefine/constants/color.dart';
import 'package:chordefine/models/chords.dart';
import 'package:chordefine/screens/major2.dart';
import 'package:chordefine/screens/minor2.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PracNew extends StatefulWidget {
  const PracNew({super.key});

  @override
  State<PracNew> createState() => _PracNewState();
}

class _PracNewState extends State<PracNew> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kBgLight,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.horizontalPadding(context),
                    vertical: Responsive.height(context) * 0.015,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      bottom: Responsive.height(context) * 0.02,
                    ),
                    separatorBuilder: (_, __) => SizedBox(
                      height: Responsive.height(context) * 0.015,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (_, int index) => _ChordCard(
                      chord: chords[index],
                    ),
                    itemCount: chords.length,
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

class _Header extends StatelessWidget {
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
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.015),
          Text(
            'Chords',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Responsive.titleLarge(context),
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.006),
          Text(
            'Choose a chord type to practice',
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

class _ChordCard extends StatelessWidget {
  final ChordModel chord;
  const _ChordCard({required this.chord});

  @override
  Widget build(BuildContext context) {
    final isMajor = chord.name == 'Major Chords';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => isMajor
                ? const PracticeScreenMajor(title: 'Major Chords')
                : const PracticeScreenMinor(title: 'Minor Chords'),
          ),
        );
      },
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (isMajor ? kSuccess : kWarning).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  chord.thumbnail,
                  height: Responsive.cardImageSize(context),
                  width: Responsive.cardImageSize(context),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: Responsive.width(context) * 0.035),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chord.name,
                    style: TextStyle(
                      fontSize: Responsive.titleSmall(context),
                      fontWeight: FontWeight.w700,
                      color: kTextPrimary,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context) * 0.006),
                  Text(
                    chord.description,
                    style: TextStyle(
                      fontSize: Responsive.bodyText(context),
                      color: kTextSecondary,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: Responsive.width(context) * 0.02),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (isMajor ? kSuccess : kWarning).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: Responsive.iconSize(context) * 0.6,
                color: isMajor ? kSuccess : kWarning,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
