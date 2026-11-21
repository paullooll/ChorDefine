import 'package:chordefine/constants/color.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class EarTrainerScreen extends StatefulWidget {
  const EarTrainerScreen({super.key});

  @override
  State<EarTrainerScreen> createState() => _EarTrainerScreenState();
}

class _EarTrainerScreenState extends State<EarTrainerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playAudio(String fileName) async {
    await _audioPlayer.play(AssetSource('audio/$fileName'));
  }

  final List<String> wavFiles = [
    'a.wav', 'am.wav', 'b.wav', 'bm.wav',
    'c.wav', 'cm.wav', 'd.wav', 'dm.wav',
    'e.wav', 'em.wav', 'f.wav', 'fm.wav',
    'g.wav', 'gm.wav',
  ];

  final List<String> labels = [
    'A Major', 'A Minor', 'B Major', 'B Minor',
    'C Major', 'C Minor', 'D Major', 'D Minor',
    'E Major', 'E Minor', 'F Major', 'F Minor',
    'G Major', 'G Minor',
  ];

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
              _EarTrainerHeader(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.horizontalPadding(context),
                    vertical: Responsive.height(context) * 0.02,
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                      bottom: Responsive.height(context) * 0.02,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: Responsive.width(context) * 0.04,
                      mainAxisSpacing: Responsive.width(context) * 0.04,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _playAudio(wavFiles[index]),
                        child: Container(
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
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: primaryColor.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.music_note,
                                  size: Responsive.iconSize(context),
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(
                                  height: Responsive.height(context) * 0.012),
                              Text(
                                labels[index],
                                style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: Responsive.titleSmall(context),
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                  height: Responsive.height(context) * 0.004),
                              Text(
                                'Tap to play',
                                style: TextStyle(
                                  fontSize: Responsive.captionText(context),
                                  color: kTextSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class _EarTrainerHeader extends StatelessWidget {
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
              'Ear Trainer',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Responsive.titleLarge(context),
                color: Colors.white,
              ),
            ),
            SizedBox(height: Responsive.height(context) * 0.006),
            Text(
              'Train your ear to recognize chord sounds',
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
