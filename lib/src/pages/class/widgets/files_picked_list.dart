import 'package:alma_web/src/controllers/class/class_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilesPickedList<T> extends StatelessWidget {
  const FilesPickedList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClassController>();
    return ListView.builder(
      itemCount: controller.files.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3.0),
          child: Image.memory(controller.files[index].bytes!, height: 200, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
