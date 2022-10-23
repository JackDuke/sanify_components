class User {
  final int id;
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String role;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        fname = json['fname'] ?? '',
        lname = json['lname'] ?? '',
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        role = json['role'] ?? '';
}
