import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  final String image;

  FullImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image(
          image: NetworkImage(image),

        ),
      ),
    );
  }
}
