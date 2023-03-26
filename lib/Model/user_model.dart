class User {
  String? userid;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? role;
  String? status;
  bool? allow;

  User(
      {this.userid,
        this.name,
        this.email,
        this.phone,
        this.password,
        this.role,
        this.status,
        this.allow,
      });

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    status = json['status'];
    allow = json['allow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['role'] = this.role;
    data['status'] = this.status;
    data['allow'] = this.allow;
    return data;
  }
}
