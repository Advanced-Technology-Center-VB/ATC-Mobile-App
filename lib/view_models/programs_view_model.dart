import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/models/category_model.dart';
import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/provider/base_model.dart';
import 'package:get_it/get_it.dart';

class ProgramsViewModel extends BaseModel {
  late String className;

  List<CategoryModel> categories = List.empty();
  List<ClassModel> classes = List.empty();

  var api = GetIt.instance.get<ApiServiceContract>();

  bool ready = false;
  bool syncingClasses = false;
  bool connectionError = false;

  ProgramsViewModel() {
    getData().whenComplete(() => ready = true);
  }

  Future<void> getData() async {
    connectionError = false;

    categories = await api.fetchCategories().catchError((err) {
      connectionError = true;

      return List<CategoryModel>.empty();
    });

    syncClasses(1);
  }

  Future<void> syncClasses(int mask) async {
    connectionError = false;
    syncingClasses = true;

    notifyListeners();

    classes = await api.fetchClasses(mask).whenComplete(() {
      syncingClasses = false;

      notifyListeners();
    }).catchError((err) {
      connectionError = true;

      return List<ClassModel>.empty();
    });

    notifyListeners();
  }

  
}