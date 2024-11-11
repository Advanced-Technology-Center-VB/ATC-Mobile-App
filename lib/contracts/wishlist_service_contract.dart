import 'package:atc_mobile_app/models/class_model.dart';

///This service handles storage for classes in the wishlist
abstract class WishlistServiceContract {
  Future<void> writeWishlist(List<ClassModel> wishlist);
  Future<List<ClassModel>> getWishlist();
}