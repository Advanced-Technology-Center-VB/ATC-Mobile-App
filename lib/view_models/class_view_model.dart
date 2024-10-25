import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/models/testimony_model.dart';
import 'package:atc_mobile_app/provider/base_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ClassViewModel extends BaseModel {
  bool ready = false;
  bool error = false;

  late ClassModel model;

  List<TestimonyModel> testimonies = List.empty();
  List<Image> images = List.empty();

  ApiServiceContract api = GetIt.instance.get<ApiServiceContract>();

  Future<void> fetchData() async {
    ready = false;
    error = false;

    try {
      await fetchTestimonies();
      await fetchImages();
    } catch (_) {
      error = true;
    }

    ready = true;
  }

  Future<void> fetchTestimonies() async {
    testimonies = await api.fetchTestimonies(model.id);
  }

  Future<void> fetchImages() async {
    var urls = await api.fetchImages(model.id);

    images = urls.map((url) => Image.network(url, fit: BoxFit.cover)).toList();
  }
}