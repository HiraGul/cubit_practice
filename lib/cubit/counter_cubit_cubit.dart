import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class CounterCubitCubit extends Cubit<int> {
  CounterCubitCubit({required int initialState}) : super(0);

  increment(int count) {
    emit(count);
  }

  decrement(int count) {
    emit(count);
  }
}
