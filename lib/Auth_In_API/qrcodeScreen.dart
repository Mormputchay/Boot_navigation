import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});
  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("QR Code"),
      ),
      body: Builder(
        builder: (context) => Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: const Text("Start BarCode scan"))
            ],
          ),
        ),
      ),
    );
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScannerRes;
    try {
      barcodeScanner = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666','Cancel' , true, ScanMode.BARCODE);
      debugPrint(barcodeScannerRes);

    }
  }
}
