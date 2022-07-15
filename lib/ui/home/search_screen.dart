import 'dart:convert';

import 'package:carismatic/ResponseModel/MainDataClass.dart';
import 'package:carismatic/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../ResponseModel/get_brand_model_response_model.dart';
import '../../ResponseModel/get_brands_response_MODEL.dart';
import '../../model/search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  GetBrandResponseModel getBrandsResponseModel=GetBrandResponseModel();
  GetBrandModelResponseModel getModel=GetBrandModelResponseModel();
  MainDataClass mainClass=MainDataClass();

  List<SearchModel> Tempmatches = [];
  List<SearchModel> _getSuggestions(String query) {
    List<SearchModel> matches = [];
    matches.addAll(searchData);
    Tempmatches.addAll(searchData);
    matches.retainWhere(
        (data) => data.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  void searchDat(String query) {
     Tempmatches = [];
     Tempmatches.addAll(searchData);
    Tempmatches.addAll(searchData);
     Tempmatches.retainWhere(
        (data) => data.name.toLowerCase().contains(query.toLowerCase()));
  }
  bool select=false;
  @override
  void initState() {
    searchDat("");
    getBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 18.0,right: 18,bottom: 0,top: 18),
                child: CUstomSearchBar(
                    function: () {

                    },
                  onChanged: (val){
                    searchDat(val!);
                    setState(() {

                    });
                  },
                    readOnly: false,
                    hint: "Search here...",
                    validators: (e) {},
                    keyboardTYPE: TextInputType.name, controller: controller,),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount:  getBrandsResponseModel.data!.length,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text( getBrandsResponseModel.data![index].brandName.toString(),style: TextStyle(fontSize: 18),),
                            Container(
                              height: 100,
                              child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: (){
                                      },
                                      child: ListTile(
                                          trailing: Checkbox(onChanged: (bool? value) {  }, value: false,),
                                          title: Text("List item $index")),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Future<void> getBrands() async {
    final uri = Uri.parse("https://carismatic.online/api/common/get_brands");


    http.Response response = await http.get(uri,);
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    getBrandsResponseModel= GetBrandResponseModel.fromJson(res);
    getBrandsModel();

    // if (res.status=="true") {
    //
    // } else {
    // }
    setState(() {

    });
  }

  Future<void> getBrandsModel() async {
    final uri = Uri.parse("https://carismatic.online/api/common/get_all_models");


    http.Response response = await http.get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    getModel= GetBrandModelResponseModel.fromJson(res);
    for(int i=0;i<=getBrandsResponseModel.data!.length;i++){

      for(int k=0;i<=getModel.data!.length;k++){
            if(getModel.data![k].modelId==getBrandsResponseModel.data![i].brandId){

            }
      }
    }
    // if (res.status=="true") {
    //
    // } else {
    // }
    setState(() {

    });
  }

}


class CUstomSearchBar extends StatelessWidget {
  CUstomSearchBar(
      {Key? key,
        required this.controller,
        required this.readOnly,
        required this.hint,
        required this.validators,
        required this.keyboardTYPE,
        required this.function,
        this.maxlength, this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  String hint;
  int? maxlength;
  bool readOnly;
  TextInputType? keyboardTYPE;
  final FormFieldValidator<String> validators;
  final FormFieldValidator<String>? onChanged;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onTap:(){function.call();} ,
        readOnly: readOnly,
        validator: validators,
        onChanged: onChanged,
        maxLength: maxlength,
        cursorColor: PRIMARY_COLOR,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          focusColor: Colors.white,
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
          focusedBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          counterText: "",
          hintStyle: TextStyle(color: PRIMARY_COLOR.withOpacity(0.5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          errorMaxLines: 4,
          hintText: hint,
          labelStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
        keyboardType: keyboardTYPE,
      ),
    );
  }
}
