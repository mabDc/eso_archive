import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    this.ruleID,
    this.item,
    Key key,
  }) : super(key: key);

  final int ruleID;
  final dynamic item;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
