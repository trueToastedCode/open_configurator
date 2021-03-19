import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiInputWidgets extends StatefulWidget {
  @override
  _UefiInputWidgetsState createState() => _UefiInputWidgetsState();
}

class _UefiInputWidgetsState extends State<UefiInputWidgets> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "UEFI", "content", "Input", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
