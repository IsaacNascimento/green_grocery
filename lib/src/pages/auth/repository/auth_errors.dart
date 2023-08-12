String authErrorsString(String? code) {
  // print('code $code');
  switch (code) {
    // SIGN IN ERRORS
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou Senha inválidos';

    // VALIDATE TOKEN ERRORS
    case 'Invalid session token':
      return 'Sua sessão foi expirada';

    // SIGN UP ERRORS
    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuário: Nome inválido';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar usuário: Celular inválido';

    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar usuário: CPF inválido';

    // Account exists ERROR
    case 'Account already exists for this username.':
      return 'Conta já cadastrada com esse usuário';

    // RESET PASSWORD ERRORS
    case 'you must provide an email':
      return 'Digite seu email!';

    default:
      return 'Ocorreu algum erro indefinido';
  }
}
