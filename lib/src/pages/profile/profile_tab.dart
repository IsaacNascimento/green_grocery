import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/widgets/custom_text_field.dart';
import 'package:green_grocer/src/pages/auth/controller/auth_controller.dart';
import 'package:green_grocer/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();
  final getCurrentUser =
      Get.find<AuthController>().validateToken(navigateToBase: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return controller.isLoadingUser
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                children: [
                  // Email
                  CustomTextField(
                    icon: Icons.email,
                    label: 'Email',
                    initialValue: controller.currentUser.email,
                    readOnly: true,
                  ),

                  // Nome
                  CustomTextField(
                    icon: Icons.person,
                    label: 'Nome',
                    initialValue: controller.currentUser.name,
                    readOnly: true,
                  ),

                  // Celular
                  CustomTextField(
                    icon: Icons.phone,
                    label: 'Celular',
                    initialValue: controller.currentUser.phone,
                    readOnly: true,
                  ),

                  // CPF
                  CustomTextField(
                    icon: Icons.file_copy,
                    label: 'CPF',
                    isPasswordField: true,
                    initialValue: controller.currentUser.cpf,
                    readOnly: true,
                  ),

                  // Botão para atualizar a senha
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.green,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        updatePassword();
                      },
                      child: const Text('Atualizar Senha'),
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Future<bool?> updatePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Título
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualização de Senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Senha Atual
                      CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha Atual',
                        isPasswordField: true,
                        validator: passwordValidator,
                        controller: currentPasswordController,
                      ),

                      // Nova Senha
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Nova Senha',
                        isPasswordField: true,
                        validator: passwordValidator,
                        controller: newPasswordController,
                      ),

                      // Confirmação Nova Senha
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Confirmar Nova Senha',
                        isPasswordField: true,
                        validator: (password) {
                          final result = passwordValidator(password);
                          if (result != null) {
                            return result;
                          }

                          if (password != newPasswordController.text) {
                            return 'As senhas devem ser iguais!';
                          }

                          return null;
                        },
                      ),

                      // Botão de Confirmação
                      SizedBox(
                        height: 45,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: authController.isFetching.value
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      authController.changePassword(
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      );
                                    }
                                    // Get.back();
                                  },
                            child: authController.isFetching.value
                                ? const CircularProgressIndicator()
                                : const Text('Atualizar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
