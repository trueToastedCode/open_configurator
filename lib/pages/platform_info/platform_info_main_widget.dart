import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class PlatformInfoMainWidget extends StatefulWidget {
  @override
  _PlatformInfoMainWidgetState createState() => _PlatformInfoMainWidgetState();
}

class _PlatformInfoMainWidgetState extends State<PlatformInfoMainWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "PlatformInfo", "content"], 0, 270, -1, ["Generic"]),
        ),
      ],
    );
  }
}
