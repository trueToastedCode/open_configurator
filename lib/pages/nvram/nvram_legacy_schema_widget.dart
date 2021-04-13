import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/string_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class LegacySchemaWidget extends StatefulWidget {
  @override
  _LegacySchemaWidgetState createState() => _LegacySchemaWidgetState();
}

class _LegacySchemaWidgetState extends State<LegacySchemaWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StringArrayWidget(
          width: 300,
          height: 200,
          getStringArray: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["LegacySchema"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"],
          setStringArray: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["LegacySchema"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"] = value,
        ),
        SizedBox(width: 8),
        StringArrayWidget(
          width: 200,
          height: 200,
          getStringArray: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["LegacySchema"]["content"]["8BE4DF61-93CA-11D2-AA0D-00E098032B8C"]["content"],
          setStringArray: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["LegacySchema"]["content"]["8BE4DF61-93CA-11D2-AA0D-00E098032B8C"]["content"] = value,
        ),
      ],
    );
  }
}
