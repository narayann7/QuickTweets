class TwitterUser {
  Data? data;

  TwitterUser({this.data});

  TwitterUser.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? username;
  String? id;
  bool? verified;
  PublicMetrics? publicMetrics;
  String? profileImageUrl;
  String? description;

  Data(
      {this.name,
      this.username,
      this.id,
      this.verified,
      this.publicMetrics,
      this.profileImageUrl,
      this.description});

  factory Data.initial() {
    return Data(
      description: '',
      id: '',
      name: '',
      profileImageUrl: '',
      username: '',
      verified: false,
      publicMetrics: PublicMetrics(
          followersCount: 0, followingCount: 0, listedCount: 0, tweetCount: 0),
    );
  }

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    id = json['id'];
    verified = json['verified'];
    publicMetrics = json['public_metrics'] != null
        ? new PublicMetrics.fromJson(json['public_metrics'])
        : null;
    profileImageUrl = json['profile_image_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['id'] = this.id;
    data['verified'] = this.verified;
    if (this.publicMetrics != null) {
      data['public_metrics'] = this.publicMetrics!.toJson();
    }
    data['profile_image_url'] = this.profileImageUrl;
    data['description'] = this.description;
    return data;
  }
}

class PublicMetrics {
  int? followersCount;
  int? followingCount;
  int? tweetCount;
  int? listedCount;

  PublicMetrics(
      {this.followersCount,
      this.followingCount,
      this.tweetCount,
      this.listedCount});

  PublicMetrics.fromJson(Map<String, dynamic> json) {
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    tweetCount = json['tweet_count'];
    listedCount = json['listed_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['tweet_count'] = this.tweetCount;
    data['listed_count'] = this.listedCount;
    return data;
  }
}
