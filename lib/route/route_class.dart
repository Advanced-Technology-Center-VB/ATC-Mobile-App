import 'package:atc_mobile_app/contracts/api_service_contract.dart';
import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/view_models/class_view_model.dart';
import 'package:atc_mobile_app/widgets/connection_error.dart';
import 'package:atc_mobile_app/widgets/image_carousel.dart';
import 'package:atc_mobile_app/widgets/lazy_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RouteClass extends StatefulWidget {
  final ClassModel classModel;

  const RouteClass({super.key, required this.classModel});

  @override
  State<StatefulWidget> createState() =>_RouteClassState();

}

class _RouteClassState extends State<RouteClass> {
  final bool _stretch = true;

  TextStyle headerStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 22
  );

  String formatEnrollment(int yearsEnrolled) {
    var suffix = "year";

    if (yearsEnrolled > 1) {
      suffix += "s";
    }

    return "$yearsEnrolled $suffix";
  }

  @override
  void initState() {
    super.initState();

    var vm = GetIt.instance.get<ClassViewModel>();

    vm.model = widget.classModel;
    vm.fetchData().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(builder: (context, viewModel, _) {
      ClassViewModel vm = viewModel as ClassViewModel;

      var textVariant = TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant);
      
      return Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar.large(
              stretch: _stretch,
              stretchTriggerOffset: 300.0,
              expandedHeight: 150.0,
              title: Text(widget.classModel.name)
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(delegate: 
                SliverChildListDelegate.fixed([
                  Text(widget.classModel.description),
                  const SizedBox(height: 16),
                  Text("About this program", style: headerStyle),
                  const SizedBox(height: 16),
                  Text(widget.classModel.about),
                  const SizedBox(height: 16),
                  Text("Prerequisites: ${widget.classModel.prerequisites}"),
                  const SizedBox(height: 16),
                  Text("Students in action", style: headerStyle),
                  const SizedBox(height: 16),
                  ImageCarousel(
                    height: 227,
                    images: vm.images
                  ),
                  const SizedBox(height: 16),
                  Text("Student thoughts", style: headerStyle),
                  const SizedBox(height: 16),
                  ListView.separated(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: vm.testimonies.length,
                    itemBuilder: (context, index) => Wrap(
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 6,
                          children: [
                            Text(vm.testimonies[index].studentName, style: textVariant),
                            Text("•", style: textVariant,),
                            Text("Enrolled for ${formatEnrollment(vm.testimonies[index].yearsAttended)}", style: textVariant,)
                          ],
                        ),
                        Text(vm.testimonies[index].statement),
                      ]),
                      separatorBuilder: (_,__) => Divider(thickness: 1, color: Theme.of(context).colorScheme.outlineVariant),
                    )
                  ]
                )
              ),
            ),
          ]
        ),
      );
    });
  }
}