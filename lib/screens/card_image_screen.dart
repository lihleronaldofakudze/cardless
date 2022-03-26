import 'dart:io';

import 'package:cardless/models/ShoppingCard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cardless/services/database.dart';
import 'package:cardless/widgets/custom_button_icon_widget.dart';
import 'package:cardless/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardImageScreen extends StatefulWidget {
  final int cardId;
  const CardImageScreen({Key? key, required this.cardId}) : super(key: key);

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
    _shoppingCard = await CardDatabase.instance.getCard(widget.cardId);
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
              title: Text(_shoppingCard.name),
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _imageFile.path == ''
                      ? Image.file(File(_shoppingCard.image))
                      : Image.file(File(_imageFile.path)),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButtonIconWidget(
                        onClick: () => _takeImageFromCamera(),
                        primaryColor: Colors.red,
                        text: 'Change Image',
                        icon: Icons.save_rounded,
                      ),
                      CustomButtonIconWidget(
                        onClick: () => _saveImage(),
                        primaryColor: Colors.green,
                        text: 'Save Image',
                        icon: Icons.save_rounded,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }

  _takeImageFromCamera() async {
    setState(() {
      _isLoading = true;
    });
    await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((imgFile) async {
      setState(() {
        _imageFile = File(imgFile!.path);
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  _saveImage() async {
    setState(() {
      _isLoading = true;
    });
    final Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    final String fileName = '$path/${_shoppingCard.name}.jpg';
    final File localImage = await _imageFile.copy(fileName);
    print('Local Image Path : ${localImage.path}');
    ShoppingCard card = ShoppingCard(
        name: _shoppingCard.name, image: localImage.path.toString());
    await CardDatabase.instance.updateCard(card).then((value) {
      print('success $value');
    }).catchError((onError) {
      print('failure $onError');
    });
    setState(() {
      _isLoading = false;
    });
  }
}
