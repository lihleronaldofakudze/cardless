import 'package:cardless/services/database_service.dart';
import 'package:cardless/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CardImageScreen extends StatefulWidget {
  final String? cardName;
  const CardImageScreen({
    Key? key,
    this.cardName,
  }) : super(key: key);

  @override
  State<CardImageScreen> createState() => _CardImageScreenState();
}

class _CardImageScreenState extends State<CardImageScreen> {
  late String barcode;
  bool _isLoading = false;

  getBarcode(String cardName) async {
    setState(() {
      _isLoading = true;
    });
    await DatabaseService().getString(cardName).then((value) {
      setState(() {
        barcode = value!;
        _isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Error',
        desc: '$onError',
        btnOkOnPress: () {},
      ).show();
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getBarcode(widget.cardName!);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingWidget()
        : Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.control_camera_rounded),
              label: Text('Scan Card'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/scan_card',
                  arguments: widget.cardName,
                );
              },
            ),
            appBar: AppBar(
              title: Text(widget.cardName!),
            ),
            body: Center(
              child: Container(
                height: 200,
                child: SfBarcodeGenerator(
                  value: barcode,
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
