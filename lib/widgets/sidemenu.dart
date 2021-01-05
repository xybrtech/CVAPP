import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/providers/auth.dart';
import 'package:COVAPP/widgets/sidemenutitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  final String currentPage;
  final String firstName;
  final String lastName;
  final Function navigateBarCode;

  SideMenu(
      {this.currentPage, this.firstName, this.lastName, this.navigateBarCode});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(color: MaterialColors.primary),
            child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    //  backgroundImage: NetworkImage(
                    //   "https://pixabay.com/images/id-3637425/?fit=crop&w=840&q=80"),
                    ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                  child: Text('$firstName $lastName',
                      style: TextStyle(color: Colors.white, fontSize: 21)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        /* child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: MaterialColors.label),
                                    child: Text("Pro",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)))*/
                      ),
                      /*Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Text("Seller",
                                    style: TextStyle(
                                        color: MaterialColors.muted, fontSize: 16)),
                              ),*/
                      Row(
                        children: [
                          /*Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text("4.8",
                                        style: TextStyle(
                                            color: MaterialColors.warning,
                                            fontSize: 16)),
                                  ),*/
                          /*Icon(Icons.star_border,
                                      color: MaterialColors.warning, size: 20)
                                */
                        ],
                      )
                    ],
                  ),
                )
              ],
            ))),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            SideMenuTile(
                icon: Icons.home,
                onTap: () {
                  //if (currentPage != "Home")
                  Navigator.pushReplacementNamed(context, '/landing');
                },
                iconColor: Colors.black,
                title: "Home",
                isSelected: currentPage == "Home" ? true : false),
            /*  SideMenuTile(
                icon: Icons.addchart_sharp,
                onTap: () {
                  if (currentPage != "VaccineHistory")
                    Navigator.pushReplacementNamed(context, '/VaccineHistory');
                },
                iconColor: Colors.black,
                title: "Vaccine History",
                isSelected: currentPage == "VaccineHistory" ? true : false), */
            SideMenuTile(
                icon: Icons.qr_code_scanner,
                onTap: () {
                  if (currentPage != "BarCode")
                    // Navigator.pushReplacementNamed(context, '/barcode');
                    navigateBarCode();
                  Navigator.pop(context);
                },
                iconColor: Colors.black,
                title: "Bar Code",
                isSelected: currentPage == "BarCode" ? true : false),
            SideMenuTile(
                icon: Icons.logout,
                onTap: () async {
                  // Navigator.of(context).pop();
                  //if (currentPage != "signout")
                  print('Hello logout');
                  // Navigator.of(context)
                  //     .pushReplacementNamed(UserProductsScreen.routeName);
                  // await Provider.of<Auth>(context, listen: false).logout();
                  //Navigator.of(context).pushReplacementNamed('/landing');

                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/landing');

                  // Navigator.of(context)
                  //     .pushReplacementNamed(UserProductsScreen.routeName);
                  Provider.of<Auth>(context, listen: false).logout();

                  //if (currentPage != "signout")
                  // Navigator.pushReplacementNamed(context, '/landing');
                },
                iconColor: Colors.black,
                title: "Sign out",
                isSelected: currentPage == "signout" ? true : false),
          ],
        ))
      ])),
    );
  }
}
