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

  Future<void> _getAssignments() async {
    state = ListAssignmentState.loading;
    notifyListeners();

    try {
      listAssignments.clear();
      String token = await SharedPref().read('token');
      ListResponse listClassBlockResp =
          await repository.getListAssignments(token);

      if (listAssignments.isEmpty) {
        listClassBlockResp.data?.forEach((element) {
          listAssignments.add(Assignment.fromJson(element));
        });
      }

      state = ListAssignmentState.success;
      notifyListeners();
    } catch (e) {
      state = ListAssignmentState.error;
      notifyListeners();

      throw Exception(e.toString());
    }
  }

  Future<void> deleteAssignment(String id) async {
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
}
