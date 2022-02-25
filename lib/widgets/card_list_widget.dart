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
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/card_image',
                    arguments: widget.cards[index]);
              },
              title: Text(
                widget.cards[index].name,
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    CardDatabase.instance.deleteCard(widget.cards[index].id!);
                    widget.refreshData();
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  )),
            ),
        separatorBuilder: (_, __) => Divider(),
        itemCount: widget.cards.length);
  }
}
