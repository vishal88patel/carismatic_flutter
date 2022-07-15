class MainDataClass {
  String? category;
  List<String>? subCategory;

  MainDataClass({this.category, this.subCategory});

  MainDataClass.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    subCategory = json['subCategory'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['subCategory'] = this.subCategory;
    return data;
  }
}
