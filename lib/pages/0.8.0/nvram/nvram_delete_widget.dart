import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/string_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class NvramDeleteWidget extends StatefulWidget {
  @override
  _NvramDeleteWidgetState createState() => _NvramDeleteWidgetState();
}

class _NvramDeleteWidgetState extends State<NvramDeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        StringArrayWidget(
          width: 300,
          height: 200,
          getStringArray: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Delete"]["content"]["4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14"]["content"],
          setStringArray: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Delete"]["content"]["4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14"]["content"] = value,
        ),
        SizedBox(height: 8),
        StringArrayWidget(
          width: 300,
          height: 200,
          getStringArray: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Delete"]["content"]["4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102"]["content"],
          setStringArray: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Delete"]["content"]["4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102"]["content"] = value,
        ),
        SizedBox(height: 8),
        StringArrayWidget(
          width: 300,
          height: 200,
          getStringArray: () => globals.pConfig.getValue(["content", "NVRAM", "content", "Delete", "content", "7C436110-AB2A-4BBB-A880-FE41995C9F82", "content"], null),
          setStringArray: (value) => globals.pConfig.setValue(["content", "NVRAM", "content", "Delete", "content", "7C436110-AB2A-4BBB-A880-FE41995C9F82", "content"], value, null)
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
