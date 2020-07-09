import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  final String itemTitle;
  final String itemValue;
  final IconData itemIcon;

  WeatherItem(
      {Key key,
      @required this.itemTitle,
      @required this.itemIcon,
      @required this.itemValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      child:
      Container(
          constraints: BoxConstraints.expand(height: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Color.fromARGB(26, 80, 90, 126),
              offset: Offset(0,4),
              blurRadius: 16)],
              borderRadius: BorderRadius.all(Radius.elliptical(5, 5))),
          child: Row(
            children: <Widget>[
              Container(
                width: 25,
                height: 25,
                margin: EdgeInsets.only(left: 8),
                child: Icon(itemIcon),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Text(
                  itemTitle,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 8.0,right: 8.0),
                child: Text(
                  itemValue,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5),
                ),
              )
            ],
          ),
        ),
      );
  }
}
