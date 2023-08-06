import 'dart:convert';

import 'package:final_review_sem/kitshopowner.dart';
import 'package:final_review_sem/kitshopuser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwdcontroller = TextEditingController();
  Future<void> login() async{
    var request = await http.post(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/login.php'),body: {
      'email':emailcontroller.text.toString(),
      'password':pwdcontroller.text.toString()
    });
    if (request.body.contains("user")){
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>KITShopUser()));
      });
    }else if (request.body.contains("admin")){
      setState(() {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>KITShopOwner()));
      });
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log in page'),),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: 'Please enter the email here :',
                labelText: 'Email : ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: pwdcontroller,
              decoration: InputDecoration(
                  hintText: 'Please enter the password here :',
                  labelText: 'Password : ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
          ),
          ElevatedButton(onPressed: (){login();}, child: Text('login'))
        ],
      ),
    );
  }
}


