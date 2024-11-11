import 'package:atc_mobile_app/models/class_model.dart';

///This service handles storage for classes in the wishlist
abstract class WishlistServiceContract {
  void addToWishlist(ClassModel model);
  void removeFromWishlist(ClassModel model);
  Future<List<ClassModel>> getWishlist(ClassModel model);
}