import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEventCheckAuth>(_onCheckAuth);
  }

  _onCheckAuth(
    AuthEventCheckAuth event,
    Emitter<AuthState> emit,
  ) async {
    var _token = SharedPreferenceSingleton.checkKey('token');

    if(_token == true){
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
