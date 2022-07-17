/*
This is edit profile page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
 */

import 'dart:convert';

import 'package:carismatic/constants/constant.dart';
import 'package:carismatic/constants/global_style.dart';
import 'package:carismatic/ui/reusable_widget.dart';
import 'package:carismatic/ui/reusable/global_function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/common_utils.dart';
import '../../../utils/preferences.dart';



class EditProfilePage extends StatefulWidget {
  final String? fName;
  final String? lName;
  final String? uName;
  final String? eMail;
  final String? number;
  final String? bDate;

  const EditProfilePage({this.fName, this.lName, this.uName, this.eMail, this.number, this.bDate}) : super();

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // initialize reusable widget and global function
  final _reusableWidget = ReusableWidget();
  final _globalFunction = GlobalFunction();

  TextEditingController _etEmail = TextEditingController();
  TextEditingController _etFirstName = TextEditingController();
  TextEditingController _etLastName = TextEditingController();
  TextEditingController _etUserName = TextEditingController();
  TextEditingController _etNumber = TextEditingController();
  DateTime _selectedDate = DateTime.now(), initialDate = DateTime.now();
  TextEditingController _etDate = TextEditingController();
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;
  bool _buttonDisabled = true;

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
    _etEmail.text = widget.eMail.toString();
    _etFirstName.text = widget.fName.toString();
    _etLastName.text = widget.lName.toString();
    _etUserName.text = widget.uName.toString();
    _etNumber.text = widget.number.toString();
    _etDate.text = widget.bDate.toString();
    if(_globalFunction.validateEmail(_etEmail.text)){
      _buttonDisabled = false;
    }
    else if(_globalFunction.validateMobileNumber(_etNumber.text)){
      _buttonDisabled = false;
    }else {
      _buttonDisabled = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _etEmail.dispose();
    _etFirstName.dispose();
    _etLastName.dispose();
    _etUserName.dispose();
    _etNumber.dispose();
    _etDate.dispose();
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
            'Edit Profile',
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _reusableWidget.bottomAppBar(),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _etFirstName,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _etLastName,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _etUserName,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: 'User Name',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _etEmail,
              style: const TextStyle(color: CHARCOAL),
              onChanged: (textValue) {
                setState(() {
                  if(_globalFunction.validateEmail(textValue)){
                    _buttonDisabled = false;
                  } else {
                    _buttonDisabled = true;
                  }
                });
              },
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _etNumber,
              style: const TextStyle(color: CHARCOAL),
              onChanged: (textValue) {
                setState(() {
                  if(_globalFunction.validateMobileNumber(textValue)){
                    _buttonDisabled = false;
                  } else {
                    _buttonDisabled = true;
                  }
                });
              },
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: _etDate,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                maxLines: 1,
                cursorColor: Colors.grey[600],
                style: const TextStyle(color: CHARCOAL),
                decoration: const InputDecoration(
                  isDense: true,
                  suffixIcon: Icon(Icons.date_range, color: PRIMARY_COLOR),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  labelText: 'Date of Birth',
                  labelStyle: TextStyle(fontSize: 22 ,color: BLACK_GREY),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: _obscureText,
              style: const TextStyle(color: CHARCOAL),
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
              height: 40,
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) => states.contains(MaterialState.disabled) ? Colors.grey.shade300 : _buttonDisabled?Colors.grey.shade300:PRIMARY_COLOR,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      )
                  ),
                ),
                onPressed: () {
                  if(_buttonDisabled){
                    editProfile();

                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _buttonDisabled?Colors.grey[600]:Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          ],
        )
    );
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: PRIMARY_COLOR,
            colorScheme: const ColorScheme.light(primary: PRIMARY_COLOR, secondary: PRIMARY_COLOR),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _etDate = TextEditingController(
            text: _selectedDate.toLocal().toString().split(' ')[0]);
      });
    }
  }

  Future<void> editProfile() async {
    CommonUtils.showProgressDialog(context);
    final headers = {
      'Content-Type': 'application/json',
    };

    var request = http.MultipartRequest('POST',Uri.parse("https://carismatic.online/api/userauth/update_profile"));

    request.headers.addAll(headers);
    request.fields['user_id'] = PreferenceUtils.getString("user_id");
    request.fields['firstname'] = _etFirstName.text.toString();
    request.fields['lastname'] = _etLastName.text.toString();
    request.fields['username'] = _etUserName.text.toString();
    request.fields['email'] = _etEmail.text.toString();
    request.fields['mobile'] = _etNumber.text.toString();
    request.fields['dob'] = _etDate.text.toString();
    request.fields['action'] = "do_update";

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (responseData["status"].toString() == "true") {
      CommonUtils.hideProgressDialog(context);
      _reusableWidget.startLoading(context, 'Edit Profile Success', 1);
      FocusScope.of(context).unfocus();
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["message"]);
    }
  }
}
