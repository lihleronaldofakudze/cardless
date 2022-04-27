import 'package:cardless/constants.dart';
import 'package:cardless/lists/card_list.dart';
import 'package:cardless/models/ShoppingCard.dart';
import 'package:cardless/services/database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ShoppingCard> cards = [];
  bool isLoading = false;

  _refreshCards() async {
    setState(() {
      isLoading = true;
    });

    cards = await CardDatabase.instance.getCards();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kPrimaryColor,
        title: const Text('My Cards'),
      ),
      body: CardList(),
    );
  }
}
