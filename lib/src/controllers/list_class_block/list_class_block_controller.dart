import 'package:alma_web/src/controllers/list_class_block/list_class_block_state.dart';
import 'package:alma_web/src/data/models/block/block_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:alma_web/src/data/repository/list_class_block/list_class_block_repository.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class ListClassBlockController extends ChangeNotifier {
  var state = ListClassBlockState.idle;
  List<Block> listClassBlock = [];

  ListClassBlockRepository repository;
  ListClassBlockController(this.repository) {
    _getListClassBlock();
  }

  Future<void> _getListClassBlock() async {
    listClassBlock.clear();
    state = ListClassBlockState.loading;
    notifyListeners();

    try {
      String token = await SharedPref().read('token');
      ListResponse listClassBlockResp =
          await repository.getListClassBlock(token);

      if (listClassBlock.isEmpty) {
        listClassBlockResp.data?.forEach((element) {
          listClassBlock.add(Block.fromJson(element));
        });
      }

      state = ListClassBlockState.success;
      notifyListeners();
    } catch (e) {
      state = ListClassBlockState.error;
      notifyListeners();

      throw Exception(e.toString());
    }
  }

  Future<void> deleteClassBlock(String id, int index) async {
    state = ListClassBlockState.loading;
    notifyListeners();

    try {
      String token = await SharedPref().read("token");
      await repository.deleteClassBlock(token, id);
      
      listClassBlock.removeAt(index);
      state = ListClassBlockState.successDelete;
      notifyListeners();
    } catch (e) {
      state = ListClassBlockState.errorDelete;
      notifyListeners();

      throw Exception(e.toString());
    }
  }
}
