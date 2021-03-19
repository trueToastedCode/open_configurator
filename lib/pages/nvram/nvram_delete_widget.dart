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
      children: [
        Row(
          children: [
            StringArrayWidget(
              width: 220,
              height: 200,
              getStringArray: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Delete"]["content"]["4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14"]["content"],
              setStringArray: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Delete"]["content"]["4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14"]["content"] = value,
            ),
            SizedBox(width: 8),
            StringArrayWidget(
              width: 220,
              height: 200,
              getStringArray: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Delete"]["content"]["4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102"]["content"],
              setStringArray: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Delete"]["content"]["4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102"]["content"] = value,
            ),
          ],
        ),
      ],
    );
  }
}
