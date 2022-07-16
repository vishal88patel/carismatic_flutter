class GetProfileRESPONSEmODEL {
  String? status;
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobile;
  String? dob;
  String? userType;

  GetProfileRESPONSEmODEL(
      {this.status,
        this.userId,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.mobile,
        this.dob,
        this.userType});

  GetProfileRESPONSEmODEL.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['user_type'] = this.userType;
    return data;
  }
}
