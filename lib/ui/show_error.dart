import 'package:flutter/material.dart';

class ShowError extends StatelessWidget {
  ShowError({
    this.errorMsg,
    Key key,
  }) : super(key: key);

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.9),
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Icon(
              Icons.error_outline,
              color: Theme.of(context).primaryTextTheme.title.color,
              size: 48,
            ),
            Text(
              'something wrong\ndon\'t worry, press back and return to last page',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.title.color,
                  height: 3,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic),
            ),
            Padding(padding: EdgeInsets.only(bottom: 50.0)),
            ListTile(title: Text(errorMsg)),
          ],
        ),
      ),
    );
  }
}
