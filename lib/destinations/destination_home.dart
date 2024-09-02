import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/view_models/home_view_model.dart';
import 'package:flutter/material.dart';

class DestinationHome extends StatefulWidget {
  const DestinationHome({super.key});

  @override
  State<DestinationHome> createState() => _DestinationHomeState();
}

class _DestinationHomeState extends State<DestinationHome> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(builder: (context, viewModel, _) {
      HomeViewModel vm = viewModel as HomeViewModel;

      return Column(children: [
        Text("Count: ${vm.counter}"),
        TextButton(
          onPressed: () {
            vm.incrementCounter();
        },
        child: const Text("Increment"))
      ],);
    });
  }
}