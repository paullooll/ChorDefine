import 'package:chordefine/constants/color.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guitar_chord/flutter_guitar_chord.dart';

class ChordLibraryScreen extends StatefulWidget {
  const ChordLibraryScreen({super.key});

  @override
  State<ChordLibraryScreen> createState() => _ChordLibraryScreenState();
}

class _ChordLibraryScreenState extends State<ChordLibraryScreen> {
  final Map<String, List<Map<String, String>>> chordCategories = {
    'A': [
      {
        'frets': '0 0 2 2 2 0',
        'fingers': 'x 0 1 2 3 0',
        'chordName': 'A Major'
      },
      {
        'frets': '0 0 2 2 1 0',
        'fingers': 'X 0 2 3 1 0',
        'chordName': 'A Minor'
      },
      {'frets': '0 0 2 0 2 0', 'fingers': 'X 0 2 0 3 0', 'chordName': 'A7'},
      {
        'frets': '0 0 2 1 2 0',
        'fingers': 'X 0 2 1 3 0',
        'chordName': 'A Major 7'
      },
      {
        'frets': '0 0 2 0 1 0',
        'fingers': 'x 0 2 0 1 0',
        'chordName': 'A Minor 7'
      },
    ],
    'B': [
      {
        'frets': '0 2 4 4 4 2',
        'fingers': 'x 1 2 3 4 1',
        'chordName': 'B Major'
      },
      {
        'frets': '0 2 4 4 3 2',
        'fingers': 'x 1 3 4 2 1',
        'chordName': 'B Minor'
      },
      {'frets': '0 2 1 2 0 0', 'fingers': 'x 2 1 3 0 0', 'chordName': 'B7'},
      {
        'frets': '0 2 0 2 0 2',
        'fingers': 'x 2 0 3 0 4',
        'chordName': 'B Minor 7'
      },
    ],
    'C': [
      {
        'frets': '0 3 2 0 1 0',
        'fingers': 'x 3 2 0 1 0',
        'chordName': 'C Major'
      },
      {'frets': '0 3 2 3 1 0', 'fingers': 'X 3 2 4 1 0', 'chordName': 'C7'},
      {
        'frets': '0 3 2 0 0 0',
        'fingers': 'X 3 2 0 0 0',
        'chordName': 'C Major 7'
      },
    ],
    'D': [
      {
        'frets': '0 0 0 2 3 2',
        'fingers': 'x x 0 1 3 2',
        'chordName': 'D Major'
      },
      {
        'frets': '0 0 0 2 3 1',
        'fingers': 'X x 0 2 3 1',
        'chordName': 'D Minor'
      },
      {'frets': '0 0 0 2 1 2', 'fingers': 'X x 0 2 1 3', 'chordName': 'D7'},
    ],
    'E': [
      {
        'frets': '0 2 2 1 0 0',
        'fingers': '0 2 3 1 0 0',
        'chordName': 'E Major'
      },
      {
        'frets': '0 2 2 0 0 0',
        'fingers': '0 1 2 0 0 0',
        'chordName': 'E Minor'
      },
      {'frets': '0 2 0 1 0 0', 'fingers': '0 2 0 1 0 0', 'chordName': 'E7'},
      {
        'frets': '0 2 1 1 0 0',
        'fingers': '0 3 2 1 0 0',
        'chordName': 'E Major 7'
      },
      {
        'frets': '0 2 0 0 0 0',
        'fingers': '0 1 0 0 0 0',
        'chordName': 'E Minor 7'
      },
    ],
    'F': [
      {
        'frets': '1 3 3 2 1 1',
        'fingers': '1 3 4 2 1 1',
        'chordName': 'F Major'
      },
      {
        'frets': '1 3 3 1 1 1',
        'fingers': '1 3 4 1 1 1',
        'chordName': 'F Minor'
      },
      {'frets': '1 3 1 2 1 1', 'fingers': '1 3 1 2 1 1', 'chordName': 'F7'},
      {
        'frets': '0 3 2 0 0 0',
        'fingers': 'X 3 2 0 0 0',
        'chordName': 'F Major 7'
      },
      {
        'frets': '0 3 5 3 4 3',
        'fingers': 'X 1 3 1 2 1',
        'chordName': 'F Minor 7'
      },
    ],
    'G': [
      {
        'frets': '3 2 0 0 0 3',
        'fingers': '3 2 0 0 0 4',
        'chordName': 'G Major'
      },
      {
        'frets': '3 1 0 0 0 3',
        'fingers': '3 1 0 0 0 4',
        'chordName': 'G Minor'
      },
      {'frets': '3 2 0 0 0 1', 'fingers': '3 2 0 0 0 1', 'chordName': 'G7'},
      {
        'frets': '3 2 0 0 0 2',
        'fingers': '3 2 0 0 0 2',
        'chordName': 'G Major 7'
      },
      {
        'frets': '3 1 0 0 0 1',
        'fingers': '3 1 0 0 0 1',
        'chordName': 'G Minor 7'
      },
    ],
  };

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
              _ChordLibraryHeader(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.horizontalPadding(context),
                    vertical: Responsive.height(context) * 0.015,
                  ),
                  children: chordCategories.entries.map((entry) {
                    String category = entry.key;
                    List<Map<String, String>> chords = entry.value;
                    return _ChordCategoryTile(
                      category: category,
                      chords: chords,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChordLibraryHeader extends StatelessWidget {
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
              'Chord Library',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Responsive.titleLarge(context),
                color: Colors.white,
              ),
            ),
            SizedBox(height: Responsive.height(context) * 0.006),
            Text(
              'Browse chords by key',
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

class _ChordCategoryTile extends StatelessWidget {
  final String category;
  final List<Map<String, String>> chords;

  const _ChordCategoryTile({
    required this.category,
    required this.chords,
  });

  String _parseFrets(String frets) {
    return frets.replaceAll('x', 'X').replaceAll('-1', 'X');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.height(context) * 0.015),
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
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(
          horizontal: Responsive.cardPadding(context),
          vertical: Responsive.height(context) * 0.006,
        ),
        shape: const Border(),
        collapsedShape: const Border(),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            category,
            style: TextStyle(
              fontSize: Responsive.titleMedium(context),
              fontWeight: FontWeight.w800,
              color: primaryColor,
            ),
          ),
        ),
        title: Text(
          '$category Chords',
          style: TextStyle(
            fontSize: Responsive.titleSmall(context),
            fontWeight: FontWeight.w700,
            color: kTextPrimary,
          ),
        ),
        subtitle: Text(
          '${chords.length} chords',
          style: TextStyle(
            fontSize: Responsive.captionText(context),
            color: kTextSecondary,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(Responsive.cardPadding(context)),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chords.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: Responsive.width(context) * 0.03,
                mainAxisSpacing: Responsive.width(context) * 0.03,
              ),
              itemBuilder: (context, index) {
                Map<String, String> chord = chords[index];
                return Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: kBgLight,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: FlutterGuitarChord(
                      frets: _parseFrets(chord['frets']!),
                      fingers: chord['fingers']!,
                      baseFret: 1,
                      chordName: chord['chordName']!,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
