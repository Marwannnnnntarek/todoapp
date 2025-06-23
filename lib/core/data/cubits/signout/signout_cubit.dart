import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signout_state.dart';

class SignoutCubit extends Cubit<SignoutState> {
  SignoutCubit() : super(SignoutInitial());

  //sign out
  Future<void> signout() async {
    emit(SignoutLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(SignoutSuccess());
    } catch (e) {
      emit(SignoutFailure());
    }
  }
}
