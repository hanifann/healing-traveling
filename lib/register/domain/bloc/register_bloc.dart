import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/register/domain/models/register_model.dart';
import 'package:healing_travelling/register/domain/services/register_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.service) : super(RegisterInitial()) {
    on<RegisterEventPost>(_onRegisterEventPost);
  }

  final RegisterService service;

  _onRegisterEventPost(RegisterEventPost event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final result = await service.postRegister(event.register);
    result.fold(
      (l) {
        log('registrasi gagal $l', name: 'register');
        emit(RegisterFailed(l));
      }, 
      (r) {
        log('registrasi success $r', name: 'register');
        emit(RegisterSuccess());
      }
    );
  }
}
