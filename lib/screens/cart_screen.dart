import 'package:flash_chat/model/product.dart';
import 'package:flash_chat/model/user.dart';
import 'package:flash_chat/screens/order_screen.dart';
import 'package:flash_chat/services/store.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}
StoreService _store = StoreService();
 UserData user ;
dynamic cartData;
class _CartScreenState extends State<CartScreen> {

  bool loading = true;

  // void getAll(){
  //   setState(() async {
  //     user = await _store.getUser();
      
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    _store.getUser().then((value){
        if(loading)
        setState(() {
          user = value;
          cartData = user.cart;
          print(cartData.runtimeType);
          print(cartData[0]);
          loading = false;
        });
      });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => OrderScreen()));
          }),
        ],
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: loading? Center(child: CircularProgressIndicator(),): Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return CartItem(pid: cartData[index],);
          },
          itemCount: cartData.length ,
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {


  String pid;
  Product a;
  CartItem({@required this.pid});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  StoreService _store = StoreService();
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    if(loading)
      _store.getProduct(widget.pid).then((value) {
        setState(() {
          widget.a = value;
          loading = false;
        });
      });
      
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      // margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: loading? Container():Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Image.network(
                  widget.a.productImage,
                  fit: BoxFit.cover,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.a.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: .8),),
                Text(widget.a.price,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: .8),),
                Row(
                  children: [
                    RaisedButton(
                      child: Text('buy'),
                      onPressed: () async {
                       await _store.addToOrders(widget.a.pid);
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .05,),
                    RaisedButton(
                      color: Theme.of(context).errorColor,
                      child: Text(
                        'cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
                       await _store.removeFromCart(widget.a.pid);
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .05,)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
