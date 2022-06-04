import 'package:healing_travelling/register/domain/models/register_model.dart';

abstract class RegisterRepository {
  Future postRegister(Register register);
}