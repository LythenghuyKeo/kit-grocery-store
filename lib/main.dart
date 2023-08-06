import 'package:final_review_sem/login.dart';
import 'package:final_review_sem/register.dart';
import 'package:flutter/material.dart';

import 'SQL_CRUD_Carousel.dart';

void main(){
  runApp(mainPage());
}
class mainPage extends StatelessWidget{
  mainPage({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(home:MainHomePage());
  }
}
class MainHomePage extends StatefulWidget{
  MainHomePage({super.key});
  @override
  State<MainHomePage> createState() => mainhomepageState();
}
class mainhomepageState extends State<MainHomePage>{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('KIT Grocery Store'),
        // actions: [
        //   DropdownMenu(
        //     dropdownMenuEntries: [
        //       DropdownMenuEntry(value: 1, label: 'KIT - Grocery - Store')
        //     ],onSelected: (value){
        //         if (value==1){
        //           Navigator.push(context,MaterialPageRoute(builder:(context)=>SQL_CRUD_Carousel_Page()));
        //         }
        //   },)
        // ],
      ),
      body: Column(
        children: [
          Center(
            
            child: Container(
              padding: EdgeInsets.all(40),
              child: Text('Welcome to our shop!',style: TextStyle(fontSize: 40),),
            ),
          ),
          Column(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push((context),MaterialPageRoute(builder: (context)=>LoginPage()));
              }, child: Text('Log in')),
              ElevatedButton(onPressed: (){
                Navigator.push((context),MaterialPageRoute(builder: (context)=>RegisterPage()));
              }, child: Text('Register'))
            ],
          )
        ],
      ),
    );
  }
}