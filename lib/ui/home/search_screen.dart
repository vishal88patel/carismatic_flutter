import 'package:carismatic/constants/constant.dart';
import 'package:flutter/material.dart';

import '../../model/search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                height: 600,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount:  Tempmatches.length,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Row(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: 15,right: 15,),
                                    child: Container(
                                      height:30,

                                      child: Text(Tempmatches[index].name),
                                    ),
                                  ),

                                ],
                              ),

                              Expanded(child: Container()),
                              Checkbox(value: select, onChanged: (bool? value) {
                                setState(() {
                                  select=!select;
                                });
                              },),
                              SizedBox(width: 8,),
                            ],
                          ),
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
