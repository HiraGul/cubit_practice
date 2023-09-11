import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class ChangeStateCubit extends Cubit<bool> {
  ChangeStateCubit() : super(false);

  changeState(bool count) {
    emit(count);
  }
}
