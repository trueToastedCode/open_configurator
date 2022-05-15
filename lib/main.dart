import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/services.dart';
import 'package:open_configurator/pages/0.8.0/home/home_page.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/pages/load_config_page.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  globals.isMobile = !(Platform.isWindows || Platform.isLinux || Platform.isMacOS);
  if (globals.isMobile ) {
    if (SizerUtil.deviceType != DeviceType.Tablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
    }
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setWindowSize(Size(900, 620));
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  _reset() {
    setState(() {
      globals.pConfig = null;
      globals.undoList = [];
      globals.changeColorMode = null;
      globals.changeColorMode2 = null;
      globals.selectedOCVersion = null;
    });
  }

  Widget _homePage() {
    switch(globals.selectedOCVersion) {
      case '0.8.0': return HomePage080(onReset: _reset);
    }
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Selected unimplemented version'),
            TextButton(
              onPressed: _reset,
              child: Text('Ok')
            ),
          ],
        ),
      ),
    );
  }

  void _onConfigLoaded(String selectedOCVersion) => setState(() {
    globals.selectedOCVersion = selectedOCVersion;
  });

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
      theme: globals.isDark ? ThemeData.dark().copyWith(
        // scaffoldBackgroundColor: Color(0xff1a1a1a)
      ) : null,
      home: globals.pConfig == null
          ? LoadConfigPage(
              onConfigLoaded: _onConfigLoaded,
            )
          : _homePage(),
    );
  }
}