class User {
  String uid;
  String name;
  String email;
  String phoneNo;

  // Constructor
  User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phoneNo});

  // Factory method to create a User instance from a Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phone no'] ?? '',
    );
  }

  // Convert the User instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone no': phoneNo,
    };
  }
}
