class Product{
  String pid;
  String name;
  String description;
  String price;
  Product({ this.pid, this.name, this.description, this.price });

  factory Product.fromMap(Map<String, dynamic> map, dynamic pid) {
    if (map == null) return null;

    return Product(
      pid: pid,
      name: map['name'],
      description: map['description'],
      price: map['price']

    );
  }
}