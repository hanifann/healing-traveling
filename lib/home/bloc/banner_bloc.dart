import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/home/domain/models/banner_model.dart';
import 'package:healing_travelling/home/domain/services/banner_service.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc(this.service) : super(BannerInitial()) {
    on<BannerEventFetch>(_onBannerFetch);
  }

  final BannerService service;

  _onBannerFetch(BannerEventFetch event, Emitter<BannerState> emit) async {
    emit(BannerLoading());
    final result = await service.getBanner(SharedPreferenceSingleton.getString('token'));
    result.fold(
      (l) {
        log('get banner failed $l', name: 'Banner');
        emit(BannerFailed(l));
      }, 
      (r) {
        log('get banner success', name: 'Banner');
        emit(BannerSuccess(r));
      }
    );
  }
}
