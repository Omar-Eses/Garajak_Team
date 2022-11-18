import 'package:flutter/material.dart';
import 'list.dart';
import 'garages.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AddGarage(),
          ElevatedButton(
            child: const Text('add a new item'),
            onPressed: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
        ],
      ),
    );
  }
}

class AddGarage extends StatefulWidget {
  List? addList;
  Garages? garages;
  AddGarage({Key? key, Garages? garages}) : super(key: key) {
    garages = Garages.getNew();
  }

  @override
  State<AddGarage> createState() => _AddGarageState();
}

class _AddGarageState extends State<AddGarage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    //final args = ModalRoute.of(context)!.settings.arguments as Garages?;
    //int i = widget.addList!.length;
    widget.garages = Garages.getNew();
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.garages!.garageName,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'garage name',
                  helperText: '*',
                  prefixIcon: Icon(Icons.garage),
                ),
                // keyboardType: TextInputType.,
                validator: (newValue) {
                  if (newValue!.isEmpty) {
                    return "please enter garage name!";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  widget.garages!.garageName = newValue!;
                },
              ),
              TextFormField(
                initialValue: widget.garages!.startingPrices.toString(),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'starting price',
                  helperText: '*',
                  prefixIcon: Icon(Icons.monetization_on),
                ),
                keyboardType: TextInputType.number,
                validator: (newValue) {
                  double price = double.tryParse(newValue!) ?? 0;
                  if (price >= 50 && price <= 250) {
                    return r"starting price should be between 50JD and 250JD";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  widget.garages!.startingPrices =
                      double.tryParse(newValue!) ?? 50;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    Navigator.pop(context);

                    widget.addList!.insert(31, context);
                  } else {
                    formKey.currentState!.reset();
                  }
                  Navigator.pushNamed(context, '/list');
                },
                child: const Icon(Icons.save, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
