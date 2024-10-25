import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<Image> images;

  final double? width;
  final double? height;

  final BoxDecoration? decoration;


  const ImageCarousel({super.key, required this.images, this.width, this.height, this.decoration});

  @override
  State<StatefulWidget> createState() => _ImageCarouselState();

}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      child: CarouselView(
        itemExtent: 300,
        itemSnapping: true,
         children: widget.images
      )
    );
  }
  
}