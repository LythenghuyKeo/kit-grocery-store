import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<void> registration() async{
    var request = await http.post(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/register.php'),body: {
      'email':emailcontroller.text.toString(),
      'password':pwdcontroller.text.toString()
    });
    if (request.body.contains('success')){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully register')));
    }
  }
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwdcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register page'),),
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
          ElevatedButton(onPressed: (){
            registration();
          }, child: Text('register'))
        ],
      ),
    );
  }
}
