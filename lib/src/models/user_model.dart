class UserModel {
  String uid;
  String email;
  String username;
  String password;
  String phonenumber;

  UserModel(
      {this.uid, this.email, this.username, this.password, this.phonenumber});

//receiving data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        password: map['password'],
        phonenumber: map['phonenumber'],
        username: map['username']);
  }

//sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'phonenumber': phonenumber,
      'username': username,
    };
  }
}
