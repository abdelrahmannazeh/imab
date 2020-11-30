class Product{
  String pid;
  String name;
  String description;
  String price;
  String productImage;
  Product({ this.pid, this.name, this.description, this.price, this.productImage });

  factory Product.fromMap(Map<String, dynamic> map, dynamic pid, dynamic productImage) {
    if (map == null) return null;

    return Product(
      pid: pid,
      name: map['name'],
      description: map['description'],
      price: map['price'],
      productImage: productImage

    );
  }
}