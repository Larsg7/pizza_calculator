class Pizza {
  String name;
  double price;
  double size;

  Pizza(this.name, this.price, this.size);

  double get pricePerSize {
    return this.price / this.size;
  }
}
