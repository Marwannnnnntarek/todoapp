part of 'signin_cubit.dart';

sealed class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

final class SigninInitial extends SigninState {}

final class SigninSuccess extends SigninState {}

final class SigninFailure extends SigninState {}

final class SigninLoading extends SigninState {}
