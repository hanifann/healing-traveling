part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
  
  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistFailed extends WishlistState {
  final String message;

  const WishlistFailed(this.message);
}

class WishlistFetchSuccess extends WishlistState {
  final Wishlist wishlist;

  const WishlistFetchSuccess(this.wishlist);
}

class WishlistPostSuccess extends WishlistState {}

class WishlistDeleteSuccess extends WishlistState{}
 