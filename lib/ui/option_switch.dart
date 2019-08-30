import 'package:flutter/material.dart';

class OptionSwitch extends StatelessWidget {
  OptionSwitch({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.value,
    this.onTap,
    this.onChange,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final bool value;
  final VoidCallback onTap;
  final void Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: Switch(
        value: value,
        onChanged: onChange,
      ),
      onTap: onTap,
    );
  }
}
