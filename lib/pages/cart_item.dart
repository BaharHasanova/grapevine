class CartItem {
  final String name;
  final String description;
  final int price;
  int quantity;
  bool isSelected;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 1,
    this.isSelected = false,
  });

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
