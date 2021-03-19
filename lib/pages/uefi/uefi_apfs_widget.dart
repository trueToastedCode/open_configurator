import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiAPFSWidget extends StatefulWidget {
  @override
  _UefiAPFSWidgetState createState() => _UefiAPFSWidgetState();
}

class _UefiAPFSWidgetState extends State<UefiAPFSWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "UEFI", "content", "APFS", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
