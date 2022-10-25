import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(loading: false));

  void loadingStart() => emit(AuthState(loading: true));
  void loadingFinished() => emit(AuthState(loading: false));
}
