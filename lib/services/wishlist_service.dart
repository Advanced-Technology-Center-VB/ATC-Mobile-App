import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/contracts/wishlist_service_contract.dart';
import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/services/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistService extends WishlistServiceContract {

  @override
  Future<List<ClassModel>> getWishlist() async {
    var api = GetIt.instance.get<ApiServiceContract>();
    var prefs = await SharedPreferences.getInstance();

    var value = prefs.getString("wishlist");

    if (value == null || value.isEmpty) {
      return List<ClassModel>.empty();
    } 

    var split = value.split(",");
    var wishlist = List<ClassModel>.empty(growable: true);

    for(var id in split) {
      wishlist.add(await api.fetchClass(int.parse(id)));
    }

    return wishlist;
  }

  @override
  Future<void> writeWishlist(List<ClassModel> wishlist) async {
    var prefs = await SharedPreferences.getInstance();
    var value = _buildValue(wishlist);

    await prefs.setString("wishlist", value);
  }

  
  String _buildValue(List<ClassModel> models) {
    var result = "";

    for (var i = 0; i < models.length; i++) {
      

      result += models[i].id.toString();

      if (i < models.length - 1) result += ",";
    }

    return result;
  }
}