import 'package:enum_to_string/enum_to_string.dart';

enum Role { admin, user, org }

class User {
  late String userId;
  late String email;
  late String dob;
  late String name;
  late bool verified;
  late Role role;

  User({
    required this.userId,
    required this.email,
    required this.dob,
    required this.name,
    this.verified = false,
    this.role = Role.user,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    email = json['email'];
    dob = json['dob'];
    verified = json['verified'];
    role = EnumToString.fromString(Role.values, json['role'])!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['verified'] = this.verified;
    data['role'] = EnumToString.convertToString(this.role);
    return data;
  }
}
