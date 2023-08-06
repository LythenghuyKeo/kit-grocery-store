import 'package:final_review_sem/groceryStore/SelectDeleteItem.dart';
import 'package:final_review_sem/groceryStore/insertItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'groceryStore/selectCategory.dart';

class KITShopOwner extends StatefulWidget {
  const KITShopOwner({Key? key}) : super(key: key);

  @override
  State<KITShopOwner> createState() => _KITShopOwnerState();
}

class _KITShopOwnerState extends State<KITShopOwner> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('For Owner'),
      ),
      body: GridView.count(crossAxisCount: 1,padding:EdgeInsets.all(20),children: [
        Container(
          child: Column(

            children: [
              Container(width:300,height:300,child: Image.asset('images/box.png'),),
              ElevatedButton(onPressed: () { Navigator.push(context,MaterialPageRoute(builder:(context)=>InsertItems())); },
              child: Text('Insert new Item'),)
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(width:300,height:300,child: Image.asset('images/delete.png'),),
              ElevatedButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const SelectCategory()));
              },
                child: Text('delete and update item'),)
            ],
          ),
        )
      ],),
    );
  }
}
