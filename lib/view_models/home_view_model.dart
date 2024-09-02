import 'package:atc_mobile_app/provider/base_model.dart';

class HomeViewModel extends BaseModel {
  var counter = 0;

  incrementCounter() {
    counter++;
    notifyListeners();
  }
}