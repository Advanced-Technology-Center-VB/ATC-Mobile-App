import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/contracts/wishlist_service_contract.dart';
import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/models/testimony_model.dart';
import 'package:atc_mobile_app/provider/base_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ClassViewModel extends BaseModel {
  bool ready = false;
  bool error = false;

  bool loadingImages = true;
  bool inWishlist = false;

  late ClassModel model;

  List<ClassModel> wishlist = List<ClassModel>.empty(growable: true);

  List<TestimonyModel> testimonies = List.empty();
  List<Image> images = List.empty();

  ApiServiceContract api = GetIt.instance.get<ApiServiceContract>();

  ClassViewModel() {
    fetchWishlist().whenComplete(() => notifyListeners());
  }

  void fetchData() async {
    ready = false;
    error = false;

    try {
      fetchTestimonies();
      fetchImages();
    } catch (_) {
      error = true;
    }

    ready = true;
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

    notifyListeners();
  }

  Future<void> fetchWishlist() async {
    var service = GetIt.instance.get<WishlistServiceContract>();

    var serviceList = await service.getWishlist();

    wishlist = List<ClassModel>.generate(serviceList.length, (_) => ClassModel(id: 0, name: ""));
    List.copyRange(wishlist, 0, serviceList);
  }
}