import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/providers/barcode.dart';
import 'package:COVAPP/widgets/navbar.dart';
import 'package:COVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class Barcode extends StatelessWidget {
  Future<void> _refreshHistory(BuildContext context) async {
    await Provider.of<BarCodeData>(context, listen: false).fetchBarCodeData();
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
          child: FutureBuilder(
            future: _refreshHistory(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _refreshHistory(context),
                        child: Consumer<BarCodeData>(
                            builder: (ctx, barCodedata, _) => Padding(
                                padding: EdgeInsets.all(8),
                                child: SfBarcodeGenerator(
                                  value: 'www.pavanguduru.com',
                                  symbology: QRCode(),
                                  showValue: false,
                                )))),
          ),
        ),
      ),
    );
  }
}
