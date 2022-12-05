import 'package:alma_web/src/controllers/dashboard/dashboard_state.dart';
// import 'package:alma_web/src/utils/shared_pref.dart';
import 'package:flutter/widgets.dart';

class DashboardController extends ChangeNotifier {
  var state = DashboardState.idle;

  Future<void> logout() async {
    try {
     /*  if (!await SharedPref().remove('user')) {
        setState(DashboardState.logoutError);
        return;
      } */

      setState(DashboardState.logoutSuccess);
    } catch (e) {
      Exception(e.toString());
      setState(DashboardState.logoutError);
    }
  }

  void setState(DashboardState state) {
    this.state = state;
    notifyListeners();
  }
}
