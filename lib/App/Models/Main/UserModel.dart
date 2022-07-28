class UserModel {
  String? userID;
  String? name;
  String? email;

  UserModel(
      {this.userID, this.name, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
