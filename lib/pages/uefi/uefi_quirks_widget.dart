import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiQuriksWidget extends StatefulWidget {
  @override
  _UefiQuriksWidgetState createState() => _UefiQuriksWidgetState();
}

class _UefiQuriksWidgetState extends State<UefiQuriksWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "UEFI", "content", "Quirks", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
