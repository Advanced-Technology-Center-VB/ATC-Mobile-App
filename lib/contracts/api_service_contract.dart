import 'package:atc_mobile_app/models/category_model.dart';
import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/models/event_model.dart';
import 'package:atc_mobile_app/models/testimony_model.dart';

abstract class ApiServiceContract {
  ///Returns all class data from id.
  Future<ClassModel> fetchClass(int id);
  ///Gets all classes but only their name and id.
  Future<List<ClassModel>> fetchClasses(int mask);
  ///Gets all categories.
  Future<List<CategoryModel>> fetchCategories();
  ///Get testimonials for a class.
  Future<List<TestimonyModel>> fetchTestimonies(int classId);
  ///Get images for a class.
  Future<List<String>> fetchImages(int classId);
  ///Get events that are current.
  Future<List<EventModel>> fetchEvents();
}