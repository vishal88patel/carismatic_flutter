class GetUserCars {
  String? status;
  List<UserCarData>? data;

  GetUserCars({this.status, this.data});

  GetUserCars.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UserCarData>[];
      json['data'].forEach((v) {
        data!.add(new UserCarData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCarData {
  String? brandName;
  String? modelName;

  UserCarData({this.brandName, this.modelName});

  UserCarData.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    modelName = json['model_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['model_name'] = this.modelName;
    return data;
  }
}
