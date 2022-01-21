class User{
  String? email;
  String? userName;
  String? password;

  User({this.email, this.userName, this.password});

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        userName = json['username'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username' : userName
  };
}