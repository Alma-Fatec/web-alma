import 'package:alma_web/src/controllers/class/class_states.dart';
import 'package:alma_web/src/data/models/block/block_model.dart';
import 'package:alma_web/src/data/models/class/class_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:alma_web/src/data/repository/class/class_repository.dart';
import 'package:alma_web/src/utils/file_picker.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

class ClassController extends ChangeNotifier {
  String name = '';
  String description = '';
  String order = '';

  List<PlatformFile> files = [];
  List<Block> listBlocksClass = [];
  List<Block> listAllBlocks = [];

  var state = ClassStates.idle;

  ClassRepository repository;
  FilePickerUtil filePicker;

  ClassController(this.repository, this.filePicker) {
    _getListClassBlock();
    files.clear();
    listBlocksClass.clear();
  }

  Future<void> createClass() async {
    setState(ClassStates.loading);

    try {
      String token = await SharedPref().read("token");
      await repository.createClass(
          token,
          files.first,
          Class(
            name: name,
            description: description,
          ),
          listBlockMap());

      files.clear();
      listBlocksClass.clear();

      setState(ClassStates.success);
    } catch (e) {
      files.clear();
      listBlocksClass.clear();

      setState(ClassStates.error);
      Exception(e.toString());
    }
  }

  Future<void> _getListClassBlock() async {
    listAllBlocks.clear();

    try {
      String token = await SharedPref().read('token');
      ListResponse listClassBlockResp =
          await repository.getListClassBlock(token);

      if (listAllBlocks.isEmpty) {
        listClassBlockResp.data?.forEach((element) {
          listAllBlocks.add(Block.fromJson(element));
        });
      }
    } catch (e) {
      Exception(e.toString());
    }
  }

  List<Map<String, dynamic>> listBlockMap() {
    List<Map<String, dynamic>> listBlocksMap = [];
    listBlocksMap.clear();

    for (int i = 0; i < listBlocksClass.length; i++) {
      listBlocksMap.add({"block[$i]": listBlocksClass[i].id});
    }

    return listBlocksMap;
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

  void addBlockOnClass(Block block) {
    listBlocksClass.add(block);
    notifyListeners();
  }

  void setState(ClassStates state) {
    this.state = state;
    notifyListeners();
  }
}
