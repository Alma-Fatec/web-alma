import 'package:alma_web/src/controllers/dashboard/dashboard_controller.dart';
import 'package:alma_web/src/controllers/dashboard/dashboard_state.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardController controller;

  @override
  void initState() {
    controller = context.read<DashboardController>();

    controller.addListener(() {
      if (controller.state == DashboardState.logoutError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AlmaTextWidget(text: 'Não foi possível fazer o logout!'),
          ),
        );
      } else if (controller.state == DashboardState.logoutSuccess) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.initial, (route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaPageStructure(
      title: 'ALMA',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(Icons.logout),
          ),
        ),
      ],
      child: Column(
        children: [],
      ),
    );
  }
}
