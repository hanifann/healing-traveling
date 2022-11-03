part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class WishlistEventFetch extends WishlistEvent {}

class WishlistEventCreate extends WishlistEvent {
  final String id;

  const WishlistEventCreate(this.id);

}

class WishlistEventDelete extends WishlistEvent {
  final String id;

  const WishlistEventDelete(this.id);
}

