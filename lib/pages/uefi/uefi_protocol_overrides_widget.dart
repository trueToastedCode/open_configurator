import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiProtocolOverridesWidget extends StatefulWidget {
  @override
  _UefiProtocolOverridesWidgetState createState() => _UefiProtocolOverridesWidgetState();
}

class _UefiProtocolOverridesWidgetState extends State<UefiProtocolOverridesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "UEFI", "content", "ProtocolOverrides", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
