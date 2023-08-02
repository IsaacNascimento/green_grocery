class UserModel {
  String email;
  String password;
  String? name;
  String? phone;
  String? cpf;

  UserModel({
    required this.email,
    required this.password,
    this.name,
    this.phone,
    this.cpf,
  });
}
