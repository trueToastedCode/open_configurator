import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/services.dart';
import 'package:open_configurator/pages/home/home_page.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/pages/load_config_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  globals.isMobile = !(Platform.isWindows || Platform.isLinux || Platform.isMacOS);
  if (globals.isMobile ) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  } else if (/*Platform.isWindows || */Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setWindowSize(Size(900, 620));
  }
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  void _onConfigLoaded() => setState(() {});
  @override
  Widget build(BuildContext context) {
    globals.changeColorMode = () {
      setState(() {
        globals.isDark = globals.isDark == true ? false : true;
        if (globals.changeColorMode2 != null) try {
          globals.changeColorMode2();
        }catch (e) {}
      });
    };
    return MaterialApp(
      theme: globals.isDark ? ThemeData.dark() : null,
      home: globals.pConfig == null
          ? LoadConfigPage(
              onConfigLoaded: _onConfigLoaded,
            )
          : HomePage(
              onReset: () {
                setState(() {
                  globals.pConfig = null;
                  globals.undoList = [];
                  globals.changeColorMode = null;
                  globals.changeColorMode2 = null;
                });
              },
            ),
    );
  }
}