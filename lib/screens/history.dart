import 'package:COVAPP/constants/theme.dart';

import 'package:COVAPP/providers/vaccineitems.dart';

import 'package:COVAPP/widgets/sidemenu.dart';
import 'package:COVAPP/widgets/vaccine_item.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  //final List<VaccineItem> userVaccinehistory;

  Future<void> _refreshHistory(BuildContext context) async {
    await Provider.of<VaccineItems>(context, listen: false)
        .fetchAndSetHistory();
  }

  History();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MaterialColors.primary,
        // key: _scaffoldKey,
        drawer: SideMenu(currentPage: "Home"),
        body: Container(
          color: MaterialColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: FutureBuilder(
            future: _refreshHistory(context),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshHistory(context),
                    child: Consumer<VaccineItems>(
                      builder: (ctx, vaccineData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: vaccineData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              VaccineItemSW(
                                  vaccineData.items[i].pk,
                                  vaccineData.items[i].maker,
                                  vaccineData.items[i].doseNum.toString(),
                                  vaccineData.items[i].vaccinatedDate != null
                                      ? DateFormat.yMMMMd('en_US').format(
                                          vaccineData.items[i].vaccinatedDate)
                                      : ""),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ));
  }
}
