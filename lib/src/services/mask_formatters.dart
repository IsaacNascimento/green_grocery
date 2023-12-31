import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final cpfFormatter = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {'#': RegExp(r'[0-9]')},
);

final phoneFormatter = MaskTextInputFormatter(
  mask: '(##) #####-####',
  filter: {'#': RegExp(r'[0-9]')},
);
