import 'dart:typed_data';
import 'package:chordefine/constants/color.dart';
import 'package:chordefine/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter/services.dart';

class TunerController extends GetxController {
  final _audioRecorder = FlutterAudioCapture();
  late final PitchDetector pitchDetectorDart;

  final maxRange = 25;
  final maxToTune = 3;

  var hasAudioPermission = false.obs;
  var currentPitch = 0.0.obs;
  var pitchToCompare = 0.0.obs;
  var isInRange = false.obs;
  var isTuned = false.obs;
  var selectedTune = "".obs;

  RxDouble markerPositionX = 0.0.obs;

  var chordsFrecuency = [
    329.63, // E4
    246.94, // B3
    196.00, // G3
    146.83, // D3
    110.00, // A2
    82.41, // E2
  ];

  @override
  void onInit() {
    super.onInit();
    WakelockPlus.enable();
    _initPitchDetector();
    recordPerm();
  }

  Future<void> _initPitchDetector() async {
    await _audioRecorder.init();
    pitchDetectorDart = PitchDetector(audioSampleRate: 44100, bufferSize: 3000);
  }

  void selectChord(int chordIndex, String tuneChord) {
    pitchToCompare.value = chordsFrecuency[chordIndex];
    selectedTune.value = tuneChord;
  }

  void compareWithPitch() {
    if (currentPitch.value >= (pitchToCompare.value - maxRange) &&
        currentPitch.value <= (pitchToCompare.value + maxRange)) {
      isInRange.value = true;
      markerPositionX.value =
          (((currentPitch.value - pitchToCompare.value) * 3) + 100).toDouble();
    } else {
      isInRange.value = false;
      markerPositionX.value =
          currentPitch.value > (pitchToCompare.value + maxRange)
              ? 180.0 - 24
              : 24;
    }

    isTuned.value = currentPitch.value > (pitchToCompare.value - maxToTune) &&
        currentPitch.value < (pitchToCompare.value + maxToTune);
  }

  Future<void> recordPerm() async {
    if (await Permission.microphone.request().isGranted) {
      hasAudioPermission.value = true;
      startCapture();
    }
  }

  Future<void> startCapture() async {
    await _audioRecorder.start(listener, error,
        sampleRate: 44100, bufferSize: 3000);
  }

  void listener(Float32List obj) {
    final List<double> audioSample = obj.toList();
    pitchDetectorDart.getPitchFromFloatBuffer(audioSample).then((result) {
      if (result.pitched) {
        currentPitch.value = result.pitch;
        compareWithPitch();
      }
    });
  }

  void error(Object e) {}
}

class VerticalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2;

    final double centerX = size.width / 2;
    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TunerMarker extends StatelessWidget {
  const TunerMarker({super.key});

  @override
  Widget build(BuildContext context) {
    var tunerController = Get.find<TunerController>();

    return SizedBox(
      width: 200,
      height: 130,
      child: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 300),
              left: tunerController.markerPositionX.value - (48 / 2),
              top: 50.0,
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    color: tunerController.isTuned.value
                        ? kSuccess
                        : kTextPrimary,
                    size: 48.0,
                    semanticLabel: 'Guitar Tuner',
                  ),
                  Text(
                    tunerController.currentPitch.value.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: Responsive.captionText(context),
                      color: kTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GuitarButton extends StatelessWidget {
  final Color chordColor;
  final int chordIndex;
  final String chordText;

  const GuitarButton({
    super.key,
    required this.chordColor,
    required this.chordIndex,
    required this.chordText,
  });

  @override
  Widget build(BuildContext context) {
    var tunerController = Get.find<TunerController>();

    return Obx(() => OutlinedButton(
          style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
            maximumSize: const WidgetStatePropertyAll(Size(60, 60)),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            side: WidgetStateProperty.all(
              BorderSide(
                color: tunerController.selectedTune.value == chordText
                    ? primaryColor
                    : chordColor,
                width: 2,
              ),
            ),
            backgroundColor: tunerController.selectedTune.value == chordText
                ? WidgetStateProperty.all<Color>(primaryColor)
                : WidgetStateProperty.all<Color>(kCardWhite),
          ),
          onPressed: () => tunerController.selectChord(chordIndex, chordText),
          child: Text(
            chordText,
            style: TextStyle(
              fontSize: Responsive.bodyText(context),
              fontWeight: FontWeight.w700,
              color: tunerController.selectedTune.value == chordText
                  ? Colors.white
                  : kTextPrimary,
            ),
          ),
        ));
  }
}

class TunerScreen extends StatelessWidget {
  const TunerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tunerController = Get.put(TunerController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kBgLight,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _TunerHeader(),
              Expanded(
                child: Obx(
                  () => tunerController.hasAudioPermission.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.horizontalPadding(context),
                            vertical: Responsive.height(context) * 0.015,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kCardWhite,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: CustomPaint(
                                          painter: VerticalLinePainter(),
                                        ),
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              tunerController
                                                          .selectedTune
                                                          .value ==
                                                      ""
                                                  ? "Select string..."
                                                  : tunerController
                                                      .selectedTune.value,
                                              style: TextStyle(
                                                fontSize:
                                                    Responsive.titleLarge(
                                                        context),
                                                fontWeight: FontWeight.w800,
                                                color: kTextPrimary,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Responsive.height(
                                                      context) *
                                                  0.01,
                                            ),
                                            Text(
                                              tunerController
                                                  .pitchToCompare.value
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    Responsive.bodyText(
                                                        context),
                                                color: kTextSecondary,
                                              ),
                                            ),
                                            tunerController
                                                        .selectedTune
                                                        .value ==
                                                    ""
                                                ? Container()
                                                : const TunerMarker(),
                                            tunerController.isTuned.value
                                                ? Container(
                                                    padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 16,
                                                      vertical: 6,
                                                    ),
                                                    decoration:
                                                        BoxDecoration(
                                                      color: kSuccess
                                                          .withValues(
                                                              alpha: 0.1),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(20),
                                                    ),
                                                    child: const Text(
                                                      "In Tune!",
                                                      style: TextStyle(
                                                        color: kSuccess,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mic_off,
                                size: 64,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No audio permission provided",
                                style: TextStyle(
                                  fontSize: Responsive.titleSmall(context),
                                  color: kTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kCardWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.horizontalPadding(context),
                  vertical: Responsive.height(context) * 0.025,
                ),
                child: Column(
                  children: [
                    Text(
                      'Select a string to tune',
                      style: TextStyle(
                        fontSize: Responsive.bodyText(context),
                        color: kTextSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                        height: Responsive.height(context) * 0.015),
                    Row(
                      children: [
                        Flexible(
                          flex: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              GuitarButton(
                                  chordColor: Colors.black,
                                  chordIndex: 3,
                                  chordText: "D3"),
                              SizedBox(height: 8),
                              GuitarButton(
                                  chordColor: Colors.black,
                                  chordIndex: 4,
                                  chordText: "A2"),
                              SizedBox(height: 8),
                              GuitarButton(
                                  chordColor: Colors.black,
                                  chordIndex: 5,
                                  chordText: "E2"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              'assets/images/guitar.png',
                              height: Responsive.height(context) * 0.18,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              GuitarButton(
                                  chordColor: Colors.black,
                                  chordIndex: 2,
                                  chordText: "G3"),
                              SizedBox(height: 8),
                              GuitarButton(
                                  chordColor: Colors.black,
                                  chordIndex: 1,
                                  chordText: "B3"),
                              SizedBox(height: 8),
                              GuitarButton(
                                  chordColor: Colors.black,
                                  chordIndex: 0,
                                  chordText: "E4"),
                            ],
                          ),
                        ),
                      ],
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

class _TunerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Responsive.height(context) * 0.04,
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
            'Tuner',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Responsive.titleLarge(context),
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context) * 0.006),
          Text(
            'Tune your guitar to perfection',
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
