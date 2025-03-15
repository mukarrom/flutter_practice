import 'package:basic_test/data/models/login_model.dart';

class LoginResponseModel {
  int? code;
  String? status;
  String? msg;
  LoginModel? data;

  LoginResponseModel({this.code, this.status, this.msg, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? LoginModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
