import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/auth/controller/auth_controller.dart';
import 'package:green_grocer/src/pages/widgets/custom_text_field.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/services/mask_formatters.dart';
import 'package:green_grocer/src/services/validators.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              // Content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),

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
                        )),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                            onSaved: (email) {
                              authController.currentUser.email = email!;
                              // print(email);
                            },
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            isPasswordField: true,
                            validator: passwordValidator,
                            onSaved: (password) {
                              authController.currentUser.password = password!;
                              // print(password);
                            },
                          ),
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            validator: nameValidator,
                            onSaved: (name) {
                              authController.currentUser.name = name!;
                              // print(name);
                            },
                          ),
                          CustomTextField(
                            inputFormatters: [phoneFormatter],
                            icon: Icons.phone,
                            label: 'Celular',
                            keyboardType: TextInputType.phone,
                            validator: phoneValidator,
                            onSaved: (phone) {
                              authController.currentUser.phone = phone!;
                              // print(phone);
                            },
                          ),
                          CustomTextField(
                            inputFormatters: [cpfFormatter],
                            icon: Icons.file_copy,
                            label: 'CPF',
                            keyboardType: TextInputType.number,
                            validator: cpfValidator,
                            onSaved: (cpf) {
                              authController.currentUser.cpf = cpf!;
                              // print(cpf);
                            },
                          ),
                          SizedBox(
                            height: 50,
                            child: Obx(() {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: authController.isFetching.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          authController.signUp();

                                          // print(authController.user);
                                        }
                                      },
                                child: authController.isFetching.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Cadastrar usuário',
                                        style: TextStyle(fontSize: 18),
                                      ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Botão Voltar
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => {Get.back()},
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
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
