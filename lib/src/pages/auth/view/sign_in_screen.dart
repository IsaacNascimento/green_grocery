import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/controller/auth_controller.dart';
import 'package:green_grocer/src/pages/widgets/app_name_widget.dart';
import 'package:green_grocer/src/pages/widgets/custom_text_field.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/routes/app_pages.dart';

class SignInScreen extends StatelessWidget {
  final List<FadeAnimatedText> textosAnimados = [
    FadeAnimatedText('Frutas'),
    FadeAnimatedText('Verduras'),
    FadeAnimatedText('Legumes'),
    FadeAnimatedText('Carnes'),
    FadeAnimatedText('Cereais'),
    FadeAnimatedText('Laticíneos'),
  ];

  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nome do app
                  const AppNameWidget(
                    greenTitleColor: Colors.white,
                    textSize: 40,
                  ),
                  // Categorias
                  SizedBox(
                    height: 30,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: textosAnimados),
                    ),
                  ),
                ],
              )),

              // Formulario
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email
                      CustomTextField(
                        icon: Icons.email,
                        label: 'Email',
                        controller: emailController,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Digite seu email!';
                          }
                          if (!email.isEmail) return 'Digite um email válido';
                          return null;
                        },
                      ),

                      // Senha
                      CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha',
                        isPasswordField: true,
                        controller: passwordController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Digite sua senha!';
                          }

                          if (password.length < 7) {
                            return 'Digite uma senha com pelo menos 7 caracteres';
                          }

                          return null;
                        },
                      ),

                      // Botão Entrar
                      SizedBox(
                          height: 50,
                          child: GetX<AuthController>(
                            builder: (authController) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                )),
                                onPressed: authController.isFetching.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          String email = emailController.text;
                                          String password =
                                              passwordController.text;
                                          final UserModel user = UserModel(
                                              email: email, password: password);
                                          authController.signIn(user);
                                          Get.offNamed(PagesRoutes.baseRoute);
                                        }
                                      },
                                child: authController.isFetching.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Entrar",
                                        style: TextStyle(fontSize: 18),
                                      ),
                              );
                            },
                          )),

                      // Botão Esqueceu a senha
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => {},
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                  color: CustomColors.customContrastColor),
                            ),
                          ),
                        ),
                      ),

                      // Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botão de novo usuário
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.green,
                              )),
                          onPressed: () =>
                              {Get.toNamed(PagesRoutes.signUpRoute)},
                          child: const Text(
                            'Criar Conta',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
