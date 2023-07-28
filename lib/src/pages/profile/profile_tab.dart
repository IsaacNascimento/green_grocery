import 'package:flutter/material.dart';
import 'package:green_grocer/src/pages/widgets/custom_text_field.dart';
import 'package:green_grocer/src/config/app_data.dart' as app_data;

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // Email
          CustomTextField(
            icon: Icons.email,
            label: 'Email',
            initialValue: app_data.user.email,
            readOnly: true,
          ),

          // Nome
          CustomTextField(
            icon: Icons.person,
            label: 'Nome',
            initialValue: app_data.user.name,
            readOnly: true,
          ),

          // Celular
          CustomTextField(
            icon: Icons.phone,
            label: 'Celular',
            initialValue: app_data.user.phone,
            readOnly: true,
          ),

          // CPF
          CustomTextField(
            icon: Icons.file_copy,
            label: 'CPF',
            isPasswordField: true,
            initialValue: app_data.user.cpf,
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
              onPressed: () {},
              child: const Text('Atualizar Senha'),
            ),
          ),
        ],
      ),
    );
  }
}
