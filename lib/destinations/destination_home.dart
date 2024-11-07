import 'dart:io';
import 'dart:math';

import 'package:atc_mobile_app/contracts/notification_service_contract.dart';
import 'package:atc_mobile_app/models/event_model.dart';
import 'package:atc_mobile_app/provider/base_view.dart';
import 'package:atc_mobile_app/view_models/home_view_model.dart';
import 'package:atc_mobile_app/widgets/connection_error.dart';
import 'package:atc_mobile_app/widgets/event_card.dart';
import 'package:atc_mobile_app/widgets/lazy_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

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

      var headlines = vm.events.where((event) => event.isHeadline == true).toList();

      if (!vm.isReady) {
        return Center(
          child: vm.error ? const ConnectionError() : const CircularProgressIndicator(),
        );
      }

      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            expandedHeight: 200,
            floating: false,
            pinned: false,
            stretchTriggerOffset: 100,
            stretch: true,
            flexibleSpace: PageView.builder(
              itemCount: headlines.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _buildHeadlineWidget(headlines[index], vm.headlineImageCache[index]))),
                child: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                    Color.fromARGB(95, 0, 0, 0),
                     BlendMode.darken
                   ),
                   child: vm.headlineImageCache[index]
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                
              ],
              titlePadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              title: ListView.custom(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childrenDelegate: SliverChildListDelegate.fixed([
                  Text(headlines[index].headlineTitle ?? headlines[index].title, style: const TextStyle(
                    color: Colors.white
                  )),
                  const Text(
                    "Learn more",
                    style: TextStyle(
                      color: Color.fromARGB(217, 217, 217, 255),
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ),
                  ),
                  Center(
                    child: Wrap(
                      spacing: 4,
                      children: LazyWidget(
                        count: headlines.length,
                        builder: (selection) => Container(width: 5, height: 5, decoration: BoxDecoration(color: selection == index ? Colors.white : const Color.fromARGB(121, 255, 255, 255), borderRadius: BorderRadius.circular(100)),)
                      ).getList(),
                    ),
                  )
                ]),
              )
            )),
              
            )
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverList.builder(
              itemCount: vm.events.length,
              itemBuilder: (context, index) {
              return EventCard(context: context, model: vm.events[index], onAlertAdd: () => _showAlertAddModal(vm.events[index]));
            }),
            //SliverList.builder(itemBuilder: (context, index) => Text(index.toString()))
          )
        ],
      );
    });
  }

  void _showAlertAddModal(EventModel model) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      constraints: const BoxConstraints.expand(), 
      builder: (context) {
        int mask = 32;

        List<String> triggerLabels = [
          "1 day before",
          "12 hours before",
          "6 hours before",
          "1 hour before",
          "10 minutes before",
          "When event starts"
        ];

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.notification_add),
              const Text(
                "Get Notified",
                style: TextStyle(
                  fontSize: 22
               )
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        model.startTimestamp.day.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          height: 1,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      Text(
                        DateFormat.MMM().format(model.startTimestamp).toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        )
                      ),
                    ],
                  ),
                  title: Text(model.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, height: 2)),
                    subtitle: Wrap(
                      spacing: 6,  
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.schedule, size: 16),
                        Text(TimeOfDay.fromDateTime(model.startTimestamp).format(context)),
                        const Text("•"),
                        const Icon(Icons.location_on_outlined, size: 16),
                        Text(model.location)
                      ],
                    ),
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setCheckboxState) {
                    builder(i) {
                      return Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Checkbox(
                            value: mask >> i & 1 == 1,
                            onChanged: (change) => setCheckboxState(() {
                              mask = (change == true ? mask + pow(2, i) : mask - pow(2, i)) as int;
                            })),
                            Text(triggerLabels[i])
                        ],
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: LazyWidget(count: 3, builder: builder).getList()
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: LazyWidget(start: 3, count: triggerLabels.length, builder: builder).getList()
                          )
                        ]
                      ),
                    );
                  }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        GetIt.instance.get<NotificationServiceContract>().scheduleEventNotification(model, mask);

                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Enable notifications")
                    )
                  ]
                )
              ]
            )
          );      
      }
    );  
  }

  Widget _buildHeadlineWidget(EventModel model, Image cachedImage) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text(model.title),
              actions: [
                Platform.isAndroid ? IconButton(
                  onPressed: () => _showAlertAddModal(model), 
                  icon: const Icon(Icons.add_alert_outlined)
                ) : const SizedBox.shrink()
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: cachedImage
                ),
              )
            ),
            PinnedHeaderSliver(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                height: 40,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      spacing: 4,
                      children: [
                        Icon(Icons.calendar_month_outlined, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        Text("${DateFormat.MMMd().format(model.startTimestamp)}, ${model.startTimestamp.year}", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      spacing: 4,
                      children: [
                        Icon(Icons.schedule, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        Text(TimeOfDay.fromDateTime(model.startTimestamp).format(context), style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      spacing: 4,
                      children: [
                        Icon(Icons.location_on_outlined, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        Text(model.location, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                      ],
                    )
                  ],
                )
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: Text(model.summary ?? "Failed to load content."),
              ),
            )
          ],
      ),
      ),
    );
  }
}