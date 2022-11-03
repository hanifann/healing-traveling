import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';
import 'package:healing_travelling/wishlist/domain/models/wishlist_model.dart';
import 'package:healing_travelling/wishlist/domain/services/wishlist_service.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc(this.service) : super(WishlistInitial()) {
    on<WishlistEventFetch>(_onFetchWishlist);
    on<WishlistEventCreate>(_onCreteFetch);
    on<WishlistEventDelete>(_onDeleteFetch);
  }

   final WishListService service;

  _onFetchWishlist(WishlistEventFetch event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    final result = await service.getWishlist(SharedPreferenceSingleton.getString('id')!);
    result.fold(
      (l) {
        log('wishlist fetch failed: $l', name: 'wishlist');
        emit(WishlistFailed(l));
      }, 
      (r) {
        log('wishlist get success', name: 'wishlist');
        emit(WishlistFetchSuccess(r));
      }
    );
  }

  _onCreteFetch(WishlistEventCreate event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    final result = await service.postWishlist(event.id);
    result.fold(
      (l) {
        log('wishlist post failed: $l', name: 'wishlist');
        emit(WishlistFailed(l));
      }, 
      (r) {
        log('wishlist success: $r', name: 'wishlist');
        emit(WishlistPostSuccess());
      }
    );
  }

  _onDeleteFetch(WishlistEventDelete event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    final result = await service.deleteWishlist(event.id);
    result.fold(
      (l) {
        log('wishlist delete failed: $l', name: 'wishlist');
        emit(WishlistFailed(l));
      }, 
      (r) {
        log('wishlist deletesuccess: $r', name: 'wishlist');
        emit(WishlistDeleteSuccess());
        add(WishlistEventFetch());
      }
    );
  }
}