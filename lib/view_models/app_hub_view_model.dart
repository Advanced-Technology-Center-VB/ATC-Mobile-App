import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/contracts/local_storage_service_contract.dart';
import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/models/information_model.dart';
import 'package:atc_mobile_app/provider/base_model.dart';
import 'package:atc_mobile_app/view_models/class_view_model.dart';
import 'package:get_it/get_it.dart';

class AppHubViewModel extends BaseModel {
  var countdownText = "";
  List<ClassModel>? models; 
  InformationModel? info;

  int checklistMask = 0;

  bool ready = false; // This value is is affected when fetchData() is called. It becomes false starting execution, and is flipped to true when the function completes.

  void fetchData() async {
    var classViewModel = GetIt.instance.get<ClassViewModel>();
    var api = GetIt.instance.get<ApiServiceContract>();

    ready = false;
    notifyListeners();

    info = await api.fetchAtcInformation();

    countdownText = "${info!.applicationDeadline.difference(DateTime.now()).inDays} days";

    models = classViewModel.wishlist;

    ready = true;
    notifyListeners();
  }
}