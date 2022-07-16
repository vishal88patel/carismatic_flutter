class MainDataModel {
  String? category;
  List<SubCategory>? subCategory;

  MainDataModel({this.category, this.subCategory});

  MainDataModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['subCategory'] != null) {
      subCategory = <SubCategory>[];
      json['subCategory'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  String? name;
  bool? isFavourite;

  SubCategory({this.name, this.isFavourite});

  SubCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isFavourite'] = this.isFavourite;
    return data;
  }
}
