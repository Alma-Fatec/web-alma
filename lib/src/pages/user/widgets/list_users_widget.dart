import 'package:alma_web/src/controllers/user/user_controller.dart';
import 'package:alma_web/src/controllers/user/user_state.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUsersWidget extends StatelessWidget {
  const ListUsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();

    if (controller.state == UserState.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: const Center(
          child: CircularProgressIndicator(
            color: AlmaTheme.primaryColor,
          ),
        ),
      );
    } else if (controller.users.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: const Center(
          child: AlmaText(
            text: 'Nenhum item encontrado na lista',
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.users.length,
        itemBuilder: (context, index) => Card(
          color: AlmaTheme.greyAlmaColor,
          child: ListTile(
            title: AlmaText(
              text: controller.users[index].name!,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle: AlmaText(
              text: controller.users[index].email!,
              fontWeight: FontWeight.w600,
            ),
            trailing: const Icon(Icons.arrow_right_outlined)
          ),
        ),
      );
    }
  }
}
