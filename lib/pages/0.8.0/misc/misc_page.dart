import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

import 'misc_bless_override_widget.dart';
import 'misc_boot_widget.dart';
import 'misc_debug_widget.dart';
import 'misc_entries_widget.dart';
import 'misc_security_widget.dart';
import 'misc_tools_widget.dart';

class MiscPage extends StatefulWidget {
  @override
  _MiscPageState createState() => _MiscPageState();
}

class _MiscPageState extends State<MiscPage> {
  @override
  void initState() {
    super.initState();
    globals.changeColorMode2 = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
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
                Tab(text: "BlessOverride", icon: Icon(Icons.record_voice_over, size: 19)), // TODO Implement this page
                Tab(text: "Boot", icon: Icon(Icons.not_started_outlined, size: 19)),
                Tab(text: "Debug", icon: Icon(Icons.remove_red_eye, size: 19)),
                Tab(text: "Entries", icon: Icon(Icons.list, size: 19)),
                Tab(text: "Security", icon: Icon(Icons.security, size: 19)),
                Tab(text: "Tools", icon: Icon(Icons.touch_app_outlined, size: 19)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: MiscBlessOverrideWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: MiscBootWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: MiscDebugWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: MiscEntriesWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: MiscSecurityWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: MiscToolsWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
