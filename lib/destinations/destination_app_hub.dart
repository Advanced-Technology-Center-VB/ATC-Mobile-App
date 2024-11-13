import 'dart:math';

import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/route/route_class.dart';
import 'package:atc_mobile_app/view_models/app_hub_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationAppHub extends StatefulWidget {
  const DestinationAppHub({super.key});

  @override
  State<DestinationAppHub> createState() => _DestionationAppHubState();  
}

class _DestionationAppHubState extends State<DestinationAppHub> {
  @override
  void initState() {
    super.initState();

    GetIt.instance.get<AppHubViewModel>().fetchData(); //Refetch data every time this destination is navigated to.
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppHubViewModel>(builder: (context, viewModel, _) {
      var vm = viewModel as AppHubViewModel; // Get viewmodel of its own type.

      return vm.ready ? Scaffold( //Check if the viewmodel has finished fetching data, if not display progress indicator.
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              stretch: true,
              pinned: false,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [ StretchMode.zoomBackground, StretchMode.blurBackground ],
                titlePadding: const EdgeInsets.all(16),
                title: const Text("Application Hub", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400 
                )),
                background: Image.network("http://files.nextiswhatwedo.org/atcapplynow.webp", fit: BoxFit.fitHeight),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      const Text("ATC Application Deadline"),
                      const Spacer(),
                      InkWell(
                        onTap: () => {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              icon: const Icon(Icons.alarm),
                              title: const Text("ATC Application Deadline"),
                              actions: [
                                TextButton(onPressed: () => setState(() {
                                  Navigator.pop(context);
                                }), child: const Text("OK"))
                              ],
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Application deadline: ${DateFormat.MMMd().format(vm.info!.applicationDeadline)}, ${vm.info!.applicationDeadline.year.toString()} at ${DateFormat.Hm().format(vm.info!.applicationDeadline)}",
                                      softWrap: true
                                    ),
                                    Text("Late application deadline: ${DateFormat.MMMd().format(vm.info!.applicationLateDeadline)}, ${vm.info!.applicationLateDeadline.year.toString()} at ${DateFormat.Hm().format(vm.info!.applicationLateDeadline)}",
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              )
                            )
                          )
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Theme.of(context).colorScheme.secondary
                          ),
                          child: Text(vm.countdownText, style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary
                          )),
                        ),
                      )
                    ],  
                  )
                ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(child: Text("My wishlist", style: TextStyle(
                fontSize: 24
              ))), // Use SliverToBoxAdapter to use add a normal widget.
            ),
            vm.models!.isNotEmpty ? SliverList.builder(
              itemCount: vm.models?.length ?? 0,
              itemBuilder: (_, i) => ListTile(
                title: Text(vm.models![i].name),
                subtitle: Text(vm.models![i].category, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                trailing: const Icon(Icons.arrow_right),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                enableFeedback: true,
                onTap: () async {
                  var shouldRefresh = await Navigator.push<bool>(
                    context, 
                    MaterialPageRoute(
                      builder: (_) => RouteClass(classModel: vm.models![i])
                    )
                  );

                  if (shouldRefresh ?? true) {
                    setState(() {
                      // Just refresh the state to update the wishlist
                    });
                  }
                },
              ),
            ): SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Navigate to a program and select \"Add to wishlist\" and it will appear here.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  softWrap: true
                ) 
              )     
            ),
            const SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(child: Text("Application checklist", style: TextStyle(
                fontSize: 24
              ))), // Use SliverToBoxAdapter to use add a normal widget.
            ),
            SliverList.builder(
              itemCount: vm.info!.applicationChecklist.length,
              itemBuilder: (_, index) => CheckboxListTile(
                title: Text(vm.info!.applicationChecklist[index], softWrap: true),
                value: vm.checklistMask >> index & 1 == 1, //Checklist data is stored by a single number value, I do this by shifting the bits and checking if a certain bit is a 1 or a 0.
                onChanged: (val) {
                  setState(() {
                    if (val ?? false) {
                    vm.checklistMask += pow(2, index) as int; //Adding 2^index sets the bit in the position of index to 1.
                  } else {
                    vm.checklistMask -= pow(2, index) as int; //Subtracting 2^index sets the bit in the position of index to 0.
                  }
                  });
                }
              )
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await launchUrl(Uri.parse(vm.info!.applicationUrl)); //Launch browser with application url.
          },
          label: const Text("Apply now"),
          icon: const Icon(Icons.edit),
        ),
      ) : const Center(child: CircularProgressIndicator());
    });
  }

}