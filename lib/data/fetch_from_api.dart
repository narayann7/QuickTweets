import 'dart:convert';
import 'package:quicktweets/data/twitter_posts.dart';
import 'package:quicktweets/data/twitter_user.dart';
import 'package:http/http.dart' as http;

final String bearer_token =
    "Bearer AAAAAAAAAAAAAAAAAAAAADgwQgEAAAAAjCP3dQIuTcdw2bKoCagfjvMik00%3DAFLOeWAX7JBstGrFUfnvcy0oqNK8ke1kz6ZtWKhSZXtlLGT3Sg";

class FetchFromApi {
  TwitterUser? twitterUser;
  TwitterPosts? twitterPosts;
  bool status = false;
  Future<bool> getUserData(String username) async {
    bool isError = true;
    try {
      var userUrl =
          "https://api.twitter.com/2/users/by/username/${username}?user.fields=description,id,name,profile_image_url,public_metrics,username,verified";

      var rawUserJson = await http.get(Uri.parse(userUrl), headers: {
        "Authorization":
            "Bearer AAAAAAAAAAAAAAAAAAAAADgwQgEAAAAAjCP3dQIuTcdw2bKoCagfjvMik00%3DAFLOeWAX7JBstGrFUfnvcy0oqNK8ke1kz6ZtWKhSZXtlLGT3Sg"
      });

      if (rawUserJson.statusCode != 200) {
        return isError;
      }

      Map<String, dynamic> userMapJson = jsonDecode(rawUserJson.body);

      if (userMapJson["errors"] != null) {
        return isError;
      }

      twitterUser = TwitterUser.fromJson(userMapJson);
      print(twitterUser!.data!.name);
      print(twitterUser!.data!.username);
      print(twitterUser!.data!.id);
      isError = false;
      return isError;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> getUserTweets({
    String? uid,
    bool? nextRequired,
    String? next,
  }) async {
    bool isError = true;
    try {
      var tweetsUrl;
      if (nextRequired == false) {
        tweetsUrl =
            "https://api.twitter.com/2/users/${uid}/tweets?max_results=100&expansions=attachments.media_keys&tweet.fields=created_at&media.fields=type,url&exclude=retweets,replies";
      } else {
        next = "&until_id=$next";
        tweetsUrl =
            "https://api.twitter.com/2/users/${uid}/tweets?max_results=100${next}&expansions=attachments.media_keys&tweet.fields=created_at&media.fields=type,url&exclude=retweets,replies";
      }

      var rawTweetsJson = await http.get(Uri.parse(tweetsUrl), headers: {
        "Authorization":
            "Bearer AAAAAAAAAAAAAAAAAAAAADgwQgEAAAAAjCP3dQIuTcdw2bKoCagfjvMik00%3DAFLOeWAX7JBstGrFUfnvcy0oqNK8ke1kz6ZtWKhSZXtlLGT3Sg"
      });

      if (rawTweetsJson.statusCode != 200) {
        return isError;
      }

      Map<String, dynamic> TweetsMapJson = jsonDecode(rawTweetsJson.body);
      // print(TweetsMapJson);
      if (TweetsMapJson["errors"] != null) {
        return isError;
      }
      twitterPosts = TwitterPosts.fromJson(TweetsMapJson);
      isError = false;
      status = true;
      return isError;
    } catch (e) {
      print(e);
      return isError;
    }
  }
}
