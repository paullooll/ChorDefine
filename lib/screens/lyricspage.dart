import 'package:chordefine/constants/color.dart';
import 'package:chordefine/screens/major2.dart';
import 'package:chordefine/screens/minor2.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'dart:typed_data';

class CourseScreen3 extends StatefulWidget {
  const CourseScreen3({super.key});

  @override
  State<CourseScreen3> createState() => _CourseScreen3State();
}

class _CourseScreen3State extends State<CourseScreen3> {
  final List<String> exploreItems = [
    'Happy Birthday', 'Perfect', 'Im Yours', 'Country Roads', 'Let it Be',
  ];

  final List<String> songArtist = [
    'Traditional', 'Ed Sheeran', 'Jason Mraz', 'John Denver', 'The Beatles',
  ];

  final Map<String, List<SongLine>> songData = {
    'Happy Birthday': [
      SongLine(lyrics: "Happy birthday to you", note: "G1", chord: "G"),
      SongLine(lyrics: "Happy birthday to you", note: "D1", chord: "D"),
      SongLine(lyrics: "Happy birthday dear friend", note: "C1", chord: "C"),
      SongLine(lyrics: "Happy birthday to you!", note: "G1", chord: "G"),
    ],
    'Perfect': [
      SongLine(lyrics: "Baby, I'm", note: "E1", chord: "E"),
      SongLine(lyrics: "dancing in", note: "C2", chord: "C"),
      SongLine(lyrics: "the dark,", note: "G1", chord: "G"),
      SongLine(lyrics: "with you", note: "D1", chord: "D"),
      SongLine(lyrics: "between my arms", note: "E1", chord: "E"),
      SongLine(lyrics: "barefoot on the grass,", note: "C2", chord: "C"),
      SongLine(lyrics: "listening", note: "G1", chord: "G"),
      SongLine(lyrics: "to our favorite song", note: "D1", chord: "D"),
      SongLine(lyrics: "when you said you looked", note: "C2", chord: "C"),
      SongLine(lyrics: "a mess,", note: "G1", chord: "G"),
      SongLine(lyrics: "I whispered", note: "D1", chord: "D"),
      SongLine(lyrics: "underneath my breath", note: "E1", chord: "E"),
      SongLine(lyrics: "But you heard it,", note: "C2", chord: "C"),
      SongLine(lyrics: "darling you", note: "G1", chord: "G"),
      SongLine(lyrics: "look perfect", note: "D1", chord: "D"),
      SongLine(lyrics: "tonight", note: "G1", chord: "G"),
    ],
    'Im Yours': [
      SongLine(lyrics: "So I won't,", note: "G1", chord: "G"),
      SongLine(lyrics: "hesitate", note: "D1", chord: "D"),
      SongLine(lyrics: "No, more, no more", note: "E1", chord: "E"),
      SongLine(lyrics: "It cannot wait, I'm sure", note: "C2", chord: "C"),
      SongLine(lyrics: "There's no need,", note: "G1", chord: "G"),
      SongLine(lyrics: "To complicate", note: "D1", chord: "D"),
      SongLine(lyrics: "Our time is short", note: "E1", chord: "E"),
      SongLine(lyrics: "This is our fate, I'm yours", note: "C2", chord: "C"),
    ],
    'Country Roads': [
      SongLine(lyrics: "Country Roads,", note: "G1", chord: "G"),
      SongLine(lyrics: "take me home,", note: "D1", chord: "D"),
      SongLine(lyrics: "to the place,", note: "E1", chord: "E"),
      SongLine(lyrics: "I belong", note: "C2", chord: "C"),
      SongLine(lyrics: "West Virginia,", note: "G1", chord: "G"),
      SongLine(lyrics: "mountain mama,", note: "D1", chord: "D"),
      SongLine(lyrics: "take me home,", note: "C2", chord: "C"),
      SongLine(lyrics: "country roads,", note: "G1", chord: "G"),
      SongLine(lyrics: "Country Roads,", note: "G1", chord: "G"),
      SongLine(lyrics: "take me home,", note: "D1", chord: "D"),
      SongLine(lyrics: "to the place,", note: "E1", chord: "E"),
      SongLine(lyrics: "I belong", note: "C2", chord: "C"),
      SongLine(lyrics: "West Virginia,", note: "G1", chord: "G"),
      SongLine(lyrics: "mountain mama,", note: "D1", chord: "D"),
      SongLine(lyrics: "take me home,", note: "C2", chord: "C"),
      SongLine(lyrics: "country roads,", note: "G1", chord: "G"),
    ],
    'Let it Be': [
      SongLine(lyrics: "Let it be,", note: "A1", chord: "A"),
      SongLine(lyrics: "let it be,", note: "G1", chord: "G"),
      SongLine(lyrics: "let it be,", note: "F1", chord: "F"),
      SongLine(lyrics: "let it be,", note: "C1", chord: "C"),
      SongLine(lyrics: "There will be,", note: "C1", chord: "C"),
      SongLine(lyrics: "an answer,", note: "G1", chord: "G"),
      SongLine(lyrics: "Let it be,", note: "F1", chord: "F"),
      SongLine(lyrics: "Let it be,", note: "A1", chord: "A"),
      SongLine(lyrics: "let it be,", note: "G1", chord: "G"),
      SongLine(lyrics: "let it be,", note: "F1", chord: "F"),
      SongLine(lyrics: "let it be,", note: "C1", chord: "C"),
      SongLine(lyrics: "Whisper words,", note: "C1", chord: "C"),
      SongLine(lyrics: "of wisdom,", note: "G1", chord: "G"),
      SongLine(lyrics: "let it be,", note: "F1", chord: "F"),
    ]
  };

