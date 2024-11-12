import 'package:atc_mobile_app/models/class_model.dart';

///This service handles storage for classes in the wishlist
abstract class LocalStorageServiceContract {
  Future<void> writeWishlist(List<ClassModel> wishlist);
  Future<List<ClassModel>> getWishlist();
  
  Future<void> writeApplicationChecklist(int mask);
  Future<int> getApplicationChecklist();
}