import 'package:alma_web/src/controllers/list_class_block/list_class_block_state.dart';
import 'package:alma_web/src/data/models/block/block_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:alma_web/src/data/repository/list_class_block/list_class_block_repository.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class ListClassBlockController extends ChangeNotifier {
  var state = ListClassBlockState.idle;
  List<Block> listClassBlock = [];

  int page = 1;
  bool isLastPage = false;

  ListClassBlockRepository repository;
  ListClassBlockController(this.repository) {
    _getListClassBlock();
  }

  Future<void> refresh() async {
    await _getListClassBlock();
  }

  Future<void> _getListClassBlock() async {
    setState(ListClassBlockState.loading);
    try {
      String token = await SharedPref().read('token');
      ListResponse listClassBlockResp = await repository.getListClassBlock(token, page);

      setListClassBlock(listClassBlockResp);

      setState(ListClassBlockState.success);
    } catch (e) {
      setState(ListClassBlockState.error);

      Exception(e.toString());
    }
  }

  Future<void> deleteClassBlock(String id, int index) async {
    setState(ListClassBlockState.loading);

    try {
      String token = await SharedPref().read("token");
      await repository.deleteClassBlock(token, id);

      listClassBlock.removeAt(index);
      setState(ListClassBlockState.successDelete);
    } catch (e) {
      setState(ListClassBlockState.errorDelete);

      Exception(e.toString());
    }
  }

  void setListClassBlock(ListResponse listClassBlockResp) {
    listClassBlock.clear();
    listClassBlockResp.data?.forEach((element) {
      listClassBlock.add(Block.fromJson(element));
    });
  }

  void nextPage() {
    isLastPage = listClassBlock.length < 10;

    if (isLastPage) {
      return;
    }
    page++;
    _getListClassBlock();
  }

  void backPage() {
    if (page == 1) {
      return;
    }
    page--;
    _getListClassBlock();
  }

  void setState(ListClassBlockState state) {
    this.state = state;
    notifyListeners();
  }
}
