import 'package:alma_web/src/controllers/register/register_controller.dart';
import 'package:alma_web/src/controllers/register/register_state.dart';
import 'package:alma_web/src/pages/register/widgets/check_button_terms.dart';
import 'package:alma_web/src/pages/register/widgets/register_button.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/utils/snackbar.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:alma_web/src/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterController controller;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlName = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlPhone = TextEditingController();
  final TextEditingController _ctrlCpf = TextEditingController();

  @override
  void initState() {
    controller = context.read<RegisterController>();

    controller.addListener(() {
      if (controller.state == RegisterState.error) {
        showSnackBar(context, 'Erro na tentativa de cadastrar usuário!');
      } else if (controller.state == RegisterState.success) {
        showSnackBar(
          context,
          "Usuário cadastrado com sucesso!",
          action: SnackBarAction(
            onPressed: () => Navigator.pop(context),
            label: "Clique aqui para fazer o login!",
          ),
        );
        clearFields();
      } else if (controller.state == RegisterState.formWarnings) {
        showSnackBar(context, controller.message!);
      }
    });
    super.initState();
  }

  void clearFields() {
    _ctrlName.clear();
    _ctrlEmail.clear();
    _ctrlPassword.clear();
    _ctrlPhone.clear();
    _ctrlCpf.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlmaTheme.actionColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            width: 630,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AlmaText(
                    text: 'CADASTRE-SE',
                    fontWeight: FontWeight.w600,
                    fontSize: 44,
                  ),
                  const SizedBox(height: 40),
                  AlmaTextField(
                    controller: _ctrlName,
                    onChanged: (value) => controller.name = value,
                    label: "Nome",
                    hintText: "Digite o seu nome",
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: AlmaTextField(
                          controller: _ctrlCpf,
                          onChanged: (value) => controller.cpf = value,
                          label: "CPF",
                          hintText: "XXX.XXX.XXX-XX",
                          maxLength: 14,
                          inputFormatters: [
                            MaskTextInputFormatter(mask: '###.###.###-##')
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: AlmaTextField(
                          controller: _ctrlPhone,
                          onChanged: (value) => controller.phone = value,
                          label: "Telefone",
                          maxLength: 15,
                          hintText: "(DDD) XXXXX-XXXX",
                          inputFormatters: [
                            MaskTextInputFormatter(mask: '(##) #####-####')
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: AlmaTextField(
                          controller: _ctrlEmail,
                          onChanged: (value) => controller.email = value,
                          label: "E-mail",
                          hintText: "exemplo@email.com",
                        ),
                      ),
                      Consumer<RegisterController>(
                        builder: (context, control, child) => SizedBox(
                          width: 300,
                          child: AlmaTextField(
                            obscureText: control.obscurePassword,
                            controller: _ctrlPassword,
                            label: "Senha",
                            onChanged: (value) => control.password = value,
                            hintText: "*********",
                            suffixIcon: IconButton(
                              onPressed: () => control.seePasswordAction(),
                              icon: const Icon(Icons.lock,
                                  color: AlmaTheme.actionColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CheckButtonTerms(),
                  const SizedBox(height: 30),
                  const RegisterButton(),
                ],
              ),
            ),
          ),
          const Spacer(),
          const SidebarWidget(),
        ],
      ),
    );
  }
}
