import 'package:cardless/constants.dart';
import 'package:cardless/screens/card_image_screen.dart';
import 'package:cardless/services/database.dart';
import 'package:flutter/material.dart';

import '../models/ShoppingCard.dart';

class CardListWidget extends StatefulWidget {
  final List<ShoppingCard> cards;
  final VoidCallback refreshData;
  const CardListWidget(
      {Key? key, required this.cards, required this.refreshData})
      : super(key: key);

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CardImageScreen(
                                cardId: widget.cards[index].id!,
                              )));
                },
                title: Text(
                  widget.cards[index].name,
                  style: TextStyle(
                      fontSize: 18,
                      color: Constants.kQuinaryColor,
                      fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('Warning'),
                                content: Text(
                                    'Are you sure want to delete ${widget.cards[index].name} card'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        CardDatabase.instance.deleteCard(
                                            widget.cards[index].id!);
                                        Navigator.pop(context);
                                        widget.refreshData();
                                      },
                                      child: Text('Yes')),
                                ],
                              ));
                    },
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    )),
              ),
            ),
        separatorBuilder: (_, __) => Divider(),
        itemCount: widget.cards.length);
  }
}
