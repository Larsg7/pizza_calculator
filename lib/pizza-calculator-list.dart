import 'package:flutter/material.dart';
import 'package:pizza_calculator/pizza-calculator-item.dart';
import 'package:pizza_calculator/pizza.dart';
import 'package:pizza_calculator/utils.dart';

class PizzaCalculatorList extends StatelessWidget {
  final List<Pizza> _pizzas;
  final DeletePizzaItem deletePizzaItem;
  final UpdatePizzaItem updatePizzaItem;

  PizzaCalculatorList(this._pizzas, this.deletePizzaItem, this.updatePizzaItem);

  @override
  Widget build(BuildContext context) {
    final pizzas = Utils.sortPizzasByRatio(_pizzas);
    return pizzas.length > 0
        ? ListView(
            children: pizzas
                .map((Pizza p) =>
                    PizzaCalculatorItem(p, deletePizzaItem, updatePizzaItem))
                .toList(),
          )
        : Center(
            child: Text(
              "No Pizzas added",
            ),
          );
  }
}
