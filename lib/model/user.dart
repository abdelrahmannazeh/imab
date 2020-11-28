class UserData{
  List<String> cart;
  List<String> orders;
  UserData({ this.cart, this.orders });

  get getCart {
    return cart;
  }
}