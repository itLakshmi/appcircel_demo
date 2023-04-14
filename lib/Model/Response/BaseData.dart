/// name : ""
/// age : "3"

class BaseData {
  int? status;
  String? message;
  String? error;

  BaseData({this.status, this.message, this.error});

  BaseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    message = json['error'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}