import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

import 'device_props_add_widget.dart';
import 'device_props_delete_widget.dart';

class DevicePropsPage extends StatefulWidget {
  @override
  _DevicePropsPageState createState() => _DevicePropsPageState();
}

class _DevicePropsPageState extends State<DevicePropsPage> {
  @override
  void initState() {
    super.initState();
    globals.changeColorMode2 = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: DevicePropsAddWidget()),
            ),
            Padding(
              padding: EdgeInsets.only(left: globals.INNER_PADDING),
              child: SingleChildScrollView(child: DevicePropsDeleteWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
