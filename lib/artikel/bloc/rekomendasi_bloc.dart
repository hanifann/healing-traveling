import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/artikel/domain/models/rekomendasi_model.dart';
import 'package:healing_travelling/artikel/domain/services/rekomendasi_service.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';

part 'rekomendasi_event.dart';
part 'rekomendasi_state.dart';

class RekomendasiBloc extends Bloc<RekomendasiEvent, RekomendasiState> {
  RekomendasiBloc(this.service) : super(RekomendasiState()) {
    on<RekomendasiEventFetch>(_onRekomendasiFetch);
  }

  final RekomendasiService service;

  _onRekomendasiFetch(RekomendasiEventFetch event, Emitter<RekomendasiState> emit) async {
    if(state.hasReachedMax) return;
    if(state.status == RekomendasiStatus.initial) {
      final result = await service.getRekomendasi(event.page, SharedPreferenceSingleton.getString('token'));
      result.fold(
      (l) {
        log('get rekomendasi failed $l', name: 'Rekomendasi');
        emit(state.copyWith(status: RekomendasiStatus.failure));
      }, 
      (r) {
        log('get rekomendasi success', name: 'Rekomendasi');
        emit(state.copyWith(
          status: RekomendasiStatus.success,
          rekomendasi: r,
          hasReachedMax: false
        ));
      }
    );
    } else {

      final result = await service.getRekomendasi(event.page, SharedPreferenceSingleton.getString('token'));
      result.fold(
        (l) {
          log('get rekomendasi failed $l', name: 'Rekomendasi');
          emit(state.copyWith(status: RekomendasiStatus.failure));
        }, 
        (r) {
          log('get rekomendasi success', name: 'Rekomendasi');
          if(r.isEmpty){
            emit(state.copyWith(hasReachedMax: true));
          } else {
            emit(state.copyWith(
              status: RekomendasiStatus.success,
              rekomendasi: List.of(state.rekomendasi)..addAll(r),
              hasReachedMax: false
            ));
          }
        }
      );
    }
  }

}
