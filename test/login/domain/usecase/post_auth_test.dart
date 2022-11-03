import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healing_travelling/core/usecases/usecase.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/login/domain/repositories/user_repository.dart';
import 'package:healing_travelling/login/domain/usecase/fetch_user_data.dart';
import 'package:healing_travelling/login/domain/usecase/post_auth.dart';
import 'package:mocktail/mocktail.dart';


class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late PostAuthData usecase;
  late FetchUserData usecase2;
  late MockUserRepository mockUserRepository;

  setUp((){
    mockUserRepository = MockUserRepository();
    usecase = PostAuthData(mockUserRepository);
    usecase2 = FetchUserData(mockUserRepository);
  });

  const tEmail = 'budi@gmail.com';
  const tPassword = 'bangkong';
  const tData = Data(id: 1, name: 'budi', email: tEmail, address: 'bandung', role: 'user');
  const tUser = User(data: tData, token: '12345');

  test('should get user data for the sign in user from the repository', () async {
    when(()=> mockUserRepository.postAuth(tEmail, tPassword))
      .thenAnswer((_) async => Right(tUser));
    //act
    final result = await usecase(Params(email: tEmail, password: tPassword));
    //assert
    expect(result, Right(tUser));
    verify(()=> mockUserRepository.postAuth(tEmail, tPassword));
  });

  test('should get user data from the local storage', () async {
    //arange
    when(() => mockUserRepository.fetchUserData())
      .thenAnswer((_) async => Right(tUser));
    //act
    final result = await usecase2(NoParams());
    //assert
    expect(result, Right(tUser));
    verify((() => mockUserRepository.fetchUserData()));
  });
}