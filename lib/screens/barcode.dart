import 'package:CVAPP/constants/theme.dart';
import 'package:CVAPP/providers/barcode.dart';
import 'package:CVAPP/providers/barcode.dart';
import 'package:CVAPP/providers/barcode.dart';

import 'package:CVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Barcode extends StatefulWidget {
  @override
  _BarcodeState createState() => _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
  Future<void> _refreshHistory(BuildContext context) async {
    await Provider.of<BarCodeData>(context, listen: false).fetchBarCodeData();
  }

  List<bool> _isHighlighted = [true, false];
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MaterialColors.bgColorScreen,
      // key: _scaffoldKey,
      //drawer: MaterialDrawerC(currentPage: "Home"),
      drawer: SideMenu(
        currentPage: "BarCode",
        firstName: 'Pavan',
        lastName: 'Guduru',
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: FutureBuilder(
            future: _refreshHistory(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _refreshHistory(context),
                        child: GestureDetector(
                          onScaleStart: (ScaleStartDetails details) {
                            print(details);
                            _previousScale = _scale;
                            setState(() {});
                          },
                          onScaleUpdate: (ScaleUpdateDetails details) {
                            print(details);
                            _scale = _previousScale * details.scale;
                            setState(() {});
                          },
                          onScaleEnd: (ScaleEndDetails details) {
                            print(details);

                            _previousScale = 1.0;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.diagonal3(
                                  Vector3(_scale, _scale, _scale)),
                              child: Consumer<BarCodeData>(
                                  builder: (ctx, barCodedata, _) => Padding(
                                      padding: EdgeInsets.all(8),
                                      child: GestureDetector(
                                          onScaleStart:
                                              (ScaleStartDetails details) {
                                            print('Scale');
                                          },
                                          child: InteractiveViewer(
                                            panEnabled:
                                                false, // Set it to false to prevent panning.
                                            boundaryMargin: EdgeInsets.all(80),
                                            minScale: 0.5,
                                            maxScale: 4,
                                            child: SfBarcodeGenerator(
                                              value:
                                                  "wwww.darrylbrown.com Data: " +
                                                      barCodedata.barCodeData,
                                              symbology: QRCode(),
                                              showValue: false,
                                            ),
                                          )))),
                            ),
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
