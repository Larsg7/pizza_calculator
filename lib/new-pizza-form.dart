import 'package:flutter/material.dart';
import 'package:pizza_calculator/pizza.dart';

class PizzaForm extends StatefulWidget {
  final SubmitNewPizzaForm onSubmit;
  final Pizza pizza;

  PizzaForm({@required this.onSubmit, this.pizza});

  static void showPizzaDialog(BuildContext context, SubmitNewPizzaForm submit,
      {Pizza pizza, String title}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title ?? "Add a new pizza",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  PizzaForm(
                    onSubmit: submit,
                    pizza: pizza,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  _PizzaFormState createState() => _PizzaFormState(this.onSubmit, this.pizza);
}

typedef SubmitNewPizzaForm = void Function(Pizza p);

class _PizzaFormState extends State<PizzaForm> {
  final _formKey = GlobalKey<FormState>();
  final pizzaNameController = TextEditingController();
  final pizzaPriceController = TextEditingController();
  final pizzaSizeController = TextEditingController();
  final SubmitNewPizzaForm _submit;

  _PizzaFormState(this._submit, Pizza pizza) {
    if (pizza != null) {
      pizzaNameController.text = pizza.name;
      pizzaSizeController.text = pizza.size.toString();
      pizzaPriceController.text = pizza.price.toString();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    pizzaNameController.dispose();
    pizzaPriceController.dispose();
    pizzaSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: pizzaNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Name cannot be empty';
                }
              },
              decoration: InputDecoration(
                  labelText: "Name of pizza",
                  prefixIcon: Icon(Icons.local_pizza)),
            ),
            TextFormField(
              controller: pizzaPriceController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Price cannot be empty';
                }
                if (!(double.tryParse(value) is double)) {
                  return 'Price must be number!';
                }
              },
              decoration: InputDecoration(
                  labelText: "Price", prefixIcon: Icon(Icons.attach_money)),
            ),
            TextFormField(
              controller: pizzaSizeController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Size cannot be empty';
                }
                if (!(double.tryParse(value) is double)) {
                  return 'Size must be number!';
                }
              },
              decoration: InputDecoration(
                  labelText: "Size", prefixIcon: Icon(Icons.aspect_ratio)),
            ),
            FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  this._submit(Pizza(
                      pizzaNameController.text,
                      double.parse(pizzaPriceController.text),
                      double.parse(pizzaSizeController.text)));
                  _formKey.currentState.reset();
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20),
              ),
            )
          ],
        ));
  }
}
