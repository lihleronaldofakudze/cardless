import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Utility {
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64String(String base4String) {
    return Image.memory(
      base64Decode(base4String),
      fit: BoxFit.fill,
    );
  }
}
