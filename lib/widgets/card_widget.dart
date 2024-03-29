import 'package:cardless/screens/card_image_screen.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String cardName;
  final String cardImage;
  final int cardNumber;
  const CardWidget({
    Key? key,
    required this.cardName,
    required this.cardImage,
    required this.cardNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardImageScreen(
              cardName: cardName,
            ),
          ),
        );
      },
      child: PhysicalModel(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(cardImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
