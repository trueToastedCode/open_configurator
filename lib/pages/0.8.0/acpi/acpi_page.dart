import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/pages/0.8.0/acpi/acpi_add_widget.dart';

import 'acpi_delete_widget.dart';
import 'acpi_patch_widget.dart';
import 'acpi_quirks_widget.dart';

class ACPIPage extends StatefulWidget {
  @override
  _ACPIPageState createState() => _ACPIPageState();
}

class _ACPIPageState extends State<ACPIPage> {
  @override
  void initState() {
    super.initState();
    globals.changeColorMode2 = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: globals.isDark == true ? Color(0xff505050) : Colors.black.withOpacity(0.35),
              ),
              tabs: [
                Tab(text: "Add", icon: Icon(Icons.add, size: 19)),
                Tab(text: "Delete", icon: Icon(Icons.remove, size: 19)),
                Tab(text: "Patch", icon: Icon(Icons.construction_outlined, size: 19)),
                Tab(text: "Quriks", icon: Icon(Icons.auto_awesome, size: 19)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: AcpiAddWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: AcpiDeleteWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: AcpiPatchWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: AcpiQuirksWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
