import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/pages/platform_info/platform_info_generic_widget.dart';
import 'package:open_configurator/pages/platform_info/platform_info_main_widget.dart';

class PlatformInfoPage extends StatefulWidget {
  @override
  _PlatformInfoPageState createState() => _PlatformInfoPageState();
}

class _PlatformInfoPageState extends State<PlatformInfoPage> {
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
                Tab(text: "Generic", icon: Icon(Icons.computer, size: 19)),
                Tab(text: "Main", icon: Icon(Icons.assistant_photo, size: 19)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PlatformInfoGenericWidget(),
            PlatformInfoMainWidget(),
          ],
        ),
      ),
    );
  }
}
