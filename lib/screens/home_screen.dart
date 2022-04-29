import 'package:cardless/constants.dart';
import 'package:cardless/lists/card_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Constants.kPrimaryColor,
        title: const Text('My Cards'),
      ),
      body: CardList(),
    );
  }
}
