import 'package:bloc/bloc.dart';
import 'package:cubit_practice/user_repo.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  fetchUserData() async {
    try {
      emit(UserLoading());

      final int? status = await UserRepository.fetchUserData();
      if (status == 200) {
        emit(UserLoaded());
      } else if (status == 501) {
        emit(UserNoInternet());
      } else if (status == 404) {
        emit(UserException(error: 'User Not Authenticated'));
      }
    } catch (e) {
      UserException(error: 'Something went wrong');
    }
  }
}
