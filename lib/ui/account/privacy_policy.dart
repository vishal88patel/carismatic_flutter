import 'dart:convert';

import 'package:carismatic/constants/constant.dart';
import 'package:carismatic/constants/global_style.dart';
import 'package:carismatic/ui/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import '../../utils/common_utils.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  // initialize reusable widget
  final _reusableWidget = ReusableWidget();
  Map privacy= {};
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getPrivacy();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: const Text(
            'Privacy Policy',
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _reusableWidget.bottomAppBar(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: Html(
              data:privacy.isEmpty?"":privacy["data"],
              style: {
                "p": Style.fromTextStyle(
                  const TextStyle(fontSize: 16),
                ),
              },
            ),
          ),
        )
    );
  }
  Future<void> getPrivacy() async {
    CommonUtils.showProgressDialog(context);
    //var user_id = PreferenceUtils.getString("user_id");
    final uri = Uri.parse("https://carismatic.online/api/common/get_privacy_policy/");
    final headers = {
      'Content-Type': 'application/json',
    };

    Response response = await post(
      uri,
      headers: headers,
    );
    final responseData = json.decode(response.body);

    if (responseData["status"].toString() == "true") {
      privacy = responseData;
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage("privacy Successfully");
      setState((){

      });
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["status"].toString());
    }
  }
}
