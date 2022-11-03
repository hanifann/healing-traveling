abstract class WishListRepository{
  Future getWishlist(String id);

  Future postWishlist(String travelId);

  Future deleteWishlist(String id);
}