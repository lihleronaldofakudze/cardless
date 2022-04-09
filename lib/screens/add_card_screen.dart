import 'package:cardless/constants.dart';
import 'package:cardless/models/ShoppingCard.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../services/database.dart';

class AddCardScreen extends StatefulWidget {
  AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _cardNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kPrimaryColor,
        title: const Text('Create Card'),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(
              autofocus: true,
              controller: _cardNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter card store name')),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveCardDetails,
                child: Text('Save'),
                style:
                    ElevatedButton.styleFrom(primary: Constants.kQuinaryColor),
              ),
            ),
          ])),
    );
  }

  _saveCardDetails() {
    if (_cardNameController.text.isNotEmpty) {
      ShoppingCard card =
          new ShoppingCard(name: _cardNameController.text, image: '');
      CardDatabase.instance.addCard(card);

      _cardNameController.clear();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Card Added',
        desc: 'Card added successfully',
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      )..show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Error',
        desc: 'Please enter a valid card name',
        btnOkOnPress: () {},
      ).show();
    }
  }
}
