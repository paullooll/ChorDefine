import 'package:chordefine/constants/color.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuitarChordsScreen extends StatelessWidget {
  const GuitarChordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kBgLight,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _GuitarChordsHeader(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.horizontalPadding(context),
                    vertical: Responsive.height(context) * 0.015,
                  ),
                  children: const [
                    _ChordBox(
                      chordName: 'A Major',
                      description:
                          'A Major is a bright, open-sounding chord used in many genres, especially in pop and rock.',
                      imagePath: 'assets/picture/17.png',
                    ),
                    _ChordBox(
                      chordName: 'B Major',
                      description:
                          'B Major is a bit harder to play due to its barre position, but essential for songs in major keys.',
                      imagePath: 'assets/picture/19.png',
                    ),
                    _ChordBox(
                      chordName: 'C Major',
                      description:
                          'C Major is one of the most fundamental chords in guitar, used in various styles of music.',
                      imagePath: 'assets/picture/20.png',
                    ),
                    _ChordBox(
                      chordName: 'D Major',
                      description:
                          'D Major is a high-pitched chord that fits well in folk, pop, and rock songs, easy to transition into.',
                      imagePath: 'assets/picture/21.png',
                    ),
                    _ChordBox(
                      chordName: 'E Major',
                      description:
                          'E Major is powerful and resonant, forming the basis for many classic rock and blues tunes.',
                      imagePath: 'assets/picture/22.png',
                    ),
                    _ChordBox(
                      chordName: 'F Major',
                      description:
                          'F Major requires a barre, making it a challenge for beginners, but it\'s crucial for many genres.',
                      imagePath: 'assets/picture/23.png',
                    ),
                    _ChordBox(
                      chordName: 'G Major',
                      description:
                          'G Major is one of the first chords beginners learn, offering a full, rich sound perfect for many styles.',
                      imagePath: 'assets/picture/24.png',
                    ),
                    _ChordBox(
                      chordName: 'A Minor',
                      description:
                          'A Minor has a moody, somber tone and is often used to convey emotion in various genres.',
                      imagePath: 'assets/picture/14.png',
                    ),
                    _ChordBox(
                      chordName: 'B Minor',
                      description:
                          'B Minor is often found in ballads and blues, adding depth and warmth to a song\'s feel.',
                      imagePath: 'assets/picture/14.png',
                    ),
                    _ChordBox(
                      chordName: 'C Minor',
                      description:
                          'C Minor evokes a dramatic, introspective sound, frequently appearing in rock and classical music.',
                      imagePath: 'assets/picture/cminor1.jpg',
                    ),
                    _ChordBox(
                      chordName: 'D Minor',
                      description:
                          'D Minor has a dark, melancholic sound, often used in folk and classical music to convey sadness.',
                      imagePath: 'assets/picture/15.png',
                    ),
                    _ChordBox(
                      chordName: 'E Minor',
                      description:
                          'E Minor is one of the most popular minor chords, known for its versatility and moody sound.',
                      imagePath: 'assets/picture/16.png',
                    ),
                    _ChordBox(
                      chordName: 'F Minor',
                      description:
                          'F Minor brings a deep, rich quality to music, commonly used in soul and pop for its emotional resonance.',
                      imagePath: 'assets/picture/fminor1.jpg',
                    ),
                    _ChordBox(
                      chordName: 'G Minor',
                      description:
                          'G Minor has a mysterious, evocative tone, popular in both classical compositions and modern genres.',
                      imagePath: 'assets/picture/gminor1.jpg',
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

class _GuitarChordsHeader extends StatelessWidget {
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
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            ),
            SizedBox(height: Responsive.height(context) * 0.015),
            Text(
              'Basic Guitar Chords',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Responsive.titleLarge(context),
                color: Colors.white,
              ),
            ),
            SizedBox(height: Responsive.height(context) * 0.006),
            Text(
              'Learn the essential open chords',
              style: TextStyle(
                fontSize: Responsive.bodyText(context),
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChordBox extends StatelessWidget {
  final String chordName;
  final String description;
  final String imagePath;

  const _ChordBox({
    required this.chordName,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.height(context) * 0.015),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              height: Responsive.width(context) * 0.28,
              width: Responsive.width(context) * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: Responsive.width(context) * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chordName,
                  style: TextStyle(
                    fontSize: Responsive.titleSmall(context),
                    fontWeight: FontWeight.w700,
                    color: kTextPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Responsive.height(context) * 0.006),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: Responsive.captionText(context),
                    color: kTextSecondary,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
