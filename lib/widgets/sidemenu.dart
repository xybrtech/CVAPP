import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/widgets/sidemenutitle.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final String currentPage;

  SideMenu({this.currentPage});

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
                  backgroundImage: NetworkImage(
                      "https://pixabay.com/images/id-3637425/?fit=crop&w=840&q=80"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                  child: Text("Darryl Brown",
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
                  if (currentPage != "Home")
                    Navigator.pushReplacementNamed(context, '/home');
                },
                iconColor: Colors.black,
                title: "Home",
                isSelected: currentPage == "Home" ? true : false),
            SideMenuTile(
                icon: Icons.addchart_sharp,
                onTap: () {
                  if (currentPage != "VaccineHistory")
                    Navigator.pushReplacementNamed(context, '/VaccineHistory');
                },
                iconColor: Colors.black,
                title: "Vaccine History",
                isSelected: currentPage == "VaccineHistory" ? true : false),
            SideMenuTile(
                icon: Icons.qr_code_scanner,
                onTap: () {
                  if (currentPage != "BarCode")
                    Navigator.pushReplacementNamed(context, '/BarCode');
                },
                iconColor: Colors.black,
                title: "Bar Code",
                isSelected: currentPage == "BarCode" ? true : false),
            SideMenuTile(
                icon: Icons.qr_code_scanner,
                onTap: () {
                  if (currentPage != "signout")
                    Navigator.pushReplacementNamed(context, '/onboarding');
                },
                iconColor: Colors.black,
                title: "Sign out",
                isSelected: currentPage == "signout" ? true : false)

            /*,
                    DrawerTile(
                        icon: Icons.tag_faces,
                        onTap: () {
                          if (currentPage != "Man")
                            Navigator.pushReplacementNamed(context, '/man');
                        },
                        iconColor: Colors.black,
                        title: "Man",
                        isSelected: currentPage == "Man" ? true : false),
                    DrawerTile(
                        icon: Icons.child_friendly,
                        onTap: () {
                          if (currentPage != "Kids")
                            Navigator.pushReplacementNamed(context, '/kids');
                        },
                        iconColor: Colors.black,
                        title: "Kids",
                        isSelected: currentPage == "Kids" ? true : false),
                    DrawerTile(
                        icon: Icons.grain,
                        onTap: () {
                          if (currentPage != "New Collection")
                            Navigator.pushReplacementNamed(context, '/newcollection');
                        },
                        iconColor: Colors.black,
                        title: "New Collection",
                        isSelected: currentPage == "New Collection" ? true : false),
                    DrawerTile(
                        icon: Icons.settings_input_component,
                        onTap: () {
                          if (currentPage != "Components")
                            Navigator.pushReplacementNamed(context, '/components');
                        },
                        iconColor: Colors.black,
                        title: "Components",
                        isSelected: currentPage == "Components" ? true : false),
                    DrawerTile(
                        icon: Icons.account_circle,
                        onTap: () {
                          if (currentPage != "Profile")
                            Navigator.pushReplacementNamed(context, '/profile');
                        },
                        iconColor: Colors.black,
                        title: "Profile",
                        isSelected: currentPage == "Profile" ? true : false),
                    DrawerTile(
                        icon: Icons.settings,
                        onTap: () {
                          if (currentPage != "Settings")
                            Navigator.pushReplacementNamed(context, '/settings');
                        },
                        iconColor: Colors.black,
                        title: "Settings",
                        isSelected: currentPage == "Settings" ? true : false),
                    DrawerTile(
                        icon: Icons.exit_to_app,
                        onTap: () {
                          if (currentPage != "Sign In")
                            Navigator.pushReplacementNamed(context, '/signin');
                        },
                        iconColor: Colors.black,
                        title: "Sign In",
                        isSelected: currentPage == "Sign In" ? true : false),
                    DrawerTile(
                        icon: Icons.open_in_browser,
                        onTap: () {
                          if (currentPage != "Sign Up")
                            Navigator.pushReplacementNamed(context, '/signup');
                        },
                        iconColor: Colors.black,
                        title: "Sign Up",
                        isSelected: currentPage == "Sign Up" ? true : false),*/
          ],
        ))
      ])),
    );
  }
}
