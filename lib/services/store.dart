import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/model/product.dart';
import 'package:flash_chat/model/user.dart';

class StoreService{
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference products = FirebaseFirestore.instance.collection('Products');


  Future<void> addUser() {
    return users.doc(FirebaseAuth.instance.currentUser.uid)
        .set({'cart': List<String>(), 'orders': List<String>()})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<UserData> getUser() async {
    try {
      final userDocument =
      users.doc(FirebaseAuth.instance.currentUser.uid);
      final userData = (await userDocument.get()).data();
      return UserData.fromMap(userData);
    }catch (e){

    }
  }

  Future<String> addProduct( String name, String description, String price ){
    return products
        .add({ 'name' : name, 'description' : description, 'price' : price })
        .then((value) => "Product Added")
        .catchError((error) => print("Failed to add product: $error"));
  }

  Future<List<Product>> getProducts(){
    List<Product> product = List<Product>();
    return products.get().then((value){
      value.docs.forEach((element) {
        product.add(Product(pid: element.id, name: element.get('name'),
            description: element.get('description'),
            price: element.get('price')));
      });
      return product;
    }).catchError((onError) => print(onError.toString()));

  }

  Future<Product> getProduct(String pid) async{
    final product =
    products.doc(pid);
    final productId = (await product.get()).id;
    final productpiece = (await product.get()).data();

    return Product.fromMap(productpiece, productId);
  }

}