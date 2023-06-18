import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:green_grocer/src/auth/components/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  
  final List<FadeAnimatedText> textosAnimados = [
    FadeAnimatedText('Frutas'),
    FadeAnimatedText('Verduras'),
    FadeAnimatedText('Legumes'),
    FadeAnimatedText('Carnes'),
    FadeAnimatedText('Cereais'),
    FadeAnimatedText('Laticíneos'),
  ];

  SignInScreen(
    {Key? key}) : super(key: key
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Nome do app
              const Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 40,
                  ),
                  children: [
                    TextSpan(
                      text: 'Green',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text: 'grocer',
                        style: TextStyle(
                          color: Colors.red,
                        ))
                  ],
                ),
              ),

              // Categorias
              SizedBox(
                height: 30,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: textosAnimados
                  ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email
                const CustomTextField(
                  icon: Icons.email,
                  label: 'Email',
                ),

                // Senha
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
