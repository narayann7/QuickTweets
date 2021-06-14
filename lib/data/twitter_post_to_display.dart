class Tweets {
  String? createdAt;
  String? id;
  String? text;
  bool? imageThere = false;
  List<String?>? imgUrls;
  String? username;
  String? name;
  String? uid;
  String? displayPicture;

  factory Tweets.initial() {
    return Tweets(
        createdAt: "",
        id: "",
        imageThere: false,
        imgUrls: [],
        text: "",
        username: "",
        uid: "",
        displayPicture: "",
        name: "");
  }

  Tweets({
    required this.createdAt,
    required this.id,
    required this.text,
    required this.imageThere,
    required this.imgUrls,
    required this.username,
    required this.uid,
    required this.displayPicture,
    required this.name,
  });
}
