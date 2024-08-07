class CartItem {
  final String name;
  final String description;
  final double price;
  String imageUrl;
  int quantity;
  List<String> availableSizes;
  String selectedSize;
  bool isSelected;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    this.availableSizes = const ['S', 'M', 'L', 'XL'],
    this.selectedSize = 'M',
    this.isSelected = false,
  });

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 1) quantity--;
  }
}
