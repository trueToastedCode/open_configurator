library open_configurator.globals;

import 'dart:convert';
import 'dart:io' show Directory, File, Platform;
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_configurator/services/pconfig.dart';
import 'package:open_configurator/templates/number_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'templates/checkbox_widget.dart';
import 'templates/data_widget.dart';
import 'templates/string_widget.dart';

const DISPLAY_VERSION = '0.0.1-10';

String selectedOCVersion;

bool isDark = true;
Function changeColorMode;
Function changeColorMode2;

bool isMobile;

PConfig pConfig;
List<Function> undoList = [];

List<Widget> buildWidgetsNoTree(List<String> path, int orientation, double width, double height, List<String> ignoreKeys) {
  List<Widget> widgets = [];
  final map = pConfig.getValue(List.from(path), null);
  for (final key in map.keys) {
    if (ignoreKeys != null && ignoreKeys.contains(key)) continue;
    switch(map[key]["type"]) {
      case "bool":
        widgets.addAll([
          CheckboxWidget(
            width: width,
            height: height,
            title: key,
            getValue: () => pConfig.getValue([...path, key, "content"], null),
            setValue: (value) => pConfig.setValue([...path, key, "content"], value, null),
          ),
          SizedBox(height: orientation == 0 ? 5 : 0, width: orientation == 0 ? 5 : 0),
        ]);
        break;
      case "integer":
        widgets.addAll([
          NumberWidget(
            width: width,
            height: height,
            title: key,
            getValue: () => pConfig.getValue([...path, key, "content"], null),
            setValue: (value) => pConfig.setValue([...path, key, "content"], value, null),
          ),
          SizedBox(height: orientation == 0 ? 5 : 0, width: orientation == 0 ? 5 : 0),
        ]);
        break;
      case "data":
        widgets.addAll([
          DataWidget(
            width: width,
            height: height,
            title: key,
            getValue: () => pConfig.getValue([...path, key, "content"], null),
            setValue: (value) => pConfig.setValue([...path, key, "content"], value, null),
          ),
          SizedBox(height: orientation == 0 ? 5 : 0, width: orientation == 0 ? 5 : 0),
        ]);
        break;
      case "string":
        widgets.addAll([
          StringWidget(
            width: width,
            height: height,
            title: key,
            getValue: () => pConfig.getValue([...path, key, "content"], null),
            setValue: (value) => pConfig.setValue([...path, key, "content"], value, null),
          ),
          SizedBox(height: orientation == 0 ? 5 : 0, width: orientation == 0 ? 5 : 0),
        ]);
        break;
      default:
        throw UnimplementedError("Tried to build type \"${map[key]["type"]}\"");
    }
  }
  if (widgets.isNotEmpty) widgets.removeLast();
  return widgets;
}

const INNER_PADDING = 8.0;
const ITEM_DEFAULT_WIDTH = 500.0;
const ITEM_DEFAULT_HEIGHT = 45.0;

void undoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text("Undo"),
      content: Text("Do you really want to undo the last change?", style: TextStyle(fontSize: 15)),
      actions: <Widget>[
        TextButton(
          child: Text("No", style: TextStyle(color: Colors.red)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text("Yes", style: TextStyle(color: Colors.blue)),
          onPressed: () {
            Navigator.of(context).pop();
            undoList.last();
            undoList.removeLast();
          },
        ),
      ],
    ),
  );
}

void resetDialog(BuildContext context, Function onReset) {
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text("Leave"),
      content: Text("Do you really want to leave this configuration?", style: TextStyle(fontSize: 15)),
      actions: <Widget>[
        TextButton(
          child: Text("Yes", style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
            onReset();
          },
        ),
        TextButton(
          child: Text("No", style: TextStyle(color: Colors.blue)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

void safeDialog(BuildContext context) async {
  if (Platform.isIOS) {
    try {
      final str = await pConfig.compile();
      if (str == null) {
        Fluttertoast.showToast(
          msg: "Unable to compile config!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
        );
        return;
      }
      final data = utf8.encode(str);
      final tempDir = await getApplicationSupportDirectory();
      final file = await new File('${tempDir.path}/config.plist').create();
      file.writeAsBytesSync(data);
      final globalKey = RectGetter.createGlobalKey();
      Rect rect = RectGetter.getRectFromKey(globalKey);
      if (rect == null) {
        // print('Rect is null');
        Share.shareFiles([file.path]);
      } else {
        Share.shareFiles(
            [file.path],
            sharePositionOrigin: Rect.fromLTWH(
                rect.left + 40, rect.top + 20, 2, 2));
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error while saving config!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
      );
      return;
    }
  } else {
    String newPath;
    if (isMobile) {
      final path = await FilesystemPicker.open(
        title: 'Save to folder',
        context: context,
        rootDirectory: Directory("/sdcard/"),
        fsType: FilesystemType.folder,
        pickText: 'Save file to this folder',
        folderIconColor: Colors.teal,
      );
      if (path == null) return;
      newPath = path + "/config.plist";
    }else {
      final path = pConfig.path;
      for (int i=path.length-1; i>-1; i--) {
        if (path[i] == ".") {
          newPath = path.substring(0, i) + "_OpenConf.plist";
          break;
        }
      }
      if (newPath == null) {
        newPath = path + "_OpenConf.plist";
      }
    }
    pConfig.write(newPath);
    showDialog(context: context, builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text("Done"),
      content: Text("Config has been written to \"$newPath\""),
      actions: <Widget>[
        TextButton(
          child: Text("Ok", style: TextStyle(color: Colors.blue)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ));
  }
}

openCorePkgPage() async {
  const kextUrl = 'https://github.com/acidanthera/OpenCorePkg/releases';
  if (await canLaunch(kextUrl)) {
    await launch(kextUrl);
  } else {
    Fluttertoast.showToast(
        msg: "Unable to launch url!",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }
}

gatheringFilesPage() async {
  const kextUrl = 'https://dortania.github.io/OpenCore-Install-Guide/ktext.html';
  if (await canLaunch(kextUrl)) {
    await launch(kextUrl);
  } else {
    Fluttertoast.showToast(
        msg: "Unable to launch url!",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }
}

String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? 'phone' :'tablet';
}
