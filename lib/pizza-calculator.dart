import 'package:flutter/material.dart';
import 'package:pizza_calculator/new-pizza-form.dart';
import 'package:pizza_calculator/pizza-calculator-item.dart';
import 'package:pizza_calculator/pizza-calculator-list.dart';
import 'package:pizza_calculator/pizza.dart';

class _CalculatorInherited extends InheritedWidget {
  _CalculatorInherited({Key key, Widget child, this.data})
      : super(key: key, child: child);

  final _CalculatorInheritedWidgetState data;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }
}

class CalculatorInheritedWidget extends StatefulWidget {
  CalculatorInheritedWidget({this.child});

  final Widget child;

  @override
  _CalculatorInheritedWidgetState createState() =>
      _CalculatorInheritedWidgetState();

  static _CalculatorInheritedWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_CalculatorInherited)
            as _CalculatorInherited)
        .data;
  }
}

class _CalculatorInheritedWidgetState extends State<CalculatorInheritedWidget> {
  @override
  Widget build(BuildContext context) {
    return _CalculatorInherited(data: this, child: widget.child);
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<Pizza> _pizzas = [];
  Pizza _lastDeletedPizza;

  void _onAddNewPizza(Pizza p) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Added new Pizza ${p.name}')));
    setState(() {
      _pizzas.add(p);
    });
    Navigator.pop(context);
  }

  void _onDeletePizza(Pizza p) {
    _lastDeletedPizza = p;
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Pizza ${p.name} deleted'),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _pizzas.add(_lastDeletedPizza);
            });
          },
        ),
      ),
    );
    setState(() {
      _pizzas.remove(p);
    });
  }

  void _onUpdatePizza(Pizza old) {
    PizzaForm.showPizzaDialog(context, (Pizza p) {
      final index = _pizzas.indexOf(old);
      setState(() {
        _pizzas[index] = p;
        Navigator.pop(context);
      });
    }, pizza: old, title: "Edit Pizza");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PizzaForm.showPizzaDialog(context, _onAddNewPizza);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: PizzaCalculatorList(_pizzas, _onDeletePizza, _onUpdatePizza),
    );
  }
}
