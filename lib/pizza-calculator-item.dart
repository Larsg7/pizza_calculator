import 'package:flutter/material.dart';
import 'package:pizza_calculator/pizza.dart';
import 'package:pizza_calculator/utils.dart';

typedef DeletePizzaItem = void Function(Pizza p);
typedef UpdatePizzaItem = void Function(Pizza p);

class PizzaCalculatorItem extends StatelessWidget {
  final Pizza _pizza;
  final DeletePizzaItem onDeletePizza;
  final UpdatePizzaItem onUpdatePizza;

  PizzaCalculatorItem(this._pizza, this.onDeletePizza, this.onUpdatePizza);

  @override
  Widget build(BuildContext context) {
    final smallTextStyle = TextStyle(fontSize: 20);
    final ratioTextStyle = TextStyle(
        fontSize: smallTextStyle.fontSize, fontWeight: FontWeight.bold);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.local_pizza),
                  Text(
                    _pizza.name,
                    style: TextStyle(fontSize: 25),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      onDeletePizza(_pizza);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      onUpdatePizza(_pizza);
                    },
                  )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      Text("${Utils.formatDouble(_pizza.price)}",
                          style: smallTextStyle),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.aspect_ratio),
                      Text(" ${Utils.formatDouble(_pizza.size)}",
                          style: smallTextStyle),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "\$/Size ",
                        style: ratioTextStyle,
                      ),
                      Text("${Utils.formatDouble(_pizza.pricePerSize)}",
                          style: ratioTextStyle),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
