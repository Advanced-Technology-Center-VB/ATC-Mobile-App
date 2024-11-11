import 'package:atc_mobile_app/provider/base_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

typedef BuilderCallback<T extends BaseModel> = Widget Function(BuildContext context, T viewModel, Widget? widget);

/// This serves as a means to merge the view and the view model using dependency injection.
/// 
/// The state will create a provider to listen to the view model and make changes to the ui
/// when a value is updated. It will also find the view model using get_it.
class BaseView<T extends BaseModel> extends StatefulWidget {
  final BuilderCallback builder;

  const BaseView({required this.builder, super.key});

  @override State<StatefulWidget> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView> {
  late T viewModel; /// Get the viewmodel

  @override
  void initState() {
    super.initState();

    viewModel = GetIt.instance.get<T>();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<T>(
        builder: widget.builder
        ),
      );
  }
}