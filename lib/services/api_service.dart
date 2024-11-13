import 'dart:convert';

import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/models/category_model.dart';
import 'package:atc_mobile_app/models/program_model.dart';
import 'package:atc_mobile_app/models/event_model.dart';
import 'package:atc_mobile_app/models/information_model.dart';
import 'package:atc_mobile_app/models/testimony_model.dart';
import 'package:http/http.dart' as http;

///This class fetches data from the API and serializes it into Dart data structures.
class ApiService extends ApiServiceContract {
  @override
  Future<ProgramModel> fetchClass(int id) async {
    final response = await http.get(Uri.parse("https://api.nextiswhatwedo.org/api/class?id=${id}"));

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body) as List<dynamic>;

      return ProgramModel.fromJson(map.first);
    } else {
      throw Exception("Failed to load class.");
    }
  }

  @override
  Future<List<ProgramModel>> fetchClasses(int mask) async {
    final response = await http.get(Uri.parse("https://api.nextiswhatwedo.org/api/classes?mask=${mask}"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;

      List<ProgramModel> classList = List.empty(growable: true);

      for (var i = 0; i < json.length; i++) {
        classList.add(ProgramModel.fromJson(json[i] as Map<String, dynamic>));
      }

      return classList;
    } else {
      throw Exception("Failed to load classes.");
    }
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse("https://api.nextiswhatwedo.org/api/categories"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;

      List<CategoryModel> categoryList = List.empty(growable: true);

      for (var i = 0; i < json.length; i++) {
        categoryList.add(CategoryModel.fromJson(json[i] as Map<String, dynamic>));
      }

      return categoryList;
    } else {
      throw Exception("Failed to load categories.");
    }
  }

  @override
  Future<List<TestimonyModel>> fetchTestimonies(int classId) async {
    final response = await http.get(Uri.parse("https://api.nextiswhatwedo.org/api/testimonies?classId=$classId"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;

      List<TestimonyModel> testimonyList = List.empty(growable: true);

      for (var i = 0; i < json.length; i++) {
        testimonyList.add(TestimonyModel.fromJson(json[i] as Map<String, dynamic>));
      }

      return testimonyList;
    } else {
      throw Exception("Failed to load testimonies.");
    }
  }
  
  @override
  Future<List<String>> fetchImages(int classId) async {
    final response = await http.get(Uri.parse("https://api.nextiswhatwedo.org/api/images?classId=$classId"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;

      List<String> imageList = List.empty(growable: true);

      for (var i = 0; i < json.length; i++) {
        String url = switch (json[i] as Map<String, dynamic>) {
          {
            'url' : String mapUrl,
          } => mapUrl,
          _ => throw Exception()
        };

        imageList.add(url);
      }

      return imageList;
    } else {
      throw Exception("Failed to load images.");
    }
  }

  @override
  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse("https://api.nextiswhatwedo.org/api/events"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;

      List<EventModel> eventList = List.empty(growable: true);

      for (var i = 0; i < json.length; i++) {
        eventList.add(EventModel.fromJson(json[i] as Map<String, dynamic>));
      }

      return eventList;
    } else {
      throw Exception("Failed to load events.");
    }
  }

  @override
  Future<InformationModel> fetchAtcInformation() async {
    final response = await http.get(Uri.parse("https://api.nextiswhatwedo.org/atcinformation.json"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      return InformationModel.fromJson(json);
    } else {
      throw Exception("Failed to fetch ATC information.");
    }
  }
  
}