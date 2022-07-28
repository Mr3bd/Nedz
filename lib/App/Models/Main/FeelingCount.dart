class FeelingCount {
  int? apId;
  String? feelingName;
  int? counts;

  FeelingCount({this.apId, this.feelingName, this.counts});

  FeelingCount.fromJson(Map<String, dynamic> json) {
    apId = json['apId'];
    feelingName = json['feelingName'];
    counts = json['counts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apId'] = this.apId;
    data['feelingName'] = this.feelingName;
    data['counts'] = this.counts;
    return data;
  }
}
