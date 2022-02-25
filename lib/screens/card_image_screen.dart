import 'dart:io';

import 'package:cardless/models/ShoppingCard.dart';
import 'package:cardless/models/Utility.dart';
import 'package:cardless/services/database.dart';
import 'package:cardless/widgets/custom_button_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardImageScreen extends StatefulWidget {
  const CardImageScreen({Key? key}) : super(key: key);

  @override
  _CardImageScreenState createState() => _CardImageScreenState();
}

class _CardImageScreenState extends State<CardImageScreen> {
  PickedFile _imageFile = PickedFile('');

  _takeImageFromCamera() async {
    await ImagePicker().pickImage(source: ImageSource.camera).then((imgFile) {

      setState(() {
        _imageFile = PickedFile(imgFile!.path);
      });
    });
    
  }

  _saveImageToDatabase({required int id, required String name}) {
    String imageString =
          Utility.base64String(File(_imageFile.path).readAsBytesSync());
      ShoppingCard card = ShoppingCard(id: id, name: name, image: imageString);
      CardDatabase.instance.updateCard(card);
  }

  @override
  Widget build(BuildContext context) {
    final ShoppingCard card =
        ModalRoute.of(context)!.settings.arguments as ShoppingCard;
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                  image:
                      DecorationImage(image: FileImage(File(_imageFile.path)))),
              child: Center(
                child: _imageFile.path == ''
                    ? IconButton(
                        onPressed: () =>
                            _takeImageFromCamera(),
                        icon: Icon(
                          Icons.camera_rounded,
                          size: 50,
                        ),
                      )
                    : SizedBox(),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonIconWidget(onClick: () =>  _takeImageFromCamera(), primaryColor: Colors.orange, text: 'Change Image'),
                CustomButtonIconWidget(onClick: () => _saveImageToDatabase(id: card.id!, name: card.name), primaryColor: Colors.green, text: 'Save Image')
              ],
            )
          ],
        ),
      ),
    );
  }
}
