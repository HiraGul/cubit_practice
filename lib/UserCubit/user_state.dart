part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {}

class UserException extends UserState {
  final String error;
  UserException({required this.error});
}

class UserNoInternet extends UserState {}
