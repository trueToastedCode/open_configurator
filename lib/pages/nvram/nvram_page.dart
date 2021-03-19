import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/pages/nvram/nvram_legacy_schema_widget.dart';
import 'package:open_configurator/pages/nvram/nvram_legacy_widget.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'nvram_add_widget.dart';
import 'nvram_delete_widget.dart';

class NVRAMPage extends StatefulWidget {
  @override
  _NVRAMPageState createState() => _NVRAMPageState();
}

class _NVRAMPageState extends State<NVRAMPage> {
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
                Tab(text: "Legacy", icon: Icon(Icons.agriculture, size: 19)),
                Tab(text: "LegacySchema", icon: Icon(Icons.agriculture, size: 19)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            NvramAddWidget(),
            NvramDeleteWidget(),
            NvramLegacyWidget(),
            LegacySchemaWidget(),
          ],
        ),
      ),
    );
  }
}
