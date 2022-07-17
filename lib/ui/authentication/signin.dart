import 'dart:convert';

import 'package:carismatic/constants/constant.dart';
import 'package:carismatic/constants/global_style.dart';
import '../../utils/common_utils.dart';
import '../../utils/preferences.dart';
import 'forgot_password.dart';
import 'package:carismatic/ui/home.dart';
import 'signup.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _etEmail = TextEditingController();
  final TextEditingController _etPass = TextEditingController();
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _etEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: const EdgeInsets.fromLTRB(30, 120, 30, 30),
          children: <Widget>[
            Center(
                child: Image.asset('assets/logo.jpeg',
                    height: 140)),
            const SizedBox(
              height: 80,
            ),
            const Text('Sign In', style: GlobalStyle.authTitle),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _etEmail,
              style: const TextStyle(color: CHARCOAL),
              onChanged: (textValue) {
                setState(() {});
              },
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: BLACK_GREY),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: _obscureText,
              style: const TextStyle(color: CHARCOAL),
              controller: _etPass,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText: 'Password',
                labelStyle: const TextStyle(color: BLACK_GREY),
                suffixIcon: IconButton(
                    icon: Icon(_iconVisible, color: Colors.grey[400], size: 20),
                    onPressed: () {
                      _toggleObscureText();
                    }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: PRIMARY_COLOR, fontSize: 13),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            Container(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) => PRIMARY_COLOR,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      )
                  ),
                ),
                onPressed: () {
                  if(_etEmail.text.isEmpty){
                    CommonUtils.showRedToastMessage("Please Enter Email");
                  }else if (!EmailValidator.validate(
                      _etEmail.text)) {
                    CommonUtils.showRedToastMessage("Please Enter Valid Email");
                  }else if (_etPass.text.isEmpty) {
                    CommonUtils.showRedToastMessage("Please Enter Password");
                  }else{
                    signInByPhone();

                  }
                  //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);

                  FocusScope.of(context).unfocus();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
            ),
            const SizedBox(
              height: 40,
            ),

            Center(
              child: GestureDetector(
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                  FocusScope.of(context).unfocus();
                },
                child: Wrap(
                  children: const [
                    Text(
                      'No account yet? ',
                      style: GlobalStyle.authBottom1,
                    ),
                    Text(
                      'Create one',
                      style: GlobalStyle.authBottom2,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    GlobalStyle.iconBack,
                    Text(
                      ' Back',
                      style: GlobalStyle.back,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> signInByPhone() async {
    CommonUtils.showProgressDialog(context);
    final headers = {
      'Content-Type': 'application/json',
    };

    var request = http.MultipartRequest('POST',Uri.parse("https://carismatic.online/api/userauth/login"));

    request.headers.addAll(headers);
    request.fields['email'] = _etEmail.text.toString();
    request.fields['password'] = _etPass.text.toString();
    request.fields['action'] = "do_login";

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (responseData["status"].toString() == "true") {
      CommonUtils.hideProgressDialog(context);
      PreferenceUtils.setString("user_id", responseData["user_id"].toString());
      PreferenceUtils.setString("user_name", responseData["user_name"].toString());
      PreferenceUtils.setString("user_email", responseData["user_email"].toString());
      CommonUtils.showGreenToastMessage(responseData["message"]);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage(COnstantMainDataList)));
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["message"]);
    }
  }
}
