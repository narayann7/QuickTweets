part of 'getdata_cubit.dart';

class GetdataState extends Equatable {
  GetdataStatus? getdataStatus;
  TwitterUser? twitterUser;
  TwitterPosts? twitterPosts;

  GetdataState({
    this.getdataStatus,
    this.twitterUser,
    this.twitterPosts,
  });

  factory GetdataState.initial() {
    List<Tweets> t = [Tweets.initial()];
    return GetdataState(
        getdataStatus: GetdataStatus.initial,
        twitterPosts: TwitterPosts(tweets: t),
        twitterUser: TwitterUser());
  }

  @override
  bool? get stringify => true;
  @override
  List<Object?> get props => throw UnimplementedError();
}
