import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'SelectDeleteItem.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List category_list=[];


  Future<void>fetch_category() async{
    var response = await http.get(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/get_category.php'));
    setState(() {
      category_list=json.decode(response.body);
    });
  }

  @override
  void initState(){
    fetch_category();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Category'),),
      body: ListView.builder(
        itemCount: category_list.length,
        itemBuilder: (context,index){
          String categoryId=category_list[index]['id'].toString();
          return Card(
            child:ListTile(
              title: Text('${category_list[index]['category_name']}'),
              trailing: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectDeleteItem(categoryId)));
              },icon:Icon(Icons.navigate_next)),
            ),
          );
        },
      )


    );
  }
}
