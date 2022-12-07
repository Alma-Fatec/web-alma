// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RenderImageWeb extends StatelessWidget {
  const RenderImageWeb({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imageUrl,
      (int _) => ImageElement()..src = imageUrl,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        height: 260,
        width: 460,
        child: HtmlElementView(
          viewType: imageUrl,
        ),
      ),
    );
  }
}
