import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiAudioWidget extends StatefulWidget {
  @override
  _UefiAudioWidgetState createState() => _UefiAudioWidgetState();
}

class _UefiAudioWidgetState extends State<UefiAudioWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "UEFI", "content", "Audio", "content"], 0, 300, -1, null),
        ),
      ],
    );
  }
}
