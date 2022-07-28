class CategoryItem {
  int? apId;
  String? iconPath;
  int? type;
  String? realName;
  String? nickName;

  CategoryItem(
      {this.apId,
      this.iconPath,
      this.type,
      this.realName,
      this.nickName});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    apId = json['apId'];
    iconPath = json['iconPath'];
    type = json['type'];
    realName = json['realName'];
    nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apId'] = this.apId;
    data['iconPath'] = this.iconPath;
    data['type'] = this.type;
    data['realName'] = this.realName;
    data['nickName'] = this.nickName;
    return data;
  }
}
