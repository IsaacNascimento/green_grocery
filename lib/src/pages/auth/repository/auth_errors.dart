String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou Senha inválidos';
    case 'Invalid session token':
      return 'Sua sessão foi expirada';
    default:
      return 'Ocorreu algum erro indefinido';
  }
}
