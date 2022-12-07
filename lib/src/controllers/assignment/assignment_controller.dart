import 'package:alma_web/src/controllers/assignment/assignment_sate.dart';
import 'package:alma_web/src/data/enum/assignment_type.dart';
import 'package:alma_web/src/data/models/assignment/assignment_model.dart';
import 'package:alma_web/src/data/models/class/class_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:alma_web/src/data/repository/assignment/assignment_repository.dart';
import 'package:alma_web/src/utils/file_picker.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

class AssignmentController extends ChangeNotifier {
  String title = '';
  String answer = '';
  String description = '';

  List<bool> optionIsCorrectDrop = [true, false];
  List<AssignmentType> listKind = [
    AssignmentType.NONE,
    AssignmentType.ALTERNATIVA_COM_AUDIO,
    AssignmentType.ALTERNATIVA_COM_IMAGENS,
    AssignmentType.DIGITACAO,
  ];

  var state = AssignmentState.idle;
  var assignmentType = AssignmentType.NONE;

  String text = '';
  bool isCorrect = false;

  List<PlatformFile> files = [];
  List<Map<String, dynamic>> listOptions = [];
  List<Class> listClasses = [];
  List<Class> listClassAssignment = [];

  AssignmentRepository repository;
  FilePickerUtil filePicker;

  AssignmentController(this.repository, this.filePicker) {
    _getListClass();
  }

  Future<void> createAssignment() async {
    setState(AssignmentState.loading);

    try {
      String token = await SharedPref().read("token");

      if (files.isNotEmpty) {
        await repository.createAssignment(
          token,
          Assignment(
            title: title,
            description: description,
            classe: listClassAssignment.map((e) => e.id!).toList(),
            answer: answer,
            kind: assignmentType.name != 'DIGITACAO'
                ? assignmentType.name
                : 'DIGITAÇÃO',
            options: listOptions,
          ),
          file: files.first,
        );
      } else {
        await repository.createAssignment(
          token,
          Assignment(
            title: title,
            description: description,
            classe: listClassAssignment.map((e) => e.id!).toList(),
            answer: answer,
            kind: assignmentType.name != 'DIGITACAO'
                ? assignmentType.name
                : 'DIGITAÇÃO',
            options: listOptions,
          ),
        );
      }

      listOptions.clear();
      listClassAssignment.clear();
      files.clear();
      setState(AssignmentState.success);
    } catch (e) {
      setState(AssignmentState.error);

      Exception(e.toString());
    }
  }

  Future<void> _getListClass() async {
    listClasses.clear();

    try {
      String token = await SharedPref().read('token');
      ListResponse listClassResp = await repository.getListClasses(token);
      setListClass(listClassResp);
    } catch (e) {
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

  String formatAssignmentType(AssignmentType type) {
    switch (type) {
      case AssignmentType.NONE:
        return 'Selecione';
      case AssignmentType.ALTERNATIVA_COM_IMAGENS:
        return 'Alternativa com imagens';
      case AssignmentType.ALTERNATIVA_COM_AUDIO:
        return 'Alternativa com áudio';
      case AssignmentType.DIGITACAO:
        return 'Digitação';
    }
  }

  void setListClass(ListResponse listClassResp) {
    listClasses.clear();
    listClassResp.data?.forEach((element) {
      listClasses.add(Class.fromJson(element));
    });
  }

  void setIscorrect(bool value) {
    setState(AssignmentState.idle);

    isCorrect = value;
    notifyListeners();
  }

  void setState(AssignmentState state) {
    this.state = state;
    notifyListeners();
  }

  void setAssignmentType(AssignmentType value) {
    setState(AssignmentState.idle);
    answer = '';
    description = '';

    assignmentType = value;
    notifyListeners();
  }

  void addClassOnAssignment(Class listClass) {
    setState(AssignmentState.idle);

    listClassAssignment.add(listClass);
    notifyListeners();
  }

  void addOption() {
    setState(AssignmentState.idle);

    listOptions.add({"text": text, "isCorrect": isCorrect});
    notifyListeners();
  }
}
