import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectUpdateItem extends StatefulWidget {
  const SelectUpdateItem({required this.item_id,required this.categ_id,required this.item_name,required this.price,super.key});
  final String item_id;
  final String categ_id;
  final String item_name;
  final String price;
  @override
  State<SelectUpdateItem> createState() => _SelectUpdateItemState();
}

class _SelectUpdateItemState extends State<SelectUpdateItem> {
  List item=[];
  File? image;
  String? imageData;
  TextEditingController categoryId = TextEditingController();
  TextEditingController item_name = TextEditingController();
  TextEditingController price = TextEditingController();
  Future selectImage(ImageSource src) async{
    final myImage = await ImagePicker().pickImage(source: src);
    final temporary = File(myImage!.path);
    setState(() {
      image=temporary;
    });
    imageData = base64Encode(image!.readAsBytesSync());
  }
  Future<void>fetch_item() async{
    var response = await http.post(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/get_item_based.php'),body:{
      'id':widget.item_id
    });
    setState(() {
      item = json.decode(response.body);
      // //categoryId.text=widget.
      // item_name.text=item.first['item_name'];
      // price.text=item[0]['price'];
      // image='' as File?;
    });


  }
  Future<void> updateItem() async{
    var request = await http.post(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/update_item.php'),body:
    {
      'id':widget.item_id.toString(),
      'category_id' : categoryId.text.toString(),
      'item_name':item_name.text.toString(),
      'price':price.text.toString(),
      'image':imageData.toString()
    }

    );
    var result = json.encode(request.body);
    if (request.body.contains('success')){
      categoryId.text='';
      item_name.text='';
      price.text='';
      image='' as File?;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Successfully')));
    }

  }
  Widget createTextField(controller,inputText,hintText){
    return Container(
      padding: EdgeInsets.all(30),
      child: TextField(
          controller:controller ,
          decoration:InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              hintText: hintText,
              labelText: inputText,
              fillColor: Color.fromARGB(30, 100, 200, 10)
          )
      ),
    );
  }
  @override
  void initState(){
    fetch_item();
    categoryId.text=widget.categ_id;
    item_name.text=widget.item_name;
    price.text=widget.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title:Text('Insert the item') ,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              createTextField(categoryId, 'Enter the category id here:', 'CategoryID:'),
              createTextField(item_name, 'Enter the item name here:', 'Item name'),
              createTextField(price, 'Enter the price here (\$) :', 'Itemprice'),
              Column(children: [
                image ==null? FlutterLogo(size: 100,):Image.file(image!,width: 100,height: 200,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [MaterialButton(
                    onPressed: (){selectImage(ImageSource.gallery);},
                    child: Icon(Icons.browse_gallery_rounded),
                  )],
                )
              ],),
              ElevatedButton(onPressed: (){updateItem();}, child: Text('Update item'))
            ],
          ),
        )
    );
  }
}


