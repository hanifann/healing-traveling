import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/travelling/domain/models/travelling_model.dart';
import 'package:healing_travelling/travelling/domain/services/travelling_services.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';

part 'travel_event.dart';
part 'travel_state.dart';

class TravelBloc extends Bloc<TravelEvent, TravelState> {
  TravelBloc(this.service) : super(TravelState()) {
    on<TravelEventFetch>(_onRekomendasiFetch);
  }

   final TravellingService service;

  _onRekomendasiFetch(TravelEventFetch event, Emitter<TravelState> emit) async {
    if(state.hasReachedMax) return;
    if(state.status == TravelStatus.initial) {
      final result = await service.getTravelling(event.page, SharedPreferenceSingleton.getString('token'));
      result.fold(
      (l) {
        log('get Travel failed $l', name: 'Travel');
        emit(state.copyWith(status: TravelStatus.failure));
      }, 
      (r) {
        log('get Travel success', name: 'Travel');
        emit(state.copyWith(
          status: TravelStatus.success,
          travel: r,
          hasReachedMax: false
        ));
      }
    );
    } else {

      final result = await service.getTravelling(event.page, SharedPreferenceSingleton.getString('token'));
      result.fold(
        (l) {
          log('get Travel failed $l', name: 'Travel');
          emit(state.copyWith(status: TravelStatus.failure));
        }, 
        (r) {
          log('get Travel success', name: 'Travel');
          if(r.isEmpty){
            emit(state.copyWith(hasReachedMax: true));
          } else {
            emit(state.copyWith(
              status: TravelStatus.success,
              travel: List.of(state.travel)..addAll(r),
              hasReachedMax: false
            ));
          }
        }
      );
    }
  }
}
