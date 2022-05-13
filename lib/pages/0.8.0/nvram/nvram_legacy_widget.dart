import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/checkbox_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class NvramLegacyWidget extends StatefulWidget {
  @override
  _NvramLegacyWidgetState createState() => _NvramLegacyWidgetState();
}

class _NvramLegacyWidgetState extends State<NvramLegacyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        Row(
          children: [
            CheckboxWidget(
              title: "LegacyEnable",
              height: globals.ITEM_DEFAULT_HEIGHT,
              getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["LegacyEnable"]["content"],
              setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["LegacyEnable"]["content"] = value,
            ),
            SizedBox(width: 5),
            CheckboxWidget(
              title: "LegacyOverwrite",
              height: globals.ITEM_DEFAULT_HEIGHT,
              getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["LegacyOverwrite"]["content"],
              setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["LegacyOverwrite"]["content"] = value,
            ),
            SizedBox(width: 5),
            CheckboxWidget(
              title: "WriteFlash",
              height: globals.ITEM_DEFAULT_HEIGHT,
              getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["WriteFlash"]["content"],
              setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["WriteFlash"]["content"] = value,
            ),
          ],
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
