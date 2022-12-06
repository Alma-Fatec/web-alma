import 'package:alma_web/src/controllers/list_assignment/list_assignment_state.dart';
import 'package:alma_web/src/data/models/assignment/assignment_model.dart';
import 'package:alma_web/src/data/models/list_response/list_response_model.dart';
import 'package:alma_web/src/data/repository/list_assignment/list_assignment_repository.dart';
import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class ListAssignmentController extends ChangeNotifier {
  var state = ListAssignmentState.idle;

  List<Assignment> listAssignments = [];

  ListAssignmentRepository repository;
  ListAssignmentController(this.repository) {
    _getAssignments();
  }

  Future<void> refresh() async {
    await _getAssignments();
  }

  Future<void> _getAssignments() async {
    listAssignments.clear();
    setState(ListAssignmentState.loading);

    try {
      String token = await SharedPref().read('token');
      ListResponse listClassBlockResp =
          await repository.getListAssignments(token);

      listClassBlockResp.data?.forEach((element) {
        listAssignments.add(Assignment.fromJson(element));
      });

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

  void setState(ListAssignmentState state) {
    this.state = state;
    notifyListeners();
  }
}
