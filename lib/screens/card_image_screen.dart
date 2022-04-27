import 'package:cardless/models/ShoppingCard.dart';
import 'package:cardless/services/database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class CardImageScreen extends StatefulWidget {
  final String? cardName;
  final int? cardNumber;
  const CardImageScreen({
    Key? key,
    this.cardName,
    this.cardNumber,
  }) : super(key: key);

  @override
  State<CardImageScreen> createState() => _CardImageScreenState();
}

class _CardImageScreenState extends State<CardImageScreen> {
  late ShoppingCard? _card;
  bool _isLoading = true;

  _getData() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.cardNumber != null) {
      _card = (await CardDatabase.instance.getCard(widget.cardNumber!))!;
    }

    setState(() {
      _isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final String cardName =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.control_camera_rounded),
        label: Text('Scan Card'),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/add_card',
            arguments: cardName,
          );
        },
      ),
      appBar: AppBar(
        title: Text(cardName),
      ),
      body: _card == null
          ? Center(
              child: Container(
                height: 200,
                child: SfBarcodeGenerator(
                  value: '99999999999999999',
                  showValue: true,
                  textSpacing: 24,
                  textStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : Center(
              child: Container(
                height: 200,
                child: SfBarcodeGenerator(
                  value: _card!.barcode,
                  showValue: true,
                  textSpacing: 24,
                  textStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
    );
  }
}
