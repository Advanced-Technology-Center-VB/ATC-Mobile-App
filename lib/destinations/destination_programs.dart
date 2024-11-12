import 'dart:math';

import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/route/route_class.dart';
import 'package:atc_mobile_app/view_models/programs_view_model.dart';
import 'package:atc_mobile_app/widgets/connection_error.dart';
import 'package:atc_mobile_app/widgets/program_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DestinationPrograms extends StatefulWidget {
  const DestinationPrograms({super.key});

  @override
  State<DestinationPrograms> createState() => _DestinationProgramsState();
}

class _DestinationProgramsState extends State<DestinationPrograms> {
  var currentTab = 0;

  @override
  void initState() {
    super.initState();

    GetIt.instance.get<ProgramsViewModel>().syncClasses(1);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProgramsViewModel>(builder: (context, viewmodel, _) {
      ProgramsViewModel vm = viewmodel as ProgramsViewModel;

      if (!vm.ready) {
        if (vm.connectionError) {
          return const ConnectionError();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return SafeArea(
        child: DefaultTabController(
        length: vm.categories.length, 
          child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (index, scrolled) => [
              SliverAppBar(
                centerTitle: true,
                floating: true,
                stretch: true,
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: const Text("Programs"),
              ),
              PinnedHeaderSliver(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: TabBar(
                    onTap: (value) {
                      if (currentTab == value) return;

                      setState(() {
                        vm.syncClasses(pow(2, value) as int);
                      });

                      currentTab = value;
                    },
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: vm.categories.map((category) => Tab(
                      text: category.name,
                    )).toList()
                  ),
                )
              )
            ],
            body: () {
              if (vm.syncingClasses) {
                return Center(child: !vm.connectionError ? const CircularProgressIndicator() : const ConnectionError());
              }

              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: vm.categories.map((category) => ListView.builder(
                  physics: vm.syncingClasses ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                  itemCount: vm.classes.length,
                  itemBuilder: (context,index) => ListTile(
                      title: Text(vm.classes[index].name),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RouteClass(classModel: vm.classes[index]))),
                    )
                  ),
                ).toList()
              );
            }.call()
          )
        )
      );
    });
  }
}