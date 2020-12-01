import 'package:flash_chat/model/product.dart';
import 'package:flash_chat/model/user.dart';
import 'package:flash_chat/services/store.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  _orderScrean createState() => _orderScrean();
}
class _orderScrean extends State<OrderScreen>{
  bool loading = true;
  StoreService _store = StoreService();
  UserData user ;
  dynamic orderData;
  @override
  Widget build(BuildContext context) {
    _store.getUser().then((value){
      if(loading)
        setState(() {
          user = value;
          orderData = user.orders;
          loading = false;
        });
    });
    return loading? Center(child: CircularProgressIndicator(),):
      Scaffold(
      appBar: AppBar(title: Text('Orders',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1 ),),centerTitle: true,),
      backgroundColor: Colors.grey[100],
      body: Container(child: ListView.builder(
        itemCount: orderData.length,
          itemBuilder: (ctx, index) {
        return OrderItem(pid :orderData[index]);
      })),
    );
  }
}
class OrderItem extends StatefulWidget {
  String pid;
  Product a;
_orderIemState createState() => _orderIemState();
 OrderItem({this.pid});

}
class _orderIemState extends State<OrderItem>{
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
    return loading? Container()
     : Container(
      height: MediaQuery.of(context).size.height * .2,
      padding: EdgeInsets.all(8),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * .3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.a.productImage,
                        fit: BoxFit.cover,
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title : '+ widget.a.name),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('price : '+widget.a.price),

                      ],
                    )
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
