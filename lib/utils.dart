import 'package:pizza_calculator/pizza.dart';

class Utils {
  static List<Pizza> sortPizzasByRatio(List<Pizza> pizzas) {
    final p = List<Pizza>.from(pizzas);
    p.sort((p1, p2) {
      return p1.pricePerSize.compareTo(p2.pricePerSize);
    });
    return p;
  }

  static String formatDouble(double d) {
    return d.toStringAsFixed(2);
  }
}
