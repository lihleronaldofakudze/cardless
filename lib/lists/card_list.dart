import 'package:cardless/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(15.0),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: (MediaQuery.of(context).size.width / 180),
      children: [
        CardWidget(
          cardName: 'Pick n Pay',
          cardImage: 'assets/images/pick-n-pay-logo.png',
          cardNumber: 1,
        ),
        CardWidget(
          cardName: 'Clicks',
          cardImage: 'assets/images/clicks.jpeg',
          cardNumber: 2,
        ),
      ],
    );
  }
}
