import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiOutputWidget extends StatefulWidget {
  @override
  _UefiOutputWidgetState createState() => _UefiOutputWidgetState();
}

class _UefiOutputWidgetState extends State<UefiOutputWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "UEFI", "content", "Output", "content"], 0, 300, -1, null),
        ),
      ],
    );
  }
}
