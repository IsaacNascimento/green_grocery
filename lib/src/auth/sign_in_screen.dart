import 'package:flutter/material.dart';
import 'package:green_grocer/src/auth/components/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          Expanded(
            child: Container(color: Colors.red),
          ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //email
                const CustomTextField(
                  icon: Icons.email,
                  label: 'Email',
                ),

                // senha
                const CustomTextField(
                  icon: Icons.lock,
                  label: 'Senha',
                  isPasswordField: true,
                ),

                // Botão Entrar
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                      onPressed: () => {},
                      child: const Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18),
                      )),
                ),

                // Botão Esqueceu a senha
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => {},
                      child: const Text(
                        'Esqueceu a senha?',
                        style: TextStyle(color: Colors.red),
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
                    onPressed: () => {},
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
