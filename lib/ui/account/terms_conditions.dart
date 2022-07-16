import 'dart:convert';

import 'package:carismatic/constants/constant.dart';
import 'package:carismatic/constants/global_style.dart';
import 'package:carismatic/ui/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import '../../utils/common_utils.dart';

class TermsConditionsPage extends StatefulWidget {
  @override
  _TermsConditionsPageState createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  // initialize reusable widget
  final _reusableWidget = ReusableWidget();
  Map terms = {};

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getTerms();
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
            'Terms and Conditions',
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
              data:terms.isEmpty?"" :terms["data"],
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

  Future<void> getTerms() async {
    CommonUtils.showProgressDialog(context);
    //var user_id = PreferenceUtils.getString("user_id");
    final uri = Uri.parse("https://carismatic.online/api/common/get_terms/");
    final headers = {
      'Content-Type': 'application/json',
    };

    Response response = await post(
      uri,
      headers: headers,
    );
    final responseData = json.decode(response.body);

    if (responseData["status"].toString() == "true") {
      terms = responseData;
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage("terms Successfully");
      setState((){

      });
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["status"].toString());
    }
  }
}
