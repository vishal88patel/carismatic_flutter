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

      await Future.delayed(Duration(milliseconds: 3000), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage()));


      });
    }
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