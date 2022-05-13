import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class AcpiQuirksWidget extends StatefulWidget {
  @override
  _AcpiQuirksWidgetState createState() => _AcpiQuirksWidgetState();
}

class _AcpiQuirksWidgetState extends State<AcpiQuirksWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "ACPI", "content", "Quirks", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
