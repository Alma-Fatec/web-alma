import 'package:alma_web/src/controllers/dashboard/dashboard_controller.dart';
import 'package:alma_web/src/controllers/dashboard/dashboard_state.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/utils/snackbar.dart';
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
        showSnackBar(context, 'Não foi possível fazer o logout!');
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AlmaText(
            text: 'Seja bem-vindo professor(a)',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          AlmaText(text: '''Você esta na tela HOME, onde pode encontrar uma breve introdução do sistema e quaisquer novidades futuras. Vamos entender a estrutura de um módulo de aula para sua respectiva criação.'''),
          SizedBox(height: 10),
          AlmaText(
            text: 'Bloco de aulas',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          AlmaText(text: '''Tudo começa formando um bloco de aulas, na página BLOCOS, que nada mais é que um conjunto de aulas para uma determinada lição, dentro de um bloco de aulas podemos passar uma ou mais aulas sobre o assunto.'''),
          SizedBox(height: 10),
          AlmaText(
            text: 'Aulas',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          AlmaText(text: '''Na página AULAS podemos criar aulas que posteriormente podem ser incluídas em um bloco de aulas.'''),
          SizedBox(height: 10),
          AlmaText(
            text: 'Atividades',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          AlmaText(text: '''Na página de ATIVIDADES podemos criar atividades de vários tipos que podem ser incluídas nas aulas para testar os alunos.'''),
          SizedBox(height: 20),
          AlmaText(text: '''Em resumo, a estrutura se da por um conjunto de aulas acopladas em um bloco de aulas, isso garante que o tema de uma lição possa ter várias aulas em comum. Essas aulas podem ou não conter uma atividade para testar o progresso do aluno.'''),
        ],
      ),
    );
  }
}

/*
  static const String instructions = ''' 
  
  Seja bem-vindo professor(a)

Você esta na tela HOME, onde pode encontrar uma breve introdução do sistema e quaisquer novidades futuras.
Vamos entender a estrutura de um módulo de aula para sua respectiva criação.

Bloco de aulas
Tudo começa formando um bloco de aulas, na página BLOCOS, que nada mais é que um conjunto de aulas para uma determinada lição, dentro de um bloco de aulas podemos passar uma ou mais aulas sobre o assunto.

Aulas
Na página AULAS podemos criar aulas que posteriormente podem ser incluídas em um bloco de aulas.

Atividades
Na página de ATIVIDADES podemos criar atividades de vários tipos que podem ser incluídas nas aulas para testar os alunos.

Em resumo, a estrutura se da por um conjunto de aulas acopladas em um bloco de aulas, isso garante que o tema de uma lição possa ter várias aulas em comum. Essas aulas podem ou não conter uma atividade para testar o progresso do aluno.''';
}

*/
