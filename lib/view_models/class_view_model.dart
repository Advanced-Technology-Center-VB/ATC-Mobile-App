import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/contracts/local_storage_service_contract.dart';
import 'package:atc_mobile_app/models/program_model.dart';
import 'package:atc_mobile_app/models/testimony_model.dart';
import 'package:atc_mobile_app/provider/base_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//TODO: This whole system needs to be reworked, but it is not a priority. 
class ProgramViewModel extends BaseModel {
  bool ready = false;
  bool error = false;

  bool loadingImages = true;
  bool inWishlist = false;

  late ProgramModel model;

  List<ProgramModel> wishlist = List<ProgramModel>.empty(growable: true);

  List<TestimonyModel> testimonies = List.empty();
  List<Image> images = List.empty();

  ApiServiceContract api = GetIt.instance.get<ApiServiceContract>();

  ProgramViewModel() {
    fetchWishlist().whenComplete(() => notifyListeners());
  }

  void reset() {
    images = List.empty(growable: true);
    testimonies = List.empty(growable: true);
  }

  Future<void> fetchData() async {
    ready = false;
    error = false;

    notifyListeners();

    try {
      fetchTestimonies();
      fetchImages();

      ready = true;
    } catch (_) {
      error = true;
    }
    
    notifyListeners();
  }

  void fetchTestimonies() async {
    loadingImages = true;

    notifyListeners();

    testimonies = await api.fetchTestimonies(model.id);

    loadingImages = false;

    notifyListeners();
  }

  void fetchImages() async {
    var urls = await api.fetchImages(model.id);

    images = urls.map((url) => Image.network(url, fit: BoxFit.cover)).toList();
  }

  Future<void> fetchWishlist() async {
    var service = GetIt.instance.get<LocalStorageServiceContract>();

    var serviceList = await service.getWishlist();

    wishlist = List<ProgramModel>.generate(serviceList.length, (_) => ProgramModel(id: 0, name: ""));
    List.copyRange(wishlist, 0, serviceList);
  }
}