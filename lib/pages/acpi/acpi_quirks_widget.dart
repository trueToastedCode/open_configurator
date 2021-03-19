import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class AcpiQuirksWidget extends StatefulWidget {
  @override
  _AcpiQuirksWidgetState createState() => _AcpiQuirksWidgetState();
}

class _AcpiQuirksWidgetState extends State<AcpiQuirksWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "ACPI", "content", "Quirks", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
