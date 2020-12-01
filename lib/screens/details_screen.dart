import 'package:flash_chat/services/store.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  String imageUrl;
  String title ;
  String dis;
  String price;
  String pid;
  DetailsScreen({@required  this.imageUrl,this.title,this.price,this.dis,this.pid});
  StoreService _store = StoreService();
  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          myappbar(context, imageUrl),
          
          labelAndDiscription(this.title, this.dis),
          
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: RaisedButton(
                          child: Text("add to cart"),
                          onPressed: () async{
                            await _store.addToCart(pid);
                          },
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          icon: Icon(Icons.favorite_border), onPressed: () {}))
                ],
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }

  Widget myappbar(context, String imageUrl) {
    return SliverAppBar(
      title: Text(''),
      pinned: true,
      floating: true,
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: MediaQuery.of(context).size.height * .4,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * .04 ) ,child: Image(image: NetworkImage(this.imageUrl))),
      ),
    );
  }

  Widget labelAndDiscription(String name, String dis) {
    return Container(
      child: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
                    child: ListTile(
                      title: Text(
                        name,
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        dis,
                        style: TextStyle(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }, childCount: 1),
      ),
    );
  }
}
