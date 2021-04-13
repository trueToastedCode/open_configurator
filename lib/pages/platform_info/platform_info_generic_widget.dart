import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class PlatformInfoGenericWidget extends StatefulWidget {
  @override
  _PlatformInfoGenericWidgetState createState() => _PlatformInfoGenericWidgetState();
}

class _PlatformInfoGenericWidgetState extends State<PlatformInfoGenericWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "PlatformInfo", "content", "Generic", "content"], 0, 500, -1, null),
        ),
      ],
    );
  }
}
