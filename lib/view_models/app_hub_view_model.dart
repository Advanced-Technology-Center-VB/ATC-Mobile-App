import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/contracts/local_storage_service_contract.dart';
import 'package:atc_mobile_app/models/program_model.dart';
import 'package:atc_mobile_app/models/information_model.dart';
import 'package:atc_mobile_app/provider/base_model.dart';
import 'package:atc_mobile_app/view_models/class_view_model.dart';
import 'package:get_it/get_it.dart';

class AppHubViewModel extends BaseModel {
  var countdownText = "";
  List<ProgramModel>? models; 
  InformationModel? info;

  int checklistMask = 0;

  var localStorage = GetIt.instance.get<LocalStorageServiceContract>();

  bool ready = false; // This value is is affected when fetchData() is called. It becomes false starting execution, and is flipped to true when the function completes.

  void fetchData() async {
    var classViewModel = GetIt.instance.get<ProgramViewModel>();
    var api = GetIt.instance.get<ApiServiceContract>();

    ready = false;
    notifyListeners();

    checklistMask = await localStorage.getApplicationChecklist();

    info = await api.fetchAtcInformation();

    int countdown = info!.applicationDeadline.difference(DateTime.now()).inDays;

    countdownText = countdown >= 0 ? "$countdown days" : "Early applications closed";

    models = classViewModel.wishlist;

    ready = true;
    notifyListeners();
  }

  void updateChecklist() async {
    await localStorage.writeApplicationChecklist(checklistMask);
  }
}