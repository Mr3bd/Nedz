class AutisticPatient {
  int? id;
  String? careGiverId;
  String? name;
  String? phone;
  String? date;

  AutisticPatient(
      {this.id, this.careGiverId, this.name, this.phone, this.date});

  AutisticPatient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    careGiverId = json['careGiverId'];
    name = json['name'];
    phone = json['email'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['careGiverId'] = this.careGiverId;
    data['name'] = this.name;
    data['email'] = this.phone;
    data['date'] = this.date;
    return data;
  }
}
