class User {
  int? userId;
  String? userFullname;
  String? userName;
  String? userPassword;
  String? userImage;

  User(
      {this.userId,
      this.userFullname,
      this.userName,
      this.userPassword,
      this.userImage});

  //JSON Data -> Data
  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userFullname = json['userFullname'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
  }

  //Data -> JSON Data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userFullname'] = userFullname;
    data['userName'] = userName;
    data['userPassword'] = userPassword;
    data['userImage'] = userImage;
    return data;
  }
}
