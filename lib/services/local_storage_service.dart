import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/contracts/local_storage_service_contract.dart';
import 'package:atc_mobile_app/models/program_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

///This class stores and loads data from the Preferences Storage on the device.
class LocalStorageService extends LocalStorageServiceContract {

  @override
  Future<List<ProgramModel>> getWishlist() async {
    var api = GetIt.instance.get<ApiServiceContract>();
    var prefs = await SharedPreferences.getInstance();

    var value = prefs.getString("wishlist");

    if (value == null || value.isEmpty) { //If there's no data already presented, hand over an empty list.
      return List<ProgramModel>.empty();
    } 

    var split = value.split(","); //Data is formatted as IDs divided by a comma.
    var wishlist = List<ProgramModel>.empty(growable: true);

    for(var id in split) {
      wishlist.add(await api.fetchClass(int.parse(id)));
    }

    return wishlist;
  }

  @override
  Future<void> writeWishlist(List<ProgramModel> wishlist) async {
    var prefs = await SharedPreferences.getInstance();
    var value = _buildValue(wishlist);

    await prefs.setString("wishlist", value);
  }

  ///This method turns a list of programs into a string of IDs divied by commas.
  String _buildValue(List<ProgramModel> models) {
    var result = "";

    for (var i = 0; i < models.length; i++) {
      

      result += models[i].id.toString();

      if (i < models.length - 1) result += ",";
    }

    return result;
  }
  
  @override
  Future<int> getApplicationChecklist() async {
    var prefs = await SharedPreferences.getInstance();
    
    return prefs.getInt("appChecklist") ?? 0;
  }
  
  @override
  Future<void> writeApplicationChecklist(int mask) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt("appChecklist", mask);
  }
}