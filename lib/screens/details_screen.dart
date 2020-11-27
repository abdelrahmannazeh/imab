import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  String imageUrl = '';
  DetailsScreen({@required  this.imageUrl});

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    final text =
        "long long discreption that have more than 3 lines long long discreption that have more than 3 lines long long discreption that have more than 3 lines long long discreption that have more than 3 lines long long discreption that have more than 3 lines long long discreption that have more than 3 lines long long discreption that have more than 3 lines long long discreption that have more than 3 lines";
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          myappbar(context, imageUrl),
          // SliverFixedExtentList(
          //     delegate: SliverChildListDelegate([
          //       Container(color: Colors.green,),
          //       Container(color: Colors.blue,),
          //       Container(color: Colors.yellow,),
          //     ]), itemExtent: MediaQuery.of(context).size.height/3),
          labelAndDiscription("product name", text),
          // SliverGrid(
          //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          //     mainAxisSpacing: 10.0,
          //     crossAxisSpacing: 10.0,
          //   ),
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       return Container(
          //         color: Colors.yellow,
          //         margin: EdgeInsets.all(10),
          //       );
          //     },
          //     childCount: 4,
          //   ),
          // ),
          //
          //
          // add to cart and add to favorite buttons
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
                          onPressed: () {},
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
        background: Container(margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * .04 ) ,child: Image(image: AssetImage(this.imageUrl))),
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
