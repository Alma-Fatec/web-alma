import 'package:alma_web/src/controllers/list_class/list_class_state.dart';
import 'package:alma_web/src/data/models/class/class_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:alma_web/src/data/repository/list_class/list_class_repository.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class ListClassController extends ChangeNotifier {
  var state = ListClassState.idle;
  List<Class> listClasses = [];

  ListClassRepository repository;
  ListClassController(this.repository) {
    _getListClass();
  }

  Future<void> refresh() async {
    await _getListClass();
  }

  Future<void> _getListClass() async {
    listClasses.clear();
    setState(ListClassState.loading);

    try {
      String token = await SharedPref().read('token');
      ListResponse listClassBlockResp = await repository.getListClasses(token);

      listClassBlockResp.data?.forEach((element) {
        listClasses.add(Class.fromJson(element));
      });

      setState(ListClassState.success);
    } catch (e) {
      setState(ListClassState.error);
      Exception(e.toString());
    }
  }

  Future<void> deleteClass(String id, int index) async {
    setState(ListClassState.loading);

    try {
      String token = await SharedPref().read("token");
      await repository.deleteClass(token, id);

      listClasses.removeAt(index);
      setState(ListClassState.successDelete);
    } catch (e) {
      setState(ListClassState.errorDelete);

      Exception(e.toString());
    }
  }

  void setState(ListClassState state) {
    this.state = state;
    notifyListeners();
  }
}
