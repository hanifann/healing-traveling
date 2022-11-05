import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/core/usecases/usecase.dart';
import 'package:healing_travelling/login/domain/usecase/fetch_user_data.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.fetch) : super(AuthInitial()) {
    on<AuthEventCheckAuth>(_onCheckAuth);
  }

  final FetchUserData fetch;
  AuthState get initislState => AuthInitial();

  _onCheckAuth(
    AuthEventCheckAuth event,
    Emitter<AuthState> emit,
  ) async {
    var localData = await fetch(NoParams());

    localData!.fold(
      (l) => emit(AuthUnauthenticated()), 
      (r) => emit(AuthAuthenticated())
    );
  }
}
