import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/provider/base_model.dart';

class AppHubViewModel extends BaseModel {
  var countdownText = "";
  List<ClassModel>? models; 

  bool ready = false; // This value is is affected when fetchData() is called. It becomes false starting execution, and is flipped to true when the function completes.

  void fetchData() async {
    ready = false;
    notifyListeners();

    countdownText = "256 days";

    models = [
      ClassModel(id: 0, name: "Program 1", category: "Category"),
      ClassModel(id: 0, name: "Program 2", category: "Category"),
      ClassModel(id: 0, name: "Program 3", category: "Category"),
    ];

    ready = true;
    notifyListeners();
  }
}