import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;
import '../../templates/checkbox_widget.dart';
import '../../templates/string_array_widget.dart';

class UefiDriversWidget extends StatefulWidget {
  @override
  _UefiDriversWidgetState createState() => _UefiDriversWidgetState();
}

class _UefiDriversWidgetState extends State<UefiDriversWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxWidget(
          width: 270,
          title: "ConnectDrivers",
          getValue: () => globals.pConfig.getValue(["content", "UEFI", "content", "ConnectDrivers", "content"], null),
          setValue: (value) => globals.pConfig.setValue(["content", "UEFI", "content", "ConnectDrivers", "content"], value, null),
        ),
        SizedBox(height: 5),
        Expanded(
          child: StringArrayWidget(
            width: 300,
            getStringArray: () => globals.pConfig.getValue(["content", "UEFI", "content", "Drivers", "content"], null),
            setStringArray: (value) => globals.pConfig.setValue(["content", "UEFI", "content", "Drivers", "content"], value, null),
          ),
        ),
      ],
    );
  }
}
