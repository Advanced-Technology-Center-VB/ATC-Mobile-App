import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/route/route_class.dart';
import 'package:atc_mobile_app/view_models/app_hub_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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

    GetIt.instance.get<AppHubViewModel>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppHubViewModel>(builder: (context, viewModel, _) {
      var vm = viewModel as AppHubViewModel; // Get viewmodel of its own type.

      return vm.ready ? Scaffold(
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
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context).colorScheme.secondary
                        ),
                        child: Text(vm.countdownText, style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary
                        )),
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
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await launchUrl(Uri.parse("https://atcapplication.vbcps.com"));
          },
          label: const Text("Apply now"),
          icon: const Icon(Icons.edit),
        ),
      ) : const Center(child: CircularProgressIndicator());
    });
  }

}