import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healing_travelling/auth/bloc/auth_bloc.dart';
import 'package:healing_travelling/core/error/failures.dart';
import 'package:healing_travelling/core/usecases/usecase.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/login/domain/usecase/fetch_user_data.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchUserData extends Mock implements FetchUserData{}

void main() {
  late MockFetchUserData mockFetchUserData;
  late AuthBloc authBloc;

  setUp((){
    mockFetchUserData = MockFetchUserData();
    authBloc = AuthBloc(mockFetchUserData);
  });

  const tEmail = 'budi@gmail.com';
  const tData = Data(id: 1, name: 'budi', email: tEmail, address: 'bandung', role: 'user');
  const tUser = User(data: tData, token: '1234');

  test('initialState should be authInitial', () async {
    //assert
    expect(authBloc.initislState, equals(AuthInitial()));
  });

  group('fetch user data from local', () {
    test('should return user data from local data source', () async {
      //arange
      when(() => mockFetchUserData(NoParams()))
        .thenAnswer((_) async => Right(tUser));
      //act
      authBloc.add(AuthEventCheckAuth());
      await untilCalled(() => mockFetchUserData(NoParams()));
      //verify
      verify(() => mockFetchUserData(NoParams()));
    });

    test('should emit [AuthInitial, AuthAuthenticated] when data is available', () async* {
      //arrange
      when(() => mockFetchUserData(NoParams()))
        .thenAnswer((_) async => Right(tUser));
      //assert later
      final expected = [
        AuthInitial(),
        AuthAuthenticated()
      ];
      expectLater(authBloc.state, emitsInOrder(expected));
      //act
      authBloc.add(AuthEventCheckAuth());
    });

    test('should emit [AuthInitial, AuthUnauthenticated] when data is not available', () async* {
      //arrange
      when(() => mockFetchUserData(NoParams()))
        .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        AuthInitial(),
        AuthUnauthenticated()
      ];
      expectLater(authBloc.state, emitsInOrder(expected));
      //act
      authBloc.add(AuthEventCheckAuth());
    });
  });
}