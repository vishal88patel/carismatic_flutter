class GetBrandModelResponseModel {
  String? status;
  List<Data1>? data;

  GetBrandModelResponseModel({this.status, this.data});

  GetBrandModelResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data1>[];
      json['data'].forEach((v) {
        data!.add(new Data1.fromJson(v));
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

class Data1 {
  String? modelId;
  String? brandId;
  String? modelName;
  bool? ischceck;

  Data1({this.modelId, this.brandId, this.modelName});

  Data1.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    brandId = json['brand_id'];
    modelName = json['model_name'];
    ischceck = json['is_chceck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['brand_id'] = this.brandId;
    data['model_name'] = this.modelName;
    data['is_chceck'] = this.ischceck;
    return data;
  }
}
