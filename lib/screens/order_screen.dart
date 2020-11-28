import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1 ),),centerTitle: true,),
      backgroundColor: Colors.grey[100],
      body: Container(child: ListView.builder(itemBuilder: (ctx, index) {
        return OrderItem(title: 'T-shert', price: '20\$',amount: '2',total: '40\$',);
      })),
    );
  }
}

class OrderItem extends StatelessWidget {
  String imageUrl;
  String title;
  String price;
  String amount;
  String total;

  OrderItem({this.imageUrl = 'https://picsum.photos/250?image=2' , this.title , this.price , this.amount , this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        imageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title : '+ this.title),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('price : '+this.price),
                        SizedBox(
                          width: 10,
                        ),
                        Text('amount : '+ this.amount),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text('\$'+this.total),
              ),
            ),
          ],
        ),
      ),
    );
  }
}