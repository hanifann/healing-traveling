import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/core/error/failures.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/login/domain/usecase/post_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid input';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.postAuth
  }) : super(LoginInitial()) {
    on<PostLogin>(_onPostLogin);
  }

  LoginState get initialState => LoginInitial();

  final PostAuth postAuth;

  _onPostLogin(
    PostLogin event,
    Emitter<LoginState> emit
  ) async {
    emit(Loading());
    final failureOrSuccess = await postAuth(Params(email: event.email, password: event.password));
    failureOrSuccess!.fold(
      (l) {
        emit(Error(message: _mapFailureToMessage(l)));
      }, 
      (r) {
        emit(Loaded(user: r));
      }
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'UnexpectedError';
    }
  }
}
