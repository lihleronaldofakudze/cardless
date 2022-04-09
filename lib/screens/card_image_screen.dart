import 'dart:io';

import 'package:cardless/constants.dart';
import 'package:cardless/models/ShoppingCard.dart';
import 'package:cardless/services/database.dart';
import 'package:cardless/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class CardImageScreen extends StatefulWidget {
  final int? cardId;
  const CardImageScreen({Key? key, this.cardId}) : super(key: key);

  @override
  _CardImageScreenState createState() => _CardImageScreenState();
}

class _CardImageScreenState extends State<CardImageScreen> {
  bool _isLoading = false;
  File _imageFile = File('');
  late ShoppingCard _shoppingCard;

  getCard() async {
    setState(() {
      _isLoading = true;
    });
    _shoppingCard = await CardDatabase.instance.getCard(widget.cardId!);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCard();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingWidget()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.kPrimaryColor,
              title: Text(_shoppingCard.name),
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _imageFile.path == ''
                      ? _shoppingCard.image != ''
                          ? Image.file(File(_shoppingCard.image))
                          : Container(
                              height: 240,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'No image',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                      : Image.file(File(_imageFile.path)),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          autofocus: true,
                          onPressed: _takeImageFromCamera,
                          child: Text(_shoppingCard.image == ''
                              ? 'Take Image'
                              : 'Change Image')),
                      OutlinedButton(
                        onPressed: _saveImage,
                        child: Text('Save Image'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }

  _takeImageFromCamera() async {
    ImagePicker().pickImage(source: ImageSource.camera).then((recordedImage) {
      setState(() {
        _isLoading = true;
      });
      GallerySaver.saveImage(recordedImage!.path).then((path) {
        setState(() {
          _imageFile = File(recordedImage.path);
          _isLoading = false;
        });
      });
    });
  }

  _saveImage() async {
    setState(() {
      _isLoading = true;
    });
    ShoppingCard card = ShoppingCard(
      id: _shoppingCard.id,
      name: _shoppingCard.name,
      image: _imageFile.path,
    );
    CardDatabase.instance.updateCard(card);

    setState(() {
      _isLoading = false;
    });
  }
}
