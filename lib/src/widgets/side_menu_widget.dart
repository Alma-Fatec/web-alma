import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenuWidget extends StatelessWidget {
  const SideMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: AlmaTheme.actionColor,
      child: Column(
          children: [
            const SizedBox(height: 10),
            ListTile(
              title: Column(
                children: const [
                  Icon(CupertinoIcons.home,
                  size: 30, color: Colors.white),
                  AlmaTextWidget(text: 'Home', fontSize: 12, color: Colors.white),
                ],
              ),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.dashboard, result: true),
            ),
            const SizedBox(height: 5),
            ListTile(
              title: Column(
                children: const [
                  Icon(Icons.my_library_books_outlined,
                  size: 30, color: Colors.white),
                  AlmaTextWidget(
                      text: 'Blocos', fontSize: 12, color: Colors.white),
                ],
              ),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.listBlocks, result: true),
            ),
            const SizedBox(height: 5),
            ListTile(
              title: Column(
                children: const [
                  Icon(CupertinoIcons.calendar,
                  size: 30, color: Colors.white),
                  AlmaTextWidget(
                      text: 'Aulas', fontSize: 12, color: Colors.white),
                ],
              ),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.listClasses, result: true),
            ),
            const SizedBox(height: 5),
            ListTile(
              title: Column(
                children: const [
                  Icon(CupertinoIcons.book,
                  size: 30, color: Colors.white),
                  AlmaTextWidget(
                      text: 'Atividades', fontSize: 12, color: Colors.white),
                ],
              ),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.listAssignments, result: true),
            ),
            const SizedBox(height: 5),
            ListTile(
              title: Column(
                children: const [
                  Icon(Icons.school_outlined,
                  size: 30, color: Colors.white),
                  AlmaTextWidget(
                      text: 'Alunos', fontSize: 12, color: Colors.white),
                ],
              ),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.listUsers, result: true),
            ),
            const SizedBox(height: 5),
            ListTile(
              title: Column(
                children: const [
                  Icon(CupertinoIcons.person_crop_circle,
                  size: 30, color: Colors.white),
                  AlmaTextWidget(
                      text: 'Perfil', fontSize: 12, color: Colors.white),
                ],
              ),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.profile, result: true),
            ),

            // TODO PreTEST PosTEST
            /* const SizedBox(height: 5),
            ListTile(
              title: Column(
                children: const [
                  Icon(Icons.content_paste_search_rounded,
                  size: 30, color: Colors.white),
                  AlmaTextWidget(
                      text: 'Pré-teste', fontSize: 12, color: Colors.white),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 5),
            ListTile(
              title: Column(
                children: const [
                  Icon(Icons.content_paste_go_rounded,
                  size: 30, color: Colors.white),
                  AlmaTextWidget(
                      text: 'Pós-teste', fontSize: 12, color: Colors.white),
                ],
              ),
              onTap: () {},
            ), */
          ],
        ),
    );
  }
}