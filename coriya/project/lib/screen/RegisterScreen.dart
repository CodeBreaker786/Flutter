import 'dart:io';

import 'package:avalinks/models/country/CountryData.dart';
import 'package:avalinks/models/user/UserModel.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as Path;
import 'package:regexed_validator/regexed_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RegisterState();
  }
}

class RegisterState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String userRoleId = AppConstant.USER_ROLES[0].role_id;

  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNoController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  CountryData _countryData;

  bool passObscure = true;

  String avatarPath = null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ListView(
                padding: EdgeInsets.all(15.0),
                shrinkWrap: true,
                children: <Widget>[
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 60.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: avatarPath == null
                            ? Image.asset('images/icon_profile.png')
                            : Image.file(
                                File(avatarPath),
                                fit: BoxFit.fill,
                              ),
                      ),
                      backgroundColor: avatarPath == null
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                    onTap: () async {
                      String filePath =
                          await FilePicker.getFilePath(type: FileType.image);
                      if (filePath != null) {
                        setState(() {
                          avatarPath = filePath;
                        });
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: AppConstant.USER_ROLES.map((val) {
                        return Row(
                          children: <Widget>[
                            Radio(
                                value: val.role_id,
                                groupValue: userRoleId,
                                onChanged: (newValue) {
                                  setState(() {
                                    print(newValue);
                                    userRoleId = newValue;
                                  });
                                }),
                            Text(
                              val.role,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("First Name"),
                          TextFormField(
                            controller: fNameController,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                hintText: 'Enter First Name',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 5.0))),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter First Name';
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Last Name"),
                          TextFormField(
                            controller: lNameController,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                hintText: 'Enter last Name',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 5.0))),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Last Name';
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Email Id"),
                          TextFormField(
                            controller: emailController,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                hintText: 'Enter Email Id',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 5.0))),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Email Id';
                              } else if (!validator.email(value)) {
                                return 'Invalid Email Id';
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Phone No"),
                        TextFormField(
                          controller: phoneNoController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              hintText: 'Enter Mobile Number',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 5.0))),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Phone No';
                            } else if (!validator.phone(value)) {
                              return 'Invalid Phone No';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Password"),
                        TextFormField(
                          controller: passwordController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 5.0)),
                            suffixIcon: IconButton(
                                icon: Icon(passObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    passObscure = !passObscure;
                                  });
                                }),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: passObscure,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Password';
                            } else if (value.length < 6) {
                              return 'Password field must be at least 6 characters in length.';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      child: IgnorePointer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Country"),
                            TextFormField(
                              controller: countryController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  hintText: 'Select Your Country',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 5.0))),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (_countryData == null) {
                                  return 'Enter Country';
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        dynamic countryData = await Navigator.of(context)
                            .pushNamed('/get_country');
                        if (countryData != null && countryData is CountryData) {
                          setState(() {
                            _countryData = countryData;
                            countryController.text = _countryData.country_name;
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff72ADFF))),
                        color: Color(0xff72ADFF),
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            register(
                                avatarPath,
                                fNameController.text,
                                lNameController.text,
                                emailController.text,
                                phoneNoController.text,
                                passwordController.text);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  register(String profileImagePath, String fName, String lName, String email,
      String phone, String pass) async {
    FormData formData;
    File profileImage =
        profileImagePath == null ? null : File(profileImagePath);
    if (profileImage != null && profileImage.existsSync()) {
      formData = new FormData.from({
        'profile_pic':
            new UploadFileInfo(profileImage, Path.basename(profileImage.path)),
        'first_name': fName,
        'last_name': lName,
        'email': email,
        'user_phone': phone,
        'password': pass,
        'country_id': _countryData.country_id,
        'user_role_id': userRoleId
      });
    } else {
      formData = new FormData.from({
        'first_name': fName,
        'last_name': lName,
        'email': email,
        'user_phone': phone,
        'password': pass,
        'country_id': _countryData.country_id,
        'user_role_id': userRoleId
      });
    }
    HttpResponse httpResponse =
        await MyHttpClient(context).postFormData(UrlUtils.REGISTER, formData);
    print(httpResponse);
    if (httpResponse.success) {
      UserModel model = UserModel.fromJsonMap(httpResponse.response);
      if (model.status == 1) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Register Vendor'),
                  content: Text(model.message),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
      } else {
        Utils().showMessageDialog(context, "Error", model.message);
      }
    } else {
      Utils().showMessageDialog(context, "Error", httpResponse.error);
    }
  }
}
