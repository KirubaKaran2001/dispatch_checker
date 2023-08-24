// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';


class Dummy extends StatelessWidget {
  const Dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: Home()),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int ? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item: $index'),
          tileColor: selectedIndex == index ? Colors.blue : null,
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
        );
      },
    );
  }
}