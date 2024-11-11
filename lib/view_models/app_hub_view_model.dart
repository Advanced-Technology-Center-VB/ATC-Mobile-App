import 'package:atc_mobile_app/contracts/wishlist_service_contract.dart';
import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/provider/base_model.dart';
import 'package:atc_mobile_app/view_models/class_view_model.dart';
import 'package:get_it/get_it.dart';

class AppHubViewModel extends BaseModel {
  var countdownText = "";
  List<ClassModel>? models; 

  bool ready = false; // This value is is affected when fetchData() is called. It becomes false starting execution, and is flipped to true when the function completes.

  void fetchData() async {
    var classViewModel = GetIt.instance.get<ClassViewModel>();

    ready = false;
    notifyListeners();

    countdownText = "256 days";

    models = classViewModel.wishlist;

    ready = true;
    notifyListeners();
  }
}