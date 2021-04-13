import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

import 'booter_patch_widget.dart';
import 'booter_quirks_widget.dart';
import 'booter_mmio_whitelist_widget.dart';

class BooterPage extends StatefulWidget {
  @override
  _BooterPageState createState() => _BooterPageState();
}

class _BooterPageState extends State<BooterPage> {
  @override
  void initState() {
    super.initState();
    globals.changeColorMode2 = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                Tab(text: "MmioWhitelist", icon: Icon(Icons.assistant_photo, size: 19)),
                Tab(text: "Patch", icon: Icon(Icons.construction_outlined, size: 19)),
                Tab(text: "Quirks", icon: Icon(Icons.auto_awesome, size: 19)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BooterMmioWhitelistWidget(),
            BooterPatchWidget(),
            BooterQuirksWidget(),
          ],
        ),
      ),
    );
  }
}
