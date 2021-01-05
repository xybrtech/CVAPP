import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/widgets/navbar.dart';
import 'package:COVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class Barcode extends StatelessWidget {
  Future<void> _getBarCodeInfo(BuildContext context) async {
    //await Provider.of<VaccineItems>(context, listen: false)
    //  .fetchAndSetHistory();
  }

  List<bool> _isHighlighted = [true, false];

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
                height: 150,
                child: SfBarcodeGenerator(
                  value: 'www.pavanguduru.com',
                  symbology: QRCode(),
                  showValue: false,
                ))));
  }
}