  @override
  Widget build(BuildContext context) {
    final majorController = Get.find<PracticeScreenMajorController>();
    final minorController = Get.find<PracticeScreenMinorController>();
    return Scaffold(
      backgroundColor: kBgLight,
      body: SafeArea(
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
                  itemCount: exploreItems.length,
                  itemBuilder: (context, index) {
                    final songTitle = exploreItems[index];
                    final artist = songArtist[index];
                    bool allCompleted =
                        majorController.areAllChordsCompleted() &&
                            minorController.areAllChordsCompleted();

                    return _SongCard(
                      songTitle: songTitle,
                      artist: artist,
                      locked: !allCompleted,
                      onTap: allCompleted
                          ? () {
                              final songLines = songData[songTitle] ?? [];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LyricsScreen(
                                    title: songTitle,
                                    artist: artist,
                                    songLines: songLines,
                                  ),
                                ),
                              );
                            }
                          : null,
                    );
                  },
                ),
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
            'Explore',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Responsive.titleLarge(context),
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.006),
          Text(
            'Jam along with your favorite songs',
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

class _SongCard extends StatelessWidget {
  final String songTitle;
  final String artist;
  final bool locked;
  final VoidCallback? onTap;

  const _SongCard({
    required this.songTitle,
    required this.artist,
    required this.locked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Responsive.cardPadding(context)),
        decoration: BoxDecoration(
          color: locked ? Colors.grey[100] : kCardWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: locked ? 0.02 : 0.06),
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
                color: (locked ? Colors.grey : primaryColor).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                locked ? Icons.lock : Icons.music_note,
                size: 28,
                color: locked ? Colors.grey[400] : primaryColor,
              ),
            ),
            SizedBox(width: Responsive.width(context) * 0.035),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songTitle,
                    style: TextStyle(
                      fontSize: Responsive.titleSmall(context),
                      fontWeight: FontWeight.w700,
                      color: locked ? Colors.grey[400] : kTextPrimary,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context) * 0.004),
                  Text(
                    artist,
                    style: TextStyle(
                      fontSize: Responsive.bodyText(context),
                      color: locked ? Colors.grey[300] : kTextSecondary,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context) * 0.006),
                  Text(
                    locked ? 'Complete all chords to unlock' : 'Tap to view lyrics and chords',
                    style: TextStyle(
                      fontSize: Responsive.captionText(context),
                      color: locked ? Colors.grey[300] : primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            if (!locked)
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

class LyricsScreen extends StatelessWidget {
  final String title;
  final String artist;
  final List<SongLine> songLines;

  const LyricsScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.songLines,
  });

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<NoteChordController>()) {
      Get.delete<NoteChordController>();
    }
    final controller = Get.put(NoteChordController(currentSong: songLines));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text(artist, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(Responsive.horizontalPadding(context)),
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
              child: SingleChildScrollView(
                child: Column(
                  children: songLines.map((line) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.height(context) * 0.004,
                      ),
                      child: Text(
                        line.lyrics,
                        style: TextStyle(
                          fontSize: Responsive.bodyText(context),
                          fontFamily: 'Courier',
                          height: 1.5,
                          color: kTextPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.horizontalPadding(context),
              0,
              Responsive.horizontalPadding(context),
              Responsive.height(context) * 0.03,
            ),
            child: Obx(() {
              if (!controller.hasAudioPermission.value) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.mic_off, color: kWarning),
                      const SizedBox(width: 10),
                      Text(
                        "Microphone permission required",
                        style: TextStyle(color: kWarning, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }

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
                    Text(
                      "Sing the lyrics!",
                      style: TextStyle(
                        fontSize: Responsive.titleSmall(context),
                        fontWeight: FontWeight.w700,
                        color: kTextPrimary,
                      ),
                    ),
                    SizedBox(height: Responsive.height(context) * 0.02),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        controller.currentSong[controller.currentIndex.value].lyrics,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Responsive.titleMedium(context),
                          fontWeight: FontWeight.w700,
                          color: kTextPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.height(context) * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Expected Chord: ",
                          style: TextStyle(
                            fontSize: Responsive.bodyText(context),
                            color: kTextSecondary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            controller.currentSong[controller.currentIndex.value].chord,
                            style: TextStyle(
                              fontSize: Responsive.bodyText(context),
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class NoteChordController extends GetxController {
  final List<SongLine> currentSong;
  final _audioRecorder = FlutterAudioCapture();
  late final PitchDetector pitchDetectorDart;
  var hasAudioPermission = false.obs;
  var currentPitch = 0.0.obs;
  var detectedChord = ''.obs;
  var currentIndex = 0.obs;

  NoteChordController({required this.currentSong});

  @override
  void onInit() {
    super.onInit();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _audioRecorder.init();
    pitchDetectorDart = PitchDetector(audioSampleRate: 44100, bufferSize: 2048);
    recordPerm();
  }

  Future<void> recordPerm() async {
    if (await Permission.microphone.request().isGranted) {
      hasAudioPermission.value = true;
      startCapture();
    }
  }

  Future<void> startCapture() async {
    await _audioRecorder.start(listener, error,
        sampleRate: 44100, bufferSize: 2048);
  }

  void listener(Float32List obj) {
    final List<double> audioSample = obj.toList();
    pitchDetectorDart.getPitchFromFloatBuffer(audioSample).then((result) {
      if (result.pitched) {
        currentPitch.value = result.pitch;
        detectedChord.value = findChord(result.pitch);
        if (detectedChord.value == currentSong[currentIndex.value].chord) {
          if (currentIndex.value < currentSong.length - 1) {
            currentIndex.value++;
          } else {
            currentIndex.value = 0;
          }
        }
      }
    });
  }

  String findChord(double frequency) {
    double minDifference = double.infinity;
    String closestNote = '';
    noteFrequencies.forEach((freq, note) {
      double difference = (frequency - freq).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closestNote = note;
      }
    });
    return identifyChord([closestNote]);
  }

  void error(Object e) {
    debugPrint('Error in audio capture: $e');
  }

  @override
  void onClose() {
    _audioRecorder.stop();
    super.onClose();
  }
}

class SongLine {
  final String lyrics;
  final String note;
  final String chord;
  SongLine({required this.lyrics, required this.note, required this.chord});
}

String identifyChord(List<String> notes) {
  Set<String> noteSet = notes.toSet();
  if (noteSet.contains('A1') || noteSet.contains('A2')) return 'A';
  if (noteSet.contains('A1') || noteSet.contains('A2')) return 'Am';
  if (noteSet.contains('B1') || noteSet.contains('B2')) return 'B';
  if (noteSet.contains('B1') || noteSet.contains('B2')) return 'Bm';
  if (noteSet.contains('C2') || noteSet.contains('C3')) return 'C';
  if (noteSet.contains('C2') || noteSet.contains('C3')) return 'Cm';
  if (noteSet.contains('D1') || noteSet.contains('D3')) return 'D';
  if (noteSet.contains('D1') || noteSet.contains('D3')) return 'Dm';
  if (noteSet.contains('E1') || noteSet.contains('E2')) return 'E';
  if (noteSet.contains('E1') || noteSet.contains('E2')) return 'Em';
  if (noteSet.contains('F1') || noteSet.contains('F2')) return 'F';
  if (noteSet.contains('F1') || noteSet.contains('F2')) return 'Fm';
  if (noteSet.contains('G1') || noteSet.contains('G2')) return 'G';
  if (noteSet.contains('G1') || noteSet.contains('G2')) return 'Gm';
  return '';
}

var noteFrequencies = {
  32.7: 'C1', 34.65: '#C1', 36.71: 'D1', 38.89: '#D1', 41.2: 'E1',
  43.65: 'F1', 46.25: '#F1', 49.0: 'G1', 51.91: '#G1', 55.0: 'A1',
  58.27: '#A1', 61.74: 'B1', 65.41: 'C2', 69.3: '#C2', 73.42: 'D2',
  77.78: '#D2', 82.41: 'E2', 87.31: 'F2', 92.5: '#F2', 98.0: 'G2',
  103.83: '#G2', 110.0: 'A2', 116.54: '#A2', 123.47: 'B2', 130.81: 'C3',
  138.59: '#C3', 146.83: 'D3', 155.56: '#D3', 164.81: 'E3', 174.61: 'F3',
  185.0: '#F3', 196.0: 'G3', 207.65: '#G3', 220.0: 'A3', 233.08: '#A3',
  246.94: 'B3', 261.63: 'C4', 277.18: '#C4', 293.66: 'D4', 311.13: '#D4',
  329.63: 'E4', 349.23: 'F4', 369.99: '#F4', 392.0: 'G4', 415.3: '#G4',
  440.0: 'A4', 466.16: '#A4', 493.88: 'B4', 523.25: 'C5', 554.37: '#C5',
  587.33: 'D5', 622.25: '#D5', 659.25: 'E5', 698.46: 'F5', 739.99: '#F5',
  783.99: 'G5', 830.61: '#G5', 880.0: 'A5', 932.33: '#A5', 987.77: 'B5',
  1046.5: 'C6', 1108.73: '#C6', 1174.66: 'D6', 1244.51: '#D6', 1318.51: 'E6',
  1396.91: 'F6', 1479.98: '#F6', 1567.98: 'G6', 1661.22: '#G6', 1760.0: 'A6',
  1864.66: '#A6', 1975.53: 'B6', 2093.0: 'C7',
};
