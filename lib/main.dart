import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/pages/home/home_page.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/pages/load_config_page.dart';

void main() {
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
                // globals reset not enough... full restart required
              },
              onSave: () {
                final path = globals.pConfig.path;
                String newPath;
                for (int i=path.length-1; i>-1; i--) {
                  if (path[i] == ".") {
                    newPath = path.substring(0, i) + "_Test.plist";
                    break;
                  }
                }
                if (newPath == null) newPath = path + "-Test.plist";
                globals.pConfig.write(newPath);
              },
            ),
    );
  }
}
