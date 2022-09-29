class User {
  late String userName;
  late String userId;
  late String email;
  //dob
  //verified
  //donor

  User({required this.userName, required this.userId, required this.email});

  User.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userId = json['user_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    return data;
  }
}
