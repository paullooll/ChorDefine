class ProgressModel {
  String name;
  String thumbnail;
  String description;

  ProgressModel({
    required this.name,
    required this.thumbnail,
    required this.description,
  });
}

List<ProgressModel> progre = [
  ProgressModel(
    name: "Major Chords Progress",
    thumbnail: "assets/pics/chord1.png",
    description: "Definition of Every Chord",
  ),
  ProgressModel(
    name: "Minor Chords Progress",
    thumbnail: "assets/pics/library.png",
    description: "Learn the basic positioning of chords in the fretboard",
  ),
];
