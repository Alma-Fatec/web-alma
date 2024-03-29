import 'package:alma_web/src/controllers/assignment/assignment_controller.dart';
import 'package:alma_web/src/controllers/auth/auth_controller.dart';
import 'package:alma_web/src/controllers/class/class_controller.dart';
import 'package:alma_web/src/controllers/class_block/class_block_controller.dart';
import 'package:alma_web/src/controllers/dashboard/dashboard_controller.dart';
import 'package:alma_web/src/controllers/list_assignment/list_assignment_controller.dart';
import 'package:alma_web/src/controllers/list_class/list_class_controller.dart';
import 'package:alma_web/src/controllers/list_class_block/list_class_block_controller.dart';
import 'package:alma_web/src/controllers/profile/profile_controller.dart';
import 'package:alma_web/src/controllers/register/register_controller.dart';
import 'package:alma_web/src/controllers/user/user_controller.dart';
import 'package:alma_web/src/data/api/client_http.dart';
import 'package:alma_web/src/data/api/interceptors.dart';
import 'package:alma_web/src/data/models/auth/auth_model.dart';
import 'package:alma_web/src/data/repository/assignment/assignment_repository.dart';
import 'package:alma_web/src/data/repository/auth/auth_repository.dart';
import 'package:alma_web/src/data/repository/class/class_repository.dart';
import 'package:alma_web/src/data/repository/class_block/class_block_repository.dart';
import 'package:alma_web/src/data/repository/list_assignment/list_assignment_repository.dart';
import 'package:alma_web/src/data/repository/list_class/list_class_repository.dart';
import 'package:alma_web/src/data/repository/list_class_block/list_class_block_repository.dart';
import 'package:alma_web/src/data/repository/register/register_repository.dart';
import 'package:alma_web/src/data/repository/user/user_repository.dart';
import 'package:alma_web/src/pages/assignment/assignment_page.dart';
import 'package:alma_web/src/pages/auth/auth_page.dart';
import 'package:alma_web/src/pages/class/class_page.dart';
import 'package:alma_web/src/pages/class_block/class_block_page.dart';
import 'package:alma_web/src/pages/dashboard/dashboard_page.dart';
import 'package:alma_web/src/pages/list_assignment/list_assignment_page.dart';
import 'package:alma_web/src/pages/list_assignment/widgets/detail_assignment.dart';
import 'package:alma_web/src/pages/list_class/list_class_page.dart';
import 'package:alma_web/src/pages/list_class/widgets/detail_class.dart';
import 'package:alma_web/src/pages/list_class_block/list_class_block_page.dart';
import 'package:alma_web/src/pages/list_class_block/widgets/detail_class_block.dart';
import 'package:alma_web/src/pages/profile/profile_page.dart';
import 'package:alma_web/src/pages/register/register_page.dart';
import 'package:alma_web/src/pages/user/list_users_page.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/utils/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'src/data/models/list_response/list_response_model.dart';
import 'src/data/models/user/user_model.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final client = HttpClient(
      Dio()..interceptors.add(CustomInterceptors()),
      baseUrl: "${dotenv.env['BASE_URL']}",
    );

    return MultiProvider(
      providers: [
        // Auth injects
        Provider(create: (_) => AuthRepository(Auth(), client)),
        ChangeNotifierProvider(create: (context) => AuthController(context.read<AuthRepository>())),

        // Register injects
        Provider(create: (_) => RegisterRepository(User(), client)),
        ChangeNotifierProvider(create: (context) => RegisterController(context.read<RegisterRepository>())),

        // Dashboard Injects
        ChangeNotifierProvider(create: (context) => DashboardController()),

        // List blocks injects
        Provider(create: (_) => ListClassBlockRepository(ListResponse(), client)),
        ChangeNotifierProvider(create: (context) => ListClassBlockController(context.read<ListClassBlockRepository>())),

        // Class blocks injects
        Provider(create: (_) => FilePickerUtil()),
        Provider(create: (_) => ClassBlockRepository(client)),
        ChangeNotifierProvider(
          create: (context) => ClassBlockController(
            context.read<FilePickerUtil>(),
            context.read<ClassBlockRepository>(),
          ),
        ),

        // List assignment injects
        Provider(create: (_) => ListAssignmentRepository(ListResponse(), client)),
        ChangeNotifierProvider(create: (context) => ListAssignmentController(context.read<ListAssignmentRepository>())),

        // Assignment injects
        Provider(create: (_) => FilePickerUtil()),
        Provider(create: (_) => AssignmentRepository(client, ListResponse())),
        ChangeNotifierProvider(
          create: (context) => AssignmentController(
            context.read<AssignmentRepository>(),
            context.read<FilePickerUtil>(),
          ),
        ),

        // List classes injects
        Provider(create: (_) => ListClassRepository(ListResponse(), client)),
        ChangeNotifierProvider(create: (context) => ListClassController(context.read<ListClassRepository>())),

        // Class injects
        Provider(create: (_) => FilePickerUtil()),
        Provider(create: (_) => ClassRepository(client)),
        ChangeNotifierProvider(
          create: (context) => ClassController(
            context.read<ClassRepository>(),
            context.read<FilePickerUtil>(),
          ),
        ),

        // Profile injects
        ChangeNotifierProvider(create: (context) => ProfileController(User())),

        // List users injects
        Provider(create: (_) => UserRepository(client)),
        ChangeNotifierProvider(create: (context) => UserController(context.read<UserRepository>())),
      ],
      child: MaterialApp(
        title: 'ALMA Web',
        theme: AlmaTheme.themeData,
        initialRoute: Routes.initial,
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.initial: (context) => const AuthPage(),
          Routes.register: (context) => const RegisterPage(),
          Routes.dashboard: (context) => const DashboardPage(),
          Routes.listBlocks: (context) => const ListClassBlockPage(),
          Routes.newBlock: (context) => const ClassBlockPage(),
          Routes.listAssignments: (context) => const ListAssignmentPage(),
          Routes.newAssignment: (context) => const AssignmentPage(),
          Routes.listClasses: (context) => const ListClassPage(),
          Routes.classes: (context) => const ClassPage(),
          Routes.profile: (context) => const ProfilePage(),
          Routes.listUsers: (context) => const ListUsersPage(),
          Routes.detailAssignment: (context) => const DetailAssignment(),
          Routes.detailClass: (context) => const DetailClass(), 
          Routes.detailClassBlock: (context) => const DetailClassBlock(), 
        },
      ),
    );
  }
}
