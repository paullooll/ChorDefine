import 'package:chordefine/constants/color.dart';
import 'package:chordefine/screens/major2.dart';
import 'package:chordefine/screens/minor2.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PracticeScreenMajorController());
    Get.lazyPut(() => PracticeScreenMinorController());
    final majorController = Get.find<PracticeScreenMajorController>();
    final minorController = Get.find<PracticeScreenMinorController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            SizedBox(height: Responsive.height(context) * 0.02),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
                child: Obx(() {
                  final majorChords = majorController.completedChords.toList();
                  final minorChords = minorController.completedChords.toList();
                  final totalCompleted = majorChords.length + minorChords.length;
                  final progress = totalCompleted / 14;

                  return Column(
                    children: [
                      _ProgressCard(progress: progress, totalCompleted: totalCompleted),
                      SizedBox(height: Responsive.height(context) * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Achievements",
                            style: TextStyle(
                              fontSize: Responsive.titleSmall(context),
                              fontWeight: FontWeight.w700,
                              color: kTextPrimary,
                            ),
                          ),
                          if (majorChords.isNotEmpty || minorChords.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                majorController.clearNotifications();
                                minorController.clearNotifications();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Clear All",
                                  style: TextStyle(
                                    fontSize: Responsive.captionText(context),
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: Responsive.height(context) * 0.015),
                      Expanded(
                        child: majorChords.isEmpty && minorChords.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.music_note_outlined,
                                        size: 64, color: Colors.grey[300]),
                                    const SizedBox(height: 16),
                                    Text(
                                      "No completed chords yet",
                                      style: TextStyle(
                                        fontSize: Responsive.bodyText(context),
                                        color: kTextSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Practice your first chord to get started!",
                                      style: TextStyle(
                                        fontSize: Responsive.captionText(context),
                                        color: kTextSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView(
                                children: [
                                  if (majorChords.isNotEmpty) ...[
                                    _SectionHeader("Major Chords", majorChords.length),
                                    ...majorChords.map((chord) => _ChordTile(chord: chord, isMajor: true)),
                                  ],
                                  if (minorChords.isNotEmpty) ...[
                                    SizedBox(height: Responsive.height(context) * 0.015),
                                    _SectionHeader("Minor Chords", minorChords.length),
                                    ...minorChords.map((chord) => _ChordTile(chord: chord, isMajor: false)),
                                  ],
                                ],
                              ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
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
        top: Responsive.height(context) * 0.06,
        bottom: Responsive.height(context) * 0.025,
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
            "Completed Chords",
            style: TextStyle(
              fontSize: Responsive.titleLarge(context),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.006),
          Text(
            "Track your learning journey",
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

class _ProgressCard extends StatelessWidget {
  final double progress;
  final int totalCompleted;
  const _ProgressCard({required this.progress, required this.totalCompleted});

  @override
  Widget build(BuildContext context) {
    final isCompleted = progress >= 1.0;
    return Container(
      padding: EdgeInsets.all(Responsive.cardPadding(context)),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isCompleted ? kSuccess.withValues(alpha: 0.1) : kWarning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isCompleted ? Icons.check_circle : Icons.trending_up,
                  color: isCompleted ? kSuccess : kWarning,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCompleted ? "All Complete!" : "Keep Going!",
                      style: TextStyle(
                        fontSize: Responsive.titleSmall(context),
                        fontWeight: FontWeight.w700,
                        color: kTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "$totalCompleted of 14 chords mastered",
                      style: TextStyle(
                        fontSize: Responsive.captionText(context),
                        color: kTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: Responsive.titleMedium(context),
                  fontWeight: FontWeight.w800,
                  color: isCompleted ? kSuccess : kWarning,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context) * 0.015),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                isCompleted ? kSuccess : kWarning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const _SectionHeader(this.title, this.count);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.height(context) * 0.008),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.titleSmall(context),
              fontWeight: FontWeight.w700,
              color: kTextPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$count",
              style: TextStyle(
                fontSize: Responsive.captionText(context),
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChordTile extends StatelessWidget {
  final String chord;
  final bool isMajor;
  const _ChordTile({required this.chord, required this.isMajor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.height(context) * 0.008),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.cardPadding(context),
        vertical: Responsive.height(context) * 0.012,
      ),
      decoration: BoxDecoration(
        color: kCardWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: kSuccess.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.check_circle, color: kSuccess, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isMajor ? "$chord Major" : chord,
              style: TextStyle(
                fontSize: Responsive.bodyText(context),
                fontWeight: FontWeight.w600,
                color: kTextPrimary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: kSuccess.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Done",
              style: TextStyle(
                fontSize: Responsive.captionText(context),
                fontWeight: FontWeight.w500,
                color: kSuccess,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
