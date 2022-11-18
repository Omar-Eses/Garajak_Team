import 'package:flutter/material.dart';
import 'login.dart';
import 'list.dart';
import 'edit.dart';
import 'add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': ((context) => const LoginPage()),
        '/list': ((context) => const ListPage()),
        '/edit': ((context) => const EditPage()),
        '/add': ((context) => const AddPage())
      },
    );
  }
}
