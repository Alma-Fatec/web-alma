import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(200)),
          child: Image.asset('assets/images/background-sidebar.png'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset('assets/images/logo_alma.png'),
            const SizedBox(height: 30),
            const AlmaText(
              text: 'ALMA WEB',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AlmaTheme.primaryColor,
            ),
            const AlmaText(
              text: 'Alfabetização Móvel para Adultos',
              fontWeight: FontWeight.bold,
              color: AlmaTheme.primaryColor,
            )
          ],
        ),
      ],
    );
  }
}
