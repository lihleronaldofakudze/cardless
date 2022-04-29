import 'dart:io';

import 'package:cardless/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanCardScreen extends StatefulWidget {
  const ScanCardScreen({Key? key}) : super(key: key);

  @override
  State<ScanCardScreen> createState() => _ScanCardScreenState();
}

class _ScanCardScreenState extends State<ScanCardScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String cardName =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      floatingActionButton: result != null
          ? FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () async {
                if (result != null) {
                  DatabaseService().setString(
                    '${cardName}',
                    result!.code.toString(),
                  );
                }
                Navigator.pushNamed(context, '/');
              },
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(cardName),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          _buildQRView(),
          Positioned(
            bottom: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(result != null
                  ? 'Result : ${result!.code}'
                  : 'Scan the QR code'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRView() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 300,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
