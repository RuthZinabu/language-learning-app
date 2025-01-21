// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? id;
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String? currentLanguage;
  final String? targetLanguage;

  UserModel(
      {this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.password,
      required this.currentLanguage,
      required this.targetLanguage});

  toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'currentLanguage': currentLanguage,
      'targetLanguage': targetLanguage,
    };
  }

  // Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      password: json['password'] ?? "",
      currentLanguage: json['currentLanguage'],
      targetLanguage: json['targetLanguage'],
    );
  }
}
