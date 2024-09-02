import 'package:atc_mobile_app/content/route_main.dart';
import 'package:atc_mobile_app/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// This route describes the loading phase of the application.
/// 
/// All preprocessors will be completed in this class before the route is
/// switched to the main route. All dependencies are loaded in this class.
class RouteSplash extends StatefulWidget {
  const RouteSplash({super.key});

  @override
  State<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends State<RouteSplash> {
  /// Number of preprocesses that have completed.
  var _preprocessProgress = 0;

  /// Number of preprocesses that must be completed to continue.
  static const _numPreprocesses = 2;

  GetIt getIt = GetIt.instance;

  _registerServices() {
     /// TODO register services

    setState(() {
      _preprocessProgress++;
    });
  }

  _registerViewModels() {
    getIt.registerSingleton<HomeViewModel>(HomeViewModel());

    setState(() {
      _preprocessProgress++;
    });
  }

  @override
  void initState() {
    super.initState();

    _registerServices();
    _registerViewModels();
  }

  @override
  Widget build(BuildContext context) {
    return _preprocessProgress == _numPreprocesses 
      ? const RouteMain() 
      : const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
  }
}

