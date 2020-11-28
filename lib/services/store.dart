import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/model/product.dart';
import 'package:flash_chat/model/user.dart';

class StoreService{
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users.doc(FirebaseAuth.instance.currentUser.uid)
        .set({'cart': List<String>(), 'orders': List<String>()})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // Future<List<UserData>> getUser() {
  //   List<UserData> userData = List<UserData>();
  //        users.get().then((value) {
  //       value.docs.forEach((element) {
  //         if(element.id == FirebaseAuth.instance.currentUser.uid){
  //           userData.add(UserData(cart: element.get('cart'), orders: element.get('orders')));
  //           print(element.get('cart'));
  //         }
  //         return userData;
  //       });
  //     }).catchError((error) => null);
  //
  // }

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

  // Product getProduct(String pid){
  //   Product product;
  //   products.doc(pid).get().then((value) {
  //     product = Product(pid: pid, name: value.get('name'),
  //         description: value.get('description'),
  //         price: value.get('price'));
  //
  //   }).catchError((e) => print('ero'));
  //   return product;
  //
  // }

}