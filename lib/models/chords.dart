class ChordModel {
  String name;
  String thumbnail;
  String description;

  ChordModel({
    required this.name,
    required this.thumbnail,
    required this.description,
  });
}

List<ChordModel> chords = [
  ChordModel(
    name: "Major Chords",
    thumbnail: "assets/pics/Majorr.png",
    description:
        "Bright and uplifting, major chords are built with a root, major third, and perfect fifth, creating a joyful sound.",
  ),
  ChordModel(
    name: "Minor Chords",
    thumbnail: "assets/pics/Minorr.png",
    description:
        "Minor chords use a root, minor third, and perfect fifth for a darker, more emotional tone, often evoking sadness or mystery",
  ),
];
