class UserModel {
  String email;
  String? password;
  String? name;
  String? phone;
  String? cpf;
  String? id;
  String? token;

  UserModel({
    required this.email,
    this.password,
    this.name,
    this.phone,
    this.cpf,
    this.id,
    this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      cpf: map['cpf'],
      name: map['fullname'],
      phone: map['phone'],
      id: map['id'],
      token: map['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'cpf': cpf,
      'name': name,
      'phone': phone,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'name: $name | cpf: $cpf';
  }
}
