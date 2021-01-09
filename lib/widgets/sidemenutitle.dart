import 'package:CVAPP/constants/theme.dart';
import 'package:flutter/material.dart';

class SideMenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected;
  final Color iconColor;

  SideMenuTile(
      {this.title,
      this.icon,
      this.onTap,
      this.isSelected = false,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
                color: isSelected ? MaterialColors.primary : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Icon(icon,
                      size: 20, color: isSelected ? Colors.white : iconColor),
                ),
                Text(title,
                    style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.white : Colors.black))
              ],
            )));
  }
}
