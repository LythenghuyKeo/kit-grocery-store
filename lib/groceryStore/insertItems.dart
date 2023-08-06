
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
class InsertItems extends StatefulWidget {
  const InsertItems({Key? key}) : super(key: key);

  @override
  State<InsertItems> createState() => _InsertItemsState();
}

class _InsertItemsState extends State<InsertItems> {
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
  Future<void> insertItem() async{
    var request = await http.post(Uri.parse('http://192.168.72.88/KIT-E-COMMERCE/insert_item.php'),body:
          {
            'category_id' : categoryId.text.toString(),
            'item_name':item_name.text.toString(),
            'price':price.text.toString(),
            'image':imageData.toString()
          }

    );
    var result = json.encode(request.body);
    if (result=='Success'){
      categoryId.text='';
      item_name.text='';
      price.text='';
      image='' as File?;


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
            ElevatedButton(onPressed: (){insertItem();}, child: Text('Submit'))
          ],
        ),
      )
    );
  }
}
