import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/model/product.dart';
import 'package:flash_chat/model/user.dart';
import 'package:flash_chat/services/storage.dart';

class StoreService{
  final uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference products = FirebaseFirestore.instance.collection('Products');


  Future<void> addUser() {
    return users.doc(uid)
        .set({'cart': List<String>(), 'orders': List<String>()})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<UserData> getUser() async {
    try {
      final userDocument =
      users.doc(uid);
      final userData = (await userDocument.get()).data();
      return UserData.fromMap(userData);
    }catch (e){

    }
  }

  Future<void> addToCart(String pid){
    try {
      users.doc(uid).update({'cart': FieldValue.arrayUnion([pid])});
    }catch(e){
      print(e.toString());
    }

  }

  Future<void> addToOrders(String pid){
    try {
      users.doc(uid).update({'orders': FieldValue.arrayUnion([pid])}).then((value){
        users.doc(uid).update({'cart': FieldValue.arrayRemove([pid])});
      });
    }catch(e){
      print(e.toString());
    }

  }

  Future<void> removeFromCart(String pid){
    try {
      users.doc(uid).update({'cart': FieldValue.arrayRemove([pid])});
    }catch(e){
      print(e.toString());
    }

  }

  Future<void> removeFromOrder(String pid){
    try {
      users.doc(uid).update({'orders': FieldValue.arrayRemove([pid])});
    }catch(e){
      print(e.toString());
    }

  }

  Future<void> updateProduct(String field, String value, String pid){
    return products.doc(pid).update({field : value});
  }

  Future<String> addProduct( String name, String description, String price){
    return products
        .add({ 'name' : name, 'description' : description, 'price' : price, 'ImageUrl' : '' })
        .then((value) => value.id)
        .catchError((error) => print("Failed to add product: $error"));
  }


  Future<List<Product>> getProducts(){
    List<Product> product = List<Product>();
    return products.get().then((value){
      value.docs.forEach((element) async {
        product.add(Product(pid: element.id, name: element.get('name'),
            description: element.get('description'),
            price: element.get('price'), productImage: element.get('ImageUrl')));
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

  Future<void> deleteProduct(String pid){
    try {
      return products.doc(pid).delete();
    }catch(e){
      print(e.toString());
    }
  }

}