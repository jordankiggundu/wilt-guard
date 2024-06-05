class UserModel {

  final String? email;
  final String? username;
  final String? password;

  UserModel({this.email,this.username,this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      username: json['username'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password
    };
  }
}