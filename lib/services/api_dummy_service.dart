import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/models/category_model.dart';
import 'package:atc_mobile_app/models/program_model.dart';
import 'package:atc_mobile_app/models/event_model.dart';
import 'package:atc_mobile_app/models/information_model.dart';
import 'package:atc_mobile_app/models/testimony_model.dart';

///This class is soley for offline testing of the app.
class ApiDummyService extends ApiServiceContract {
  List<ProgramModel> classes = [
    ProgramModel(id: 1, name: "Class 1", description: "Description", about: "About", prerequisites: "Prerequisites", category: "Category 1"),
    ProgramModel(id: 2, name: "Class 2", description: "Description", about: "About", prerequisites: "Prerequisites", category: "Category 2"),
    ProgramModel(id: 3, name: "Class 3", description: "Description", about: "About", prerequisites: "Prerequisites", category: "Category 3")
  ];

  @override
  Future<ProgramModel> fetchClass(int id) async {
    return classes.where((model) => model.id == id).first;
  }

  @override
  Future<List<ProgramModel>> fetchClasses(int mask) async {
    List<CategoryModel> categories = await fetchCategories();
    List<ProgramModel> result = List.empty(growable: true);

    if (mask == 0) {
      return classes;
    }

    for (int i = 0; i < categories.length; i++) {
      if (mask >> i & 1 == 1) {
        result.addAll(classes.where((model) => model.category == categories[i].name));
      }
    }

    return result;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    return [
      CategoryModel(1, "Category 1"),
      CategoryModel(2, "Category 2"),
      CategoryModel(3, "Category 3"),
    ];
  }
  
  @override
  Future<List<TestimonyModel>> fetchTestimonies(int classId) async {
    return const [
      TestimonyModel("John Doe", 2, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nisi turpis, ullamcorper eget metus in, dapibus malesuada enim. Aliquam faucibus."),
      TestimonyModel("Jane Doe", 2, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nisi turpis, ullamcorper eget metus in, dapibus malesuada enim. Aliquam faucibus."),
    ];
  }
  
  @override
  Future<List<String>> fetchImages(int classId) {
    throw UnimplementedError();
  }

  @override
  Future<List<EventModel>> fetchEvents() async {
    return [
      EventModel(
        "Test", DateTime.now().add(const Duration(minutes: 11)), "location", true, false, false, null, null, null, null)
    ];
  }

  @override
  Future<InformationModel> fetchAtcInformation() {
    // TODO: implement fetchAtcInformation
    throw UnimplementedError();
  }
}