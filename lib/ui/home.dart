
import 'dart:convert';

import 'package:carismatic/ResponseModel/MainDataClass.dart';
import 'package:carismatic/ui/home/search_screen.dart';
import 'package:carismatic/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:carismatic/ui/account/tab_account.dart';
import 'package:carismatic/ui/home/tab_home.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:carismatic/constants/constant.dart';
import 'package:http/http.dart' as http;

import '../ResponseModel/get_brand_model_response_model.dart';
import '../ResponseModel/get_brands_response_MODEL.dart';
import '../utils/preferences.dart';
import 'home/my_car_collection_screen.dart';


class HomePage extends StatefulWidget {
   HomePage( );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetBrandResponseModel getBrandsResponseModel=GetBrandResponseModel();
  GetBrandModelResponseModel getModel=GetBrandModelResponseModel();
  List<Data> brandList=[];
  List<MainDataModel> mainDataList=[];
  List<MainDataModel> mainDataListSearchh=[];

  late PageController _pageController;
  int _selectedPage = 0;
  List<Widget> pages = [
    // TabHomePage(),
    SearchScreen(ll: COnstantMainDataList),
    MyCarCollectionScreen(),
    //HomeScreen(),
    //MainPage(),
    TabAccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    Future.delayed(Duration(milliseconds: 200),(){
      getBrands();

    });
    super.initState();
  }
  Future<void> getBrands() async {
    CommonUtils.showProgressDialog(context);
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
    final uri = Uri.parse("https://carismatic.online/api/common/get_all_models?user_id=${await PreferenceUtils.getString("user_id")}");


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


          tempList.add(SubCategory(name:getModel.data![k].modelName ,isFavourite:getModel.data![k].ischceck,modelId: getModel.data![k].modelId ));

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
    CommonUtils.hideProgressDialog(context);
    mainDataListSearchh=mainDataList;
    COnstantMainDataList.addAll(mainDataList);
    setState(() {

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() { _selectedPage = index; }),
        controller: _pageController,
        children: [
          ...pages
        ],
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedPage,
        showElevation: false,
        onItemSelected: (index) => _onItemTapped(index),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_outlined, size: 23, color: PRIMARY_COLOR,),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.car_rental, size: 23, color: PRIMARY_COLOR,),
            title: const Text('My Car Collection'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.account_circle_outlined, size: 23, color: PRIMARY_COLOR,),
            title: const Text('Account',),
          ),
        ],
      ),
    );
  }
}
