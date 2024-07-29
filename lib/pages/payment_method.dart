class PaymentMethod {
  String title;
  String logoAsset;
  bool isSelected;

  PaymentMethod({
    required this.title,
    required this.logoAsset,
    this.isSelected = false,
  });
}
