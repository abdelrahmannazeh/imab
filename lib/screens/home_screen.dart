import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/MyDrawerBuilder.dart';
import 'package:flash_chat/model/product.dart';
import 'package:flash_chat/model/user.dart';
import 'package:flash_chat/services/store.dart';
import 'package:flutter/material.dart';
import 'details_screen.dart';
class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  Product product;
  Future<dynamic> getProduct(String pid) async {

    await products.doc(pid).get().then<dynamic>((value) {

      setState(() {
        product = Product(pid: pid, name:  value.get('name'),
        description:  value.get('description'),
        price:  value.get('price'));
      });
    }).catchError((e) => null);
  }


  int selected = 0;
  List<UserData> user;
  // List<Product> product;
  Product productpiece;
  StoreService _store = StoreService();
  @override
  Widget build(BuildContext context) {
    // getProduct('JaReTjWtDIBnhwDIaxBj');
    // print(product.price);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () async{

              // productpiece = await _store.getProduct('JaReTjWtDIBnhwDIaxBj').price;
              // print(await _store.getProduct('JaReTjWtDIBnhwDIaxBj'));
              // product = await _store.getProducts();
              // print(product[0].description);
              // user = await _store.getUser();
              // print(user[0].cart);


            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MySearch());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: MyDrawerBuilder(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  barBetween("offers"),
                  elementBuilder(context, 10, false),
                  barBetween("most pobular"),
                  elementBuilder(context, 10, true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget barBetween(String listName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            listName,
            style: TextStyle(fontSize: 18),
          ),
          IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    );
  }

  Widget elementBuilder(context, int elementNumber, bool x) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: x,
        itemBuilder: (ctx, index) {
          return Container(
            margin: EdgeInsets.all(11),
            width: MediaQuery.of(context).size.width * 2 / 5 - 20,
            child: GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsScreen(imageUrl: "assets/Products/product(${index}).png",)));},
              child: GridTile(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image(
                    image: AssetImage('assets/Products/product(${index}).png'),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: elementNumber,
      ),
    );
  }
}

//======================================================================
//== search class
//======================================================================
class MySearch extends SearchDelegate<String> {
  List<String> hestory = ["abo al 7md", "nazeh", "rob3"];

  List<String> search = [
    "abo al 7md",
    "nazeh",
    "rob3",
    "basam",
    "abo al dhb ",
    "bebo"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sug = query.isEmpty
        ? hestory
        : search.where((e) => e.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListTile(
          onTap: () {
            showResults(context);
          },
          title: RichText(
            text: TextSpan(
                text: sug[index].substring(0, query.length),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
                children: [
                  TextSpan(
                    text: sug[index].substring(query.length),
                    style: TextStyle(color: Colors.grey, letterSpacing: 1),
                  )
                ]),
          ),
        );
      },
      itemCount: sug.length,
    );
  }
}
