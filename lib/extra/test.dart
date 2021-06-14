//   print(twitterUser.data!.description);
//   print(twitterUser.data!.id);userMapJson
//   print(twitterUser.data!.name);
//   print(twitterUser.data!.profileImageUrl);
//   print(twitterUser.data!.username);
//   print(twitterUser.data!.publicMetrics!.followersCount);
//   print(twitterUser.data!.publicMetrics!.followingCount);
//   TwitterPosts twitterPosts = TwitterPosts.fromJson(mapJson);

//   int len = twitterPosts.tweets.length;

//   for (int i = 0; i < len; i++) {
//     print(twitterPosts.tweets[i].createdAt);
//     print(twitterPosts.tweets[i].id);
//     print(twitterPosts.tweets[i].text);
//     print(twitterPosts.tweets[i].imageThere);
//     print(twitterPosts.tweets[i].imgUrls);
//     print("\n");
//   }
//  collections
//      .collection("userdata")
//      .doc(user.uid)
//      .collection("tweetData")
//      .add({
//    "createdAt": t![1].createdAt,
//    "id": t![1].id,
//    "text": t![1].text,
//    "imageThere": t![1].imageThere,
//    "imgUrls": [
//      for (int i = 0; i < t![1].imgUrls!.length; i++) t![1].imgUrls![i]
//    ],
//    "username": t![1].username,
//    "name": t![1].name,
//    "uid": t![1].uid,
//    "displayPicture": t![1].displayPicture
//  });
