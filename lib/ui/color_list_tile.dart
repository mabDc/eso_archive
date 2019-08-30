import 'package:flutter/material.dart';

class ColorListTile extends StatelessWidget {
  ColorListTile({
    Key key,
    this.title,
    this.subtitle,
    this.color,
    this.trailing,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final Widget title;
  final Widget subtitle;
  final Color color;
  final Widget trailing;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        height: 32,
        width: 32,
      ),
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
