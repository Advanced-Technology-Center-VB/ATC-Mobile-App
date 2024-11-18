import 'dart:async';

import 'package:atc_mobile_app/contracts/local_storage_service_contract.dart';
import 'package:atc_mobile_app/models/program_model.dart';
import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/view_models/class_view_model.dart';
import 'package:atc_mobile_app/widgets/image_carousel.dart';
import 'package:atc_mobile_app/widgets/lazy_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RouteClass extends StatefulWidget {
  final ProgramModel classModel;

  const RouteClass({super.key, required this.classModel});

  @override
  State<StatefulWidget> createState() =>_RouteClassState();

}

class _RouteClassState extends State<RouteClass> {
  final bool _stretch = true;

  PageView? _imageScroll;

  final _imageScrollController = PageController();
  var _pageIndex = 0;

  Timer? _imageCycleTimer;

  TextStyle headerStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 22
  );

  String _formatEnrollment(int yearsEnrolled) {
    var suffix = "year";

    if (yearsEnrolled > 1) {
      suffix += "s";
    }

    return "$yearsEnrolled $suffix";
  }

  @override
  void initState() {
    super.initState();

    var vm = GetIt.instance.get<ProgramViewModel>();

    vm.model = widget.classModel;
    vm.inWishlist = vm.wishlist.where((model) => model.id == widget.classModel.id).isNotEmpty;

    vm.fetchData().whenComplete(() {
      setState(() {
        _imageScroll = PageView.builder(
        onPageChanged: (value) {
          setState(() {
            _pageIndex = value;

            if (_imageCycleTimer != null) {
              _imageCycleTimer?.cancel();

              _startImageCycleTimer();
            }
          });
        },
        controller: _imageScrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => vm.images[index % vm.images.length]
      );

       _startImageCycleTimer();
      });
    });
  }

  void _startImageCycleTimer() {
    _imageCycleTimer = Timer.periodic(const Duration(seconds: 5), (t) {
        setState(() {
          if (!_imageScrollController.hasClients) return;

          _imageScrollController.animateToPage(_pageIndex + 1, duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      });
    });
  }

  @override
  void deactivate() {
    super.deactivate();

    var vm = GetIt.instance.get<ProgramViewModel>();
    var wishlistService = GetIt.instance.get<LocalStorageServiceContract>();

    wishlistService.writeWishlist(vm.wishlist);

    if (_imageCycleTimer != null) {
      _imageCycleTimer?.cancel(); 
    }

    _imageScrollController.dispose();

    vm.reset();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProgramViewModel>(builder: (context, viewModel, _) {
      ProgramViewModel vm = viewModel as ProgramViewModel;

      var textVariant = TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant);
      
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () { //This button controls adding and removing a program from the wishlist.
            setState(() {
              String message;

              if (vm.inWishlist) {
                vm.wishlist.removeWhere((model) => model.id == widget.classModel.id);
                vm.inWishlist = false;

                message = "Removed ${widget.classModel.name} from your wishlist!";
              } else {
                vm.wishlist.add(widget.classModel);
                vm.inWishlist = true;

                message = "Added ${widget.classModel.name} to your wishlist!";
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            });
          }, 
          label: Text(vm.inWishlist ? "Remove from wishlist" : "Add to wishlist"),
          icon: Icon(vm.inWishlist ? Icons.remove : Icons.edit),
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar.large(
              stretch: _stretch,
              stretchTriggerOffset: 300.0,
              expandedHeight: 150.0,
              title: Text(widget.classModel.name),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                }, 
                icon: const Icon(Icons.arrow_back)
              ),
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
                  !vm.loadingImages ? SizedBox(
                    height: 200,
                    child: vm.images.isNotEmpty ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _imageScroll,
                    ) : const SizedBox.shrink()
                  ) : const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 16),
                  Center( //This renders the dots at the bottom of the headline widget, I know it's pretty funky...
                    child: Wrap(
                      spacing: 4,
                      children: LazyWidget(
                        count: vm.images.length,
                        builder: (selection) => Container(width: 10, height: 10, decoration: BoxDecoration(color: selection == _pageIndex % vm.images.length ? Theme.of(context).colorScheme.outlineVariant : Colors.white, border: Border.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1), borderRadius: BorderRadius.circular(100)),)
                      ).getList(),
                    ),
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
                            Text("Enrolled for ${_formatEnrollment(vm.testimonies[index].yearsAttended)}", style: textVariant,)
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
            const SliverToBoxAdapter( //This is a spacer for the bottom of the page so the FAB doesn't cover content.
              child: SizedBox(height: 100),
            )
          ]
        ),
      );
    });
  }
}