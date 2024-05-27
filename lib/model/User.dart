class UserModel {
  int userID;
  String username;
  String email;
  String password;
  String address;

  UserModel(
      {required this.userID,
      required this.username,
      required this.email,
      required this.password,
      required this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userID: int.parse(json['userID']),
        username: json['username'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        address: json['address'] as String);
  }

  Map<String, dynamic> toJson() => {
        'userID': userID.toString(),
        'username': username,
        'email': email,
        'password': password,
        'address': address,
      };
}
