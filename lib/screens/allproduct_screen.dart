import 'package:flash_chat/model/product.dart';
import 'package:flash_chat/services/store.dart';
import 'package:flutter/material.dart';

class AllProductScreen extends StatefulWidget {
  static final String id = 'allproduct';

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}
StoreService _store = StoreService();
 List<Product> test = [];

class _AllProductScreenState extends State<AllProductScreen> {
  
  bool loading = true;
  int selected = 0;

  void getAll(){
    setState(() async {
      test = await _store.getProducts();
      print(test.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    _store.getProducts().then((value){
        setState(() {
          test = value;
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
          itemBuilder: (ctx, index){ return _BuildAllProductItem(imageUrl: 'https://picsum.photos/250?image=2',title: test[index].name,price: test[index].price == null ? 'null':test[index].price+'\$',);},
          itemCount: test.length,
        ),
      ),
    );
  }

  
}

class _BuildAllProductItem extends StatelessWidget {
  String imageUrl  ;
  String title ;
  String price;

  _BuildAllProductItem({this.imageUrl ,this.title ,this.price });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridTile(
        child: Image.network(
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
    );
  }
}
