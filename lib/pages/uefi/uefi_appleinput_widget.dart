import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiAppleInputWidget extends StatefulWidget {
  @override
  _UefiAppleInputWidgetState createState() => _UefiAppleInputWidgetState();
}

class _UefiAppleInputWidgetState extends State<UefiAppleInputWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "UEFI", "content", "AppleInput", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
