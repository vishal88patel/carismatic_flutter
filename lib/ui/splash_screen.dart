import 'dart:convert';

import 'package:carismatic/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:carismatic/ui/authentication/signin.dart';
import 'package:http/http.dart' as http;

import '../ResponseModel/MainDataClass.dart';
import '../ResponseModel/get_brand_model_response_model.dart';
import '../ResponseModel/get_brands_response_MODEL.dart';
import '../constants/constant.dart';
import '../utils/preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);


  @override _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State {
  GetBrandResponseModel getBrandsResponseModel=GetBrandResponseModel();
  GetBrandModelResponseModel getModel=GetBrandModelResponseModel();
  List<Data> brandList=[];
  List<MainDataModel> mainDataList=[];
  List<MainDataModel> mainDataListSearchh=[];
  @override void initState() {
    super.initState();
    changeRoute();
  }
  Future changeRoute() async {
    var id=PreferenceUtils.getString("user_id")??"";
    if(id!=null && id.isEmpty){
      await Future.delayed(Duration(milliseconds: 3000), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SigninPage()));
      });
    }else{

      await Future.delayed(Duration(milliseconds: 200), () {
        getBrands();
        //

      });
    }
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
    for(int i=0;i<getBrandsResponseModel.data!.length;i++){
      var brandIId=getBrandsResponseModel.data![i].brandId;
      List<SubCategory> tempList=[];

      for(int k=0;k<getModel.data!.length;k++){

        if(getModel.data![k].brandId==brandIId){


          tempList.add(SubCategory(name:getModel.data![k].modelName ,isFavourite:false,modelId: getModel.data![k].modelId ));

        }



      }
      mainDataList.add(MainDataModel(category:getBrandsResponseModel.data![i].brandName ,subCategory:tempList,categoryId:getBrandsResponseModel.data![i].brandId  ));

    }

    // if (res.status=="true") {
    //
    // } else {
    // }
    setState(() {

    });
    mainDataListSearchh=mainDataList;
    COnstantMainDataList.addAll(mainDataList);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage(mainDataList)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/splash.gif",
                gaplessPlayback: true,
                fit: BoxFit.fill
            )
        ));
  }
}