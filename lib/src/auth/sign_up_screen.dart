import 'package:flutter/material.dart';
import 'package:green_grocer/src/config/custom_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: Column(
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
              )
            ),
          ),
        ],
      ),
    );
  }
}
