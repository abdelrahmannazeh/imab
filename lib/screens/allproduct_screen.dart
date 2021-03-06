import 'package:flash_chat/model/product.dart';
import 'package:flash_chat/screens/details_screen.dart';
import 'package:flash_chat/services/storage.dart';
import 'package:flash_chat/services/store.dart';
import 'package:flutter/material.dart';

class AllProductScreen extends StatefulWidget {
  static final String id = 'allproduct';

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}
StoreService _store = StoreService();


class _AllProductScreenState extends State<AllProductScreen> {

  bool loading = true;
  int selected = 0;
  List<Product> test;

  @override
  Widget build(BuildContext context) {
    _store.getProducts().then((value){
      if (loading)
        setState(() {
          test = value;
          print(test[0].productImage);
          loading = false;
        });
      });
    return Scaffold(
      appBar: AppBar(
        title: Text('All Product'),
        centerTitle: true,
      ),
      body: loading? Center(child: CircularProgressIndicator(),):Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index){ return _BuildAllProductItem(imageUrl: test[index].productImage,title: test[index].name,price: test[index].price == null ? 'null':test[index].price+'\$',dis: test[index].description,pid:test[index].pid);},
            itemCount: test.length,
          ),
      ),
    );
  }

  
}

class _BuildAllProductItem extends StatelessWidget {
  String imageUrl  ;
  String title ;
  String dis;
  String price;
  String pid;

  _BuildAllProductItem({this.imageUrl ,this.title ,this.price ,this.dis,this.pid});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsScreen(imageUrl: this.imageUrl,title: this.title,dis: this.dis,price: this.price,pid:this.pid)));
        },
              child: GridTile(
          child:Image.network(
            this.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(this.title),
            trailing: Text(
              this.price,
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
