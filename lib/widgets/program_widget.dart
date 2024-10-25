import 'package:atc_mobile_app/models/class_model.dart';
import 'package:atc_mobile_app/route/route_class.dart';
import 'package:flutter/material.dart';

class ProgramWidget extends StatelessWidget {
  final ClassModel classModel;

  const ProgramWidget({super.key, required this.classModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RouteClass(classModel: classModel)));
      },
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 4,
        children: [
          Text(
            textAlign: TextAlign.start,
            classModel.name, 
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            classModel.category,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400
            )
          )
        ],
      )
    );
  }
  
}