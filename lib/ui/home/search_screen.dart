import 'dart:convert';

import 'package:carismatic/ResponseModel/MainDataClass.dart';
import 'package:carismatic/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../ResponseModel/get_brand_model_response_model.dart';
import '../../ResponseModel/get_brands_response_MODEL.dart';
import '../../model/search_model.dart';
import '../../utils/common_utils.dart';
import '../../utils/preferences.dart';

class SearchScreen extends StatefulWidget {
  List<MainDataModel> ll;
   SearchScreen({required this.ll});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  GetBrandResponseModel getBrandsResponseModel=GetBrandResponseModel();
  GetBrandModelResponseModel getModel=GetBrandModelResponseModel();
  List<Data> brandList=[];
  List<MainDataModel> mainDataList=[];
  List<MainDataModel> mainDataListSearchh=[];
 var searchWord="";
  List<SearchModel> Tempmatches = [];
  // List<SearchModel> _getSuggestions(String query) {
  //   List<SearchModel> matches = [];
  //   // matches.addAll(searchData);
  //   // Tempmatches.addAll(searchData);
  //   matches.retainWhere(
  //       (data) => data.name.toLowerCase().contains(query.toLowerCase()));
  //   return matches;
  // }

  // void searchDat(String text) {
  //    Tempmatches = [];
  //    // Tempmatches.addAll(searchData);
  //   // Tempmatches.addAll(searchData);
  //    Tempmatches.retainWhere(
  //       (data) => data.name.toLowerCase().contains(text.toLowerCase()));
  // }
  void searchDat(String text) {

      // for(int i =0;i<mainDataList.length;i++){
      //   for(int k=0;k<mainDataList[i].subCategory!.length;k++){
      //     if(mainDataList[i].subCategory![k].name.toString().toLowerCase().contains(text.toLowerCase())){
      //       mainDataListSearchh.add(mainDataList[i]);
      //     }else{
      //     }
      //   }
      // }  // for(int i =0;i<mainDataList.length;i++){
      //   for(int k=0;k<mainDataList[i].subCategory!.length;k++){
      //     if(mainDataList[i].subCategory![k].name.toString().toLowerCase().contains(text.toLowerCase())){
      //       mainDataListSearchh.add(mainDataList[i]);
      //     }else{
      //     }
      //   }
      // }
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
      setState(() {

      });
  }
  bool select=false;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 4000),(){
      setState(() {

      });
    });
    mainDataList=widget.ll;
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
                    // searchDat(val!);
                    // searchWord=val;
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
                  itemCount: searchWord.isEmpty?mainDataList.length:mainDataListSearchh.length,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    // List<String> templocalList=[];templocalList.clear();
                    // for(int i=0;i<getModel.data!.length;i++){
                    //   if(getBrandsResponseModel.data![index].brandId==getModel.data![i].brandId){
                    //     templocalList.add(getModel.data![i].modelName.toString());
                    //   }
                    // }
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text( mainDataList[index].category.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                            Container(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                  itemCount:  mainDataList[index].subCategory!.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return GestureDetector(
                                      onTap: (){
                                      },
                                      child: ListTile(
                                          trailing: Checkbox(onChanged: (bool? value) async {
                                            SaveUserEntry(action: 'save_entry', model_id:  mainDataList[index].subCategory![i].modelId.toString(), user_id: "${await PreferenceUtils.getString("user_id")}", brand_id:  mainDataList[index].categoryId.toString(),MainIndex: index,SubIndex: i);
                                          }, value: mainDataList[index].subCategory![i].isFavourite,),
                                          title: Text(mainDataList[index].subCategory![i].name.toString())),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }
  Future<void> SaveUserEntry({
    required String action,
    required String user_id,
    required String brand_id,
    required String model_id,
    required int MainIndex,
    required int SubIndex,

  }) async {
    CommonUtils.showProgressDialog(context);
    final headers = {
      'Content-Type': 'application/json',
    };

    var request = http.MultipartRequest('POST',Uri.parse("https://carismatic.online/api/common/save_entry"));

    request.headers.addAll(headers);
    request.fields['action'] = action.toString();
    request.fields['user_id'] = user_id.toString();
    request.fields['brand_id'] = brand_id.toString();
    request.fields['model_id'] = model_id.toString();

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (responseData["status"].toString() == "true") {
      CommonUtils.hideProgressDialog(context);
      mainDataList[MainIndex].subCategory![SubIndex].isFavourite=true;
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["message"]);
    }
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
