import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KITShopUser extends StatefulWidget {
  const KITShopUser({Key? key}) : super(key: key);

  @override
  State<KITShopUser> createState() => _KITShopUserState();
}

class _KITShopUserState extends State<KITShopUser> {
  List<Widget>  current_item=[];
  int? current;
  List<DropdownMenuEntry> category_list=[];
  List hi=[];
  showImage(String image){
    return Image.memory(base64Decode(image));
  }
  fetch_category() async{
    var response = await http.get(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/get_category.php'));
    hi = json.decode(response.body);
    setState(() async {
      for (int i=0;i<hi.length;i++){
        category_list.add(DropdownMenuEntry(value: hi[i]['id'], label: hi[i]['category_name']));
      }
    });
  }
   fetch_item(value) async{
    var response = await http.post(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/get_item.php'),body: {'id':value.toString()});
    List current = json.decode(response.body);
    setState(() {
      for (int i=0;i<current.length;i++){

        current_item.add(
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text('${current[i]['item_name']}',style: TextStyle(fontSize: 30)),
              ),
              Container(
                child: showImage(current[i]['image']),
              ),
              Container(
                color: Color.fromARGB(3490, 233, 12, 34),
                child: Text('${current[i]['price']}\$',style: TextStyle(fontSize: 30),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child:ElevatedButton(onPressed: (){}, child: Text('Add to cart',style: TextStyle(fontSize: 30)),))
                ],

              )
            ],
          )
        );
      }
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
      appBar: AppBar(title: Text('Grocery Store for shop customer'),),
      body: Column(
        children: [
          Container(
            child: DropdownMenu(dropdownMenuEntries: category_list,
                                onSelected: (value){
                                            fetch_item(value);
                                            current_item=[];

                                }
              ),
          ),
          CarouselSlider(items: current_item, options: CarouselOptions(viewportFraction: 1.0,onPageChanged: (i,r){}))
        ],
      ),
    );
  }
}
