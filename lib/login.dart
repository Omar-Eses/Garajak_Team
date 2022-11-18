import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login page')),
      body: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username",
                hintText: "Enter username",
                helperText: "* Required!",
                prefixIcon: Icon(Icons.account_circle),
              ),
              keyboardType: TextInputType.name,
              validator: (newValue) {
                newValue = newValue ?? '';
                if (newValue.trim().length < 6) {
                  return "student name is required";
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(newValue!.toUpperCase()),
                ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "password",
                hintText: "Enter password",
                helperText: "* Required!",
                prefixIcon: Icon(Icons.password),
              ),
              validator: (newValue) {
                newValue = newValue ?? '';
                if (newValue.trim().length == 0) {
                  return "please enter password!";
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {},
            ),
          ),
          ElevatedButton(
            child: const Icon(Icons.login),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('successfully logged in'),
                ));
                /*_formKey.currentState!.save();*/
                Navigator.pushNamed(context, '/list');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('fill in username/password'),
                ));
                _formKey.currentState!.reset();
              }
            },
          )
        ],
      ),
    );
  }
}
