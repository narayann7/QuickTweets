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
    return GetdataState(getdataStatus: GetdataStatus.initial);
  }

  @override
  bool? get stringify => true;
  @override
  List<Object?> get props => [
        this.getdataStatus,
        this.twitterUser,
        this.twitterPosts,
      ];
}
