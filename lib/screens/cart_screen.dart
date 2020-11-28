import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){}),
        ],
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return CartItem(title: 'hello',image: 'https://picsum.photos/250?image=2',price: '30\$',);
          },
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {

  String title;
  String image;
  String price;

  CartItem({this.title,this.image,this.price});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      // margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: .8),),
                Text(widget.price,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: .8),),
                Row(
                  children: [
                    RaisedButton(
                      child: Text('buy'),
                      onPressed: () {},
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .05,),
                    RaisedButton(
                      color: Theme.of(context).errorColor,
                      child: Text(
                        'cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
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
