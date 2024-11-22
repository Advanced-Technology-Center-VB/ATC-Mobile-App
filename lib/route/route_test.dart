import 'package:atc_mobile_app/route/route_main.dart';
import 'package:flutter/material.dart';

class RouteTest extends StatefulWidget {
  const RouteTest({super.key});

  @override
  State<RouteTest> createState() => _RouteTestState();

}

class _RouteTestState extends State<RouteTest> {
  final _controller = PageController();
  
  late List<Widget> _pages;

  _RouteTestState() {
    _pages = <Widget>[
      const Flex(
        direction: Axis.vertical,
        children: [
          Spacer(),
          Icon(Icons.access_time, size: 36,),
          Text(
            "ATC next Internal Test",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 36
            ),
          ),
          SizedBox(height: 40),
          Text(
            "Welcome to the ATC next internal test. You downloaded this app because you agreed to provide testing feedback and point out potential bug fixes for the app. If you do not intend to do so, please uninstall this application immeadiately.",
            textAlign: TextAlign.center,
          ),
          Spacer()
        ],
      ),
      const Column(
        children: [
          Spacer(),
          Icon(Icons.note, size: 36,),
          Text(
            "Things to note",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 36
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "\u2022 Data such as event times, dates and headline information are not final\n" 
              "\u2022 Class information is not fully added to the database, expect missing images and student testimonies\n"
              "\u2022 Not every class has been entered into the database, expect missing classes\n"
              "\u2022 Please try and cover all bases when testing, act like a parent or potential student looking to apply for the ATC\n"
            ),
          ),
          Spacer()
        ],
      ),
      Column(
        children: [
          const Spacer(),
          const Icon(Icons.person, size: 36,),
          const Text(
            "Providing feedback",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 36
            ),
          ),
          const SizedBox(height: 40),
          const Text("Your feedback is crucial to ensuring a good experience for parents and potential students during and after STEM night. If you have any suggestions, bug reports, or questions, you can contact me at the following:", textAlign: TextAlign.center,),
          const SizedBox(height: 40),
          const Wrap(direction: Axis.horizontal, crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, children: [
            Icon(Icons.email_outlined),
            Text("Email: wstrongvi@gmail.com"),
          ]),
          const SizedBox(height: 8,),
          const Wrap(direction: Axis.horizontal, crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, children: [
            Icon(Icons.sms_outlined),
            Text("Text: (757) 204-1447"),
          ]),
          const SizedBox(height: 40),
          FilledButton(onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const RouteMain()), (Route<dynamic> route) => false);
            
          }, child: const Text("Start testing")),
          const Spacer()
        ],
      )
    ];
  }

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: PageView(
          controller: _controller,
          onPageChanged: (value) => setState(() => _currentPage = value),
          children: _pages
        ),
      )
    ),
    bottomNavigationBar: SafeArea(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          IconButton(
            onPressed: () {
              if (_currentPage > 0) {
                setState(() {
                  _controller.animateToPage(
                    --_currentPage, 
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.easeInOutCirc
                  );  
                });
              }
            }, 
            icon: const Icon(Icons.arrow_left)
          ),
          const Spacer(),
          Wrap(
            spacing: 8,
            direction: Axis.horizontal,
            children: _pages.asMap().entries.map(
              (index) => Container(
                width: 6, 
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _currentPage == index.key ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outlineVariant)
                ),
                
              ).toList()
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              if (_currentPage < _pages.length - 1) {
                setState(() {
                  _controller.animateToPage(
                    ++_currentPage, 
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.easeInOutCirc
                  );  
                });
              }
            }, 
            icon: const Icon(Icons.arrow_right)
          ),
        ]
      ),
    )
  );
  
}