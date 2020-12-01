import 'dart:io';

import 'package:flash_chat/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/MyDrawerBuilder.dart';
import 'package:image_picker/image_picker.dart';
import './../services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'addproduct_screen';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  StoreService _store = StoreService();
  File file;
  StorageService _storage = StorageService();
  String _name;
  String _dis;
  String _amount;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: null,
        drawer: Drawer(
          child: MyDrawerBuilder(),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Form(
        key: _formkey,
        child: Container(
          child: ListView(
            children: [
              _buildImage(context),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildName(),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildDis(),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildAmount(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (!_formkey.currentState.validate()) {
                      return;
                    }

                    _formkey.currentState.save();
                    try {
                      if(file != null){
                        String url;
                        dynamic productid = await _store.addProduct(_name, _dis, _amount).then((value) => value);
                        await _storage.uploadFile(file, 'Products/${productid}/product_pic');
                        await _storage.downloadURL('Products/${productid}/product_pic').then((value) {
                          url = value;
                        });
                        await _store.updateProduct('ImageUrl', url, productid);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Product Added'),
                          duration: Duration(seconds: 2),
                        ));
                        _formkey.currentState.reset();
                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Put Image'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );
          },
        ));
  }

  //
  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name cant be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  //
  Widget _buildDis() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Discription'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Discription cant be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _dis = value;
      },
    );
  }

  ///
  Widget _buildAmount() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name cant be empty';
        }
        if (int.tryParse(value) == null) {
          return 'enter al valid number';
        }
        return null;
      },
      onSaved: (String value) {
        _amount = value;
      },
    );
  }

  ////
  Widget _buildImage(context,
      [String imageUrl = 'https://picsum.photos/250?image=2']) {
    return Stack(
      overflow: Overflow.visible,
      alignment: AlignmentDirectional.topCenter,
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .35,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(60)),
              child: IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  onPressed: () async{
                    final picker = ImagePicker();
                    PickedFile pickedfile =  await picker.getImage(source: ImageSource.gallery);
                    file = File(pickedfile.path);

                  }),
            )),
      ],
    );
  }
  /////

}
