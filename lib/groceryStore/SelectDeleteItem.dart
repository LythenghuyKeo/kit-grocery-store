import 'dart:convert';

import 'package:final_review_sem/groceryStore/SelectUpdateItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SelectDeleteItem extends StatefulWidget {
  const SelectDeleteItem(this.category_id, {super.key});
  final String category_id;
  @override
  State<SelectDeleteItem> createState() => _SelectDeleteItemState();
}

class _SelectDeleteItemState extends State<SelectDeleteItem> {
  String? item_id;
  int? category_id;
  List item=[];
  List category_list=[];

  showImage(String image){
    return Image.memory(base64Decode(image));
  }

  fetch_category() async{
    var response = await http.get(Uri.parse('http://192.168.1.11/kit-e-commerce/get_category.php'));
    

  }
  Future<void>fetch_item() async{
    var response = await http.post(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/get_item.php'),body:{
            'id':widget.category_id
    });
    setState(() {
      item = json.decode(response.body);
    });


  }
  Future deleteItem(value) async{
    final request = await http.post(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/delete_item.php'),body:{'id':value.toString()});
    if (request.body.contains('success')){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Successfully')));
    }
  }
  @override
  void initState(){
    fetch_item();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select and Delete Item'),),
      body:ListView.builder(
          itemCount: item.length,
          itemBuilder: (context,index){
            item_id=item[index]['item_id'].toString();
            return Card(

              child: ListTile(
                leading:Image.memory(base64Decode(item[index]['image'])) ,
                subtitle: Text('${item[index]['price']} \$'),
                title:GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>SelectUpdateItem(item_id:item_id!,item_name:item[index]['item_name'],categ_id:item[index]['category_id'].toString(),price:item[index]['price'].toString())));
                  },
                  child: Text('${item[index]['item_name']}') ,
                ),
                trailing: GestureDetector(
                  onTap: (){
                    try{
                     deleteItem(item_id);
                    }on Exception catch(e) {
                      print(e);
                    }
                  },
                  child: Icon(Icons.delete,color: Colors.red,size:30.0,),
                ),
                
              ),
            );
          }
      )
    );
  }
}
