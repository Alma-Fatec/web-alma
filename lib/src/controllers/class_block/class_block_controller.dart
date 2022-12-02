import 'package:alma_web/src/controllers/class_block/class_block_state.dart';
import 'package:alma_web/src/data/models/block/block_model.dart';
import 'package:alma_web/src/data/models/user/user_model.dart';
import 'package:alma_web/src/data/repository/class_block/class_block_repository.dart';
import 'package:alma_web/src/utils/file_picker.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class ClassBlockController extends ChangeNotifier {
  String title = '';
  String description = '';

  var state = ClassBlockState.idle;

  String? message;
  FilePickerUtil filePicker;
  ClassBlockRepository repository;

  List<PlatformFile> files = [];
  List<User> listUsersBlock = [];
  List<User> listAllUsers = [];

  ClassBlockController(this.filePicker, this.repository) {
    _listStudents();
    files.clear();
    listUsersBlock.clear();
  }

  Future<void> saveClassBlock() async {
    setState(ClassBlockState.loading);

    try {
      String token = await SharedPref().read('token');

      await repository.createBlock(
        token,
        files.first,
        Block(
          title: title,
          description: description,
        ),
        listUserMap(),
      );

      files.clear();
      listUsersBlock.clear();

      setState(ClassBlockState.success);
    } catch (e) {
      files.clear();
      listUsersBlock.clear();

      setState(ClassBlockState.error);
      Exception(e.toString());
    }
  }

  Future<void> _listStudents() async {
    listAllUsers.clear();
    try {
      String token = await SharedPref().read('token');
      listAllUsers = await repository.getUsers(token);
      listAllUsers = listAllUsers.where((element) => element.role == 'Student').toList();
    } catch (e) {
      Exception(e.toString());
    }
  }

  List<Map<String, dynamic>> listUserMap() {
    List<Map<String, dynamic>> listUsersMap = [];
    listUsersMap.clear();

    for (int i = 0; i < listUsersBlock.length; i++) {
      listUsersMap.add({"users[$i]": listUsersBlock[i].id});
    }

    return listUsersMap;
  }

  Future<void> pickFiles() async {
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

  void addUsersAtClassBlock(User user) {
    listUsersBlock.add(user);
    notifyListeners();
  }

  void setState(ClassBlockState state) {
    this.state = state;
    notifyListeners();
  }
}
