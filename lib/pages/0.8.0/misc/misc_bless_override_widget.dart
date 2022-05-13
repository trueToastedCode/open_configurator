import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class MiscBlessOverrideWidget extends StatefulWidget {
  @override
  _MiscBlessOverrideWidgetState createState() => _MiscBlessOverrideWidgetState();
}

class _MiscBlessOverrideWidgetState extends State<MiscBlessOverrideWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        Text("Unimplemented, tell me what to do here.")
      ],
    );
  }
}
