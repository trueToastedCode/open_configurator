import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class DevicePropsDeleteWidget extends StatefulWidget {
  @override
  _DevicePropsDeleteWidgetState createState() => _DevicePropsDeleteWidgetState();
}

class _DevicePropsDeleteWidgetState extends State<DevicePropsDeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        Text("Unimplemented, tell me what to do here."),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
