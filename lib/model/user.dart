class UserData{
  dynamic cart;
  dynamic orders;
  UserData({ this.cart, this.orders });

  factory UserData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserData(
      cart: map['cart'],
      orders: map['orders']
    );
    
  }


}
