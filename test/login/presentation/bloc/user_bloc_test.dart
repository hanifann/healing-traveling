import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/login/domain/usecase/post_auth.dart';
import 'package:healing_travelling/login/presentation/bloc/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockPostAuth extends Mock implements PostAuthData {}

void main() {
  late LoginBloc bloc;
  late MockPostAuth mockPostAuth;
  
  setUp((){
    mockPostAuth = MockPostAuth();
    bloc = LoginBloc(postAuth: mockPostAuth);
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(LoginInitial()));
  });

  group('postLogin', () {
    const tEmail = 'budi@gmail.com';
    const tPassword = 'bangkong';
    const tData = Data(id: 1, name: 'budi', email: tEmail, address: 'bandung', role: 'user');
    const tUser = User(data: tData, token: '1234');

      test('should get data from concrete use case', () async {
        //arrange
        when((() => mockPostAuth(Params(email: tEmail, password: tPassword)))).thenAnswer((_) async => Right(tUser));
        //act
        bloc.add(PostLogin(email: tEmail, password: tPassword));
        await untilCalled((() => mockPostAuth(Params(email: tEmail, password: tPassword))));
        //assert
        verify((() => mockPostAuth(Params(email: tEmail, password: tPassword))));
      });
      
      test('should emit [Loading, loaded] when data is gotten successfully', () async* {
        //arrange
        when((() => mockPostAuth(Params(email: tEmail, password: tPassword)))).thenAnswer((_) async => Right(tUser));
        //assert later
        final expected = [
          LoginInitial(),
          Loading(),
          Loaded(user: tUser)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.add(PostLogin(email: tEmail, password: tPassword));
      });

       test('should emit [Loading, Error] when data is gotting data faiils', () async* {
        //arrange
        when((() => mockPostAuth(Params(email: tEmail, password: tPassword)))).thenAnswer((_) async => Right(tUser));
        //assert later
        final expected = [
          LoginInitial(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.add(PostLogin(email: tEmail, password: tPassword));
      });
  });

}