import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quicktweets/data/fetch_from_api.dart';
import 'package:quicktweets/data/twitter_posts.dart';
import 'package:quicktweets/data/twitter_user.dart';
import 'package:quicktweets/logic/utility/all_constants.dart';

part 'getdata_state.dart';

class GetdataCubit extends Cubit<GetdataState> {
  GetdataCubit() : super(GetdataState.initial());

  void initial() {
    emit(GetdataState.initial());
  }

  void enterUsername(String username) async {
    bool error = true;
    emit(GetdataState(getdataStatus: GetdataStatus.loading));

    FetchFromApi _fetchFromApi = FetchFromApi();
    try {
      error = await _fetchFromApi.getUserData(username);
      if (error == false) {
        emit(GetdataState(
            getdataStatus: GetdataStatus.loading,
            twitterUser: _fetchFromApi.twitterUser));

        error = await _fetchFromApi.getUserTweets(
            next: "", nextRequired: false, uid: state.twitterUser!.data!.id);
        if (error == false) {
          emit(GetdataState(
              getdataStatus: GetdataStatus.loading,
              twitterUser: _fetchFromApi.twitterUser,
              twitterPosts: _fetchFromApi.twitterPosts));
        }

        if (_fetchFromApi.status == true) {
          print("null is hell");
          emit(GetdataState(
              getdataStatus: GetdataStatus.success,
              twitterUser: _fetchFromApi.twitterUser,
              twitterPosts: _fetchFromApi.twitterPosts));
        }
      } else {
        emit(GetdataState(getdataStatus: GetdataStatus.error));
      }
    } catch (e) {
      print(e);
      emit(GetdataState(getdataStatus: GetdataStatus.error));
    }
  }
}
