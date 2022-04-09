import 'package:cardless/constants.dart';
import 'package:cardless/widgets/card_list_widget.dart';
import 'package:cardless/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../models/ShoppingCard.dart';
import '../services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cardNameController = TextEditingController();
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add_card');
        },
        label: Text('Add Card'),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Constants.kPrimaryColor,
        title: const Text('My Cards'),
        actions: [
          IconButton(onPressed: _refreshCards, icon: Icon(Icons.refresh)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshCards(),
        child: isLoading
            ? LoadingWidget()
            : CardListWidget(
                cards: cards,
                refreshData: _refreshCards,
              ),
      ),
    );
  }
}
