import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/route/route_class.dart';
import 'package:atc_mobile_app/view_models/app_hub_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
            PinnedHeaderSliver(
              child: SafeArea(
                minimum: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  ),
                )
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(child: Text("My wishlist", style: TextStyle(
                fontSize: 24
              ))), // Use SliverToBoxAdapter to use add a normal widget.
            ),
            SliverList.builder(
              itemCount: vm.models?.length ?? 0,
              itemBuilder: (_, i) => ListTile(
                title: Text(vm.models![i].name),
                subtitle: Text(vm.models![i].category, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                trailing: const Icon(Icons.arrow_right),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                enableFeedback: true,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RouteClass(classModel: vm.models![i]))),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text("Apply now"),
          icon: const Icon(Icons.edit),
        ),
      ) : const Center(child: CircularProgressIndicator());
    });
  }

}