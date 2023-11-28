import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:s_shop/users/authentication/model/user.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../api/api_connection.dart';

class SignupController extends GetxController {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passController = TextEditingController();
  validateUserEmail({context}) async {
    try {
      var res = await http.post(Uri.parse(API.validateEmail), body: {
        'user_email': emailController.text.trim(),
      });
      if (res.statusCode == 200) {
        //connection with api sucessfully
        var resBodyOfValidateEmail = jsonDecode(res.body);
        if (resBodyOfValidateEmail['emailFound'] == true) {
          VxToast.show(context, msg: 'Email is allready exist');
        } else {
          //add new user to data base
          registerAndSaveUserRecord();
        }
      }
    } catch (e) {}
  }

  registerAndSaveUserRecord() async {
    User userModel = User(1, nameController.text.trim(),
        emailController.text.trim(), passController.text.trim());

    try {
      await http.post(Uri.parse(API.signUp),
      body: userModel.toJson()
      );
    } catch (e) {}
  }
}
