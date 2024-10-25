import 'package:flutter/material.dart';

typedef LazyWidgetBuilder = Widget Function(int position);

/// This class is good for when you need to generate a list of widgets based on an index.
class LazyWidget {
  int count, start, end;
  LazyWidgetBuilder builder;

  LazyWidget({required this.count, required this.builder, this.start = 0, this.end = -1});

  List<Widget> getList() {
    List<Widget> output = List.empty(growable: true);

    for (int i = start; i < (end == -1 ? count : end); i++) {
      output.add(builder.call(i));
    }

    return output;
  }
}