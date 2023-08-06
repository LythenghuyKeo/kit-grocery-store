import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'kitshopowner.dart';
import 'kitshopuser.dart';
class SQL_CRUD_Carousel_Page extends StatefulWidget {
  const SQL_CRUD_Carousel_Page({Key? key}) : super(key: key);

  @override
  State<SQL_CRUD_Carousel_Page> createState() => _SQL_CRUD_Carousel_PageState();
}

class _SQL_CRUD_Carousel_PageState extends State<SQL_CRUD_Carousel_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQL_CRUD carousel'),),
      body: Column(
        children: [
          Center(
            child: Text('Welcome to our shop',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Color.fromARGB(200, 222, 109, 152),),),
          ),
          ElevatedButton(
              onPressed: (){setState(() {
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>KITShopUser()));
              });},
              child: Text('For Customer')),
          ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder:(context)=>KITShopOwner()));}, child: Text('For Shop Owner')),
        ],
      ),
    );
  }
}
