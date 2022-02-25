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
      appBar: AppBar(
        title: const Text('My Cards'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(
                            'Add new card',
                            textAlign: TextAlign.center,
                          ),
                          content: SingleChildScrollView(
                            child: TextField(
                              controller: _cardNameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Enter card store name')),
                            ),
                          ),
                          actions: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_cardNameController.text.isNotEmpty) {
                                    ShoppingCard card = new ShoppingCard(
                                        name: _cardNameController.text,
                                        image: '');
                                    CardDatabase.instance.addCard(card);
                                    _refreshCards();
                                    Navigator.pop(context);
                                    _cardNameController.clear();
                                  } else {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        new SnackBar(
                                            content: Text(
                                                'Please enter card store name first.')));
                                  }
                                },
                                child: Text('Save'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                              ),
                            ),
                          ],
                        ));
              },
              icon: const Icon(Icons.add_rounded))
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
