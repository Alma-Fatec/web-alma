import 'package:alma_web/src/controllers/assignment/assignment_sate.dart';
import 'package:alma_web/src/data/models/assignment/assignment_model.dart';
import 'package:alma_web/src/data/repository/assignment/assignment_repository.dart';
import 'package:alma_web/src/utils/file_picker.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

class AssignmentController extends ChangeNotifier {
  String title = '';
  String name = '';
  String description = '';

  var state = AssignmentState.idle;

  List<PlatformFile> files = [];

  AssignmentRepository repository;
  FilePickerUtil filePicker;

  AssignmentController(this.repository, this.filePicker);

  Future<void> createAssignment() async {
    setState(AssignmentState.loading);

    try {
      String token = await SharedPref().read("token");
      await repository.createAssignment(
        token,
        files.first,
        Assignment(
          name: name,
          title: title,
          description: description,
        ),
      );

      files.clear();
      setState(AssignmentState.success);
    } catch (e) {
      setState(AssignmentState.error);

      Exception(e.toString());
    }
  }

  Future<void> pickFiles() async {
    setState(AssignmentState.idle);

    PlatformFile file;
    files.clear();

    try {
      file = await filePicker.getFiles();

      if (file.name.isEmpty) {
        return;
      }

      files.add(file);
      notifyListeners();
    } catch (e) {
      Exception(e.toString());
    }
  }

  void setState(AssignmentState state) {
    this.state = state;
    notifyListeners();
  }
}
