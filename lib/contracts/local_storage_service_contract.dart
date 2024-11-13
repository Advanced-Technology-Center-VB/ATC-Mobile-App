import 'package:atc_mobile_app/models/program_model.dart';

///This service handles storage for classes in the wishlist
abstract class LocalStorageServiceContract {
  ///Write wishlist data to storage.
  Future<void> writeWishlist(List<ProgramModel> wishlist);
  ///Get wishlist data from storage.
  Future<List<ProgramModel>> getWishlist();
  
  ///Write checklist data to storage.
  Future<void> writeApplicationChecklist(int mask);
  ///Get checklist data from storage.
  Future<int> getApplicationChecklist();
}