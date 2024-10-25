import 'dart:collection';
import 'dart:math';

import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/view_models/programs_view_model.dart';
import 'package:atc_mobile_app/widgets/connection_error.dart';
import 'package:atc_mobile_app/widgets/lazy_widget.dart';
import 'package:atc_mobile_app/widgets/program_widget.dart';
import 'package:flutter/material.dart';

class DestinationPrograms extends StatefulWidget {
  const DestinationPrograms({super.key});

  @override
  State<DestinationPrograms> createState() => _DestinationProgramsState();
}

class _DestinationProgramsState extends State<DestinationPrograms> {
  var mask = 0;

  @override
  Widget build(BuildContext context) {
    return BaseView<ProgramsViewModel>(builder: (context, viewmodel, _) {
      ProgramsViewModel vm = viewmodel as ProgramsViewModel;

      if (!vm.ready) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (vm.connectionError) {
        return const ConnectionError();
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text("Programs"),
        ),
        body: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: LazyWidget(
                  count: vm.categories.length, 
                  builder: (index) => Wrap(
                    children: [
                      const SizedBox(width: 8, height: 0),
                      FilterChip(
                        label: Text(vm.categories[index].name),
                        selected: mask >> index & 1 == 1, 
                        onSelected: (v) async {  
                          setState(() {
                            mask = v ? mask + (pow(2, index) as int) : mask - (pow(2, index) as int);
                          });

                          await vm.syncClasses(mask);

                          setState((){});
                        }
                      )
                    ],
                  )).getList()
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: vm.classes.map((model) {
                  if (vm.syncingClasses)
                  {
                    return const CircularProgressIndicator();
                  }

                  return Wrap(
                    direction: Axis.vertical,
                    spacing: 8,
                    children: [
                      ProgramWidget(classModel: model),
                      const Divider(color: Color.fromARGB(255, 202, 196, 208), thickness: 1,)
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
        )
      );
    });
  }
}