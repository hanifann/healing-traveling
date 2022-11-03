import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/login/domain/repositories/user_repository.dart';
import 'package:healing_travelling/login/domain/usecase/post_auth.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late PostAuth usecase;
  late MockUserRepository mockUserRepository;

  setUp((){
    mockUserRepository = MockUserRepository();
    usecase = PostAuth(mockUserRepository);
  });

  const tEmail = 'budi@gmail.com';
  const tPassword = 'bangkong';
  const tData = Data(id: 1, name: 'budi', email: tEmail, address: 'bandung', role: 'user');
  const tUser = User(data: tData, token: '12345');

  test('should get user data for the sign in user from the repository', () async {
    when((mockUserRepository.postAuth(any, any)))
      .thenAnswer((_) async => Right(tUser));
    //act
    final result = await usecase(Params(email: tEmail, password: tPassword));
    //assert
    expect(result, Right(tUser));
    verify(mockUserRepository.postAuth(tEmail, tPassword));
  });
}