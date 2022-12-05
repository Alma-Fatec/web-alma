import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:alma_web/src/widgets/side_menu_widget.dart';
import 'package:flutter/material.dart';

class AlmaPageStructure extends StatelessWidget {
  const AlmaPageStructure(
      {super.key, required this.title, required this.child, this.actions, this.floatingActionButon});

  final String title;
  final Widget child;
  final Widget? floatingActionButon;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/images/logo_alma.png',
            fit: BoxFit.cover,
          ),
        ),
        leadingWidth: 110,
        title: AlmaText(text: title),
        actions: actions
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SideMenuWidget(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(child: child),
            ),
          )
        ],
      ),
      floatingActionButton: floatingActionButon,
    );
  }
}
