import 'package:CVAPP/providers/vaccineitems.dart';
import 'package:CVAPP/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VaccineItemSW extends StatelessWidget {
  final String id;
  final String maker;
  final String doseNum;
  final String vaccinatedDate;
  final String rtype;

  VaccineItemSW(
      this.id, this.rtype, this.maker, this.doseNum, this.vaccinatedDate);

  Color getColor(maker) {
    if (maker.toString().contains('Pfizer')) return MaterialColors.primary;
    if (maker.toString().contains('Moderna')) return Colors.blueGrey;
    if (maker.toString().contains('Glaxosmithkline')) return Colors.blueAccent;
    if (maker.toString().contains('AstraZeneca')) return Colors.indigo;
    if (maker.toString().contains('Novavax')) return Colors.blueAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'You want to remove the vaccine info previously entered?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<VaccineItems>(context, listen: false).removeItem(id, rtype);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor('$maker'),
              foregroundColor: MaterialColors.white,
              child: Padding(
                padding: EdgeInsets.all(1),
                child: FittedBox(
                  child: Text('${maker[0]}'),
                ),
              ),
            ),
            title: Text(
              maker,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
            subtitle: Text('Dose#: ${(doseNum)}'),
            trailing: Text('$vaccinatedDate'),
          ),
        ),
      ),
    );
  }
}
