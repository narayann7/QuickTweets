import 'package:quicktweets/data/twitter_post_to_display.dart';

class TwitterPosts {
  List<Data>? data = [
    Data(
      createdAt: "",
      id: "",
      text: "",
    )
  ];
  List<Tweets> tweets = [Tweets.initial()];
  Meta? meta;
  Includes? includes;

  TwitterPosts({
    this.data,
    required this.tweets,
    this.meta,
    this.includes,
  });

  TwitterPosts.fromJson(Map<String, dynamic> json) {
    //constructor
    includes =
        json['includes'] != null ? Includes.fromJson(json['includes']) : null;
    meta = (json['meta'] != null ? Meta.fromJson(json['meta']) : null);

    if (json['data'] != null) {
      int noOfMedia = 1;
      json['data'].forEach((v) {
        Data d = Data.fromJson(v);

        Tweets tweet = Tweets.initial();
        tweet.id = d.id;
        tweet.createdAt = d.createdAt;
        tweet.text = d.text;
        if (d.attachmentsThere == true) {
          int? noOfImagesUrl;
          int x;

          noOfImagesUrl = d.attachments!.lengthOfMediaKeys;
          x = noOfImagesUrl!.toInt();
          while (x != -1) {
            x--;
            Media media = includes!.media![noOfMedia];
            noOfMedia++;
            if (media.type == "photo") {
              tweet.imageThere = true;
              tweet.imgUrls!.add(media.url);
            } else {
              tweet.imageThere = false;
              tweet.imgUrls = [""];
            }
          }
        } else {
          tweet.imageThere = false;
          tweet.imgUrls = [""];
        }
        tweets.add(tweet);
      });
    }
  }
}

class Data {
  String? createdAt;
  String? id;
  String? text;
  bool? attachmentsThere = false;
  Attachments? attachments;
  Data(
      {this.createdAt,
      this.id,
      this.text,
      this.attachments,
      this.attachmentsThere});
  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    text = json['text'];

    if (json['attachments'] != null) {
      attachmentsThere = true;

      attachments = Attachments.fromJson(json['attachments']);
    }
  }
}

class Attachments {
  int? lengthOfMediaKeys = 1;

  Attachments({this.lengthOfMediaKeys});

  Attachments.fromJson(Map<String, dynamic> json) {
    int i = -1;
    json['media_keys'].forEach((v) {
      i++;
    });
    lengthOfMediaKeys = i;
  }
}

class Includes {
  List<Media>? media = [Media(mediaKey: "", type: "", url: "")];

  Includes({required this.media});

  Includes.fromJson(Map<String, dynamic> json) {
    if (json['media'] != null) {
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }
}

class Media {
  String? mediaKey = "";
  String? type = "";
  String? url = "";

  Media({this.mediaKey, this.type, this.url});

  Media.fromJson(Map<String, dynamic> json) {
    mediaKey = json['media_key'];
    type = json['type'];
    url = json['url'];
  }
}

class Meta {
  String? oldestId;
  String? newestId;
  int? resultCount;

  Meta({
    this.oldestId,
    this.newestId,
    required this.resultCount,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    oldestId = json['oldest_id'];
    newestId = json['newest_id'];
    resultCount = json['result_count'];
  }
}
