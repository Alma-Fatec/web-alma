import 'package:alma_web/src/controllers/list_assignment/list_assignment_state.dart';
import 'package:alma_web/src/data/models/assignment/assignment_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:alma_web/src/data/repository/list_assignment/list_assignment_repository.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class ListAssignmentController extends ChangeNotifier {
  var state = ListAssignmentState.idle;

  List<Assignment> listAssignments = [];
  List<Assignment> listAssignmentsAux = [];

  int page = 1;
  bool isLastPage = false;

  ListAssignmentRepository repository;
  ListAssignmentController(this.repository) {
    _getAssignments();
  }

  Future<void> refresh() async {
    await _getAssignments();
  }

  Future<void> _getAssignments() async {
    setState(ListAssignmentState.loading);

    try {
      String token = await SharedPref().read('token');
      ListResponse listAssignmentResp =
          await repository.getListAssignments(token, page);
      setListAssignment(listAssignmentResp);

      setState(ListAssignmentState.success);
    } catch (e) {
      setState(ListAssignmentState.error);

      throw Exception(e.toString());
    }
  }

  Future<void> deleteAssignment(int id) async {
    state = ListAssignmentState.loading;
    notifyListeners();

    try {
      String token = await SharedPref().read("token");
      await repository.deleteAssignment(token, id);

      state = ListAssignmentState.successDelete;
      notifyListeners();
    } catch (e) {
      state = ListAssignmentState.errorDelete;
      notifyListeners();

      throw Exception(e.toString());
    }
  }

  void setListAssignment(ListResponse listAssignmentResp) {
    listAssignments.clear();
    listAssignmentsAux.clear();

    listAssignmentResp.data?.forEach((element) {
      listAssignmentsAux.add(Assignment.fromJson(element));
    });

    listAssignments.addAll(listAssignmentsAux);
  }

  void filterSearchResults(String query) {
    setState(ListAssignmentState.idle);

    List<Assignment> dummySearchList = [];
    dummySearchList.addAll(listAssignmentsAux);

    if (query.isNotEmpty) {
      List<Assignment> dummyListData = [];
      for (Assignment item in dummySearchList) {
        if (item.title!.contains(query)) {
          dummyListData.add(item);
          notifyListeners();
        }
      }
      listAssignments.clear();
      listAssignments.addAll(dummyListData);
      notifyListeners();
      return;
    } else {
      listAssignments.clear();
      listAssignments.addAll(listAssignmentsAux);
      notifyListeners();
    }
  }

  void nextPage() {
    isLastPage = listAssignmentsAux.length < 10;

    if (isLastPage) {
      return;
    }
    page++;
    _getAssignments();
  }

  void backPage() {
    if (page == 1) {
      return;
    }
    page--;
    _getAssignments();
  }

  void setState(ListAssignmentState state) {
    this.state = state;
    notifyListeners();
  }
}
