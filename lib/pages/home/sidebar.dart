import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_configurator/pages/acpi/acpi_page.dart';
import 'package:open_configurator/pages/booter/booter_page.dart';
import 'package:open_configurator/pages/device_pops/device_props_page.dart';
import 'package:open_configurator/pages/kernel/kernel_page.dart';
import 'package:open_configurator/pages/misc/misc_page.dart';
import 'package:open_configurator/pages/nvram/nvram_page.dart';
import 'package:open_configurator/pages/platform_info/platform_info_page.dart';
import 'package:open_configurator/pages/uefi/uefi_page.dart';
import 'package:open_configurator/globals.dart' as globals;


class SideBar extends StatefulWidget {
  final Function setPage, onReset;
  const SideBar({this.setPage, this.onReset});
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  static const Map<String, IconData> _ENTRIES = {
    "ACPI": Icons.workspaces_filled,
    "Booter": Icons.not_started_outlined,
    "DevicePropeties": Icons.settings,
    "Kernel": Icons.circle,
    "Misc": Icons.animation,
    "NVRAM": Icons.list,
    "PlatformInfo": Icons.computer,
    "UEFI": Icons.attachment_outlined,
  };
  Widget _getPage(String name) {
    switch(name) {
      case "ACPI": return ACPIPage();
      case "Booter": return BooterPage();
      case "DevicePropeties": return DevicePropsPage();
      case "Kernel": return KernelPage();
      case "Misc": return MiscPage();
      case "NVRAM": return NVRAMPage();
      case "PlatformInfo": return PlatformInfoPage();
      case "UEFI": return UEFIPage();
    }
    return null;
  }
  String _selectedPage = "NVRAM";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: globals.isMobile ? 175 : 170,
      height: double.infinity,
      color: globals.isDark ? Color(0xff0C0C0D) : null,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Container(
                  color: globals.isDark ? Colors.white.withOpacity(0.07) : Colors.white.withOpacity(0.01),
                  child: ListView(
                    children: [
                      ..._ENTRIES.keys.map((String key) => Container(
                        margin: globals.isMobile ? EdgeInsets.only(bottom: 5) : null,
                        padding: EdgeInsets.only(right: 0),
                        width: double.infinity,
                        height: globals.isMobile ? 31 : 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Material(
                            color: _selectedPage == key ? Colors.blue : Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() => _selectedPage = key);
                                widget.setPage(_getPage(key));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Icon(_ENTRIES[key], size: 14, color: globals.isDark ? Colors.white : Colors.black),
                                    SizedBox(width: 4),
                                    Text(key, style: TextStyle(fontSize: globals.isMobile ? 17 : 14, color: globals.isDark ? Colors.white : Colors.black))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Darkmode", style: TextStyle(fontSize: 13)),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  value: globals.isDark,
                  onChanged: (value) => globals.changeColorMode(),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("OpenConfigurator 0.0.1-6", style: TextStyle(fontSize: 10)),
                  Text("OpenCore 0.7.0", style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (globals.undoList.length == 0) {
                    Fluttertoast.showToast(
                        msg: "Nothing to undo!",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );
                  }else _undoDialog();
                },
                // icon: Icon(Icons.undo, size: 13),
                icon: Icon(Icons.undo, size: globals.isMobile ? 30 : 18),
                padding: EdgeInsets.all(0),
                splashRadius: 12,
              ),
              IconButton(
                onPressed: _safeDialog,
                icon: Icon(Icons.save, size: globals.isMobile ? 25 : 13),
                padding: EdgeInsets.all(0),
                splashRadius: 12,
              ),
              IconButton(
                onPressed: _resetDialog,
                icon: Icon(Icons.exit_to_app, size: globals.isMobile ? 25 : 13),
                padding: EdgeInsets.all(0),
                splashRadius: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _safeDialog() async {
    String newPath;
    if (globals.isMobile) {
      final path = await FilesystemPicker.open(
        title: 'Save to folder',
        context: context,
        rootDirectory: Directory("/sdcard/"),
        fsType: FilesystemType.folder,
        pickText: 'Save file to this folder',
        folderIconColor: Colors.teal,
      );
      if (path == null) return;
      newPath = path + "_OpenConf.plist";
    }else {
      final path = globals.pConfig.path;
      for (int i=path.length-1; i>-1; i--) {
        if (path[i] == ".") {
          newPath = path.substring(0, i) + "_OpenConf.plist";
          break;
        }
      }
      if (newPath == null) newPath = path + "_OpenConf.plist";
    }
    globals.pConfig.write(newPath);
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

  void _undoDialog() {
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
              globals.undoList.last();
              globals.undoList.removeLast();
            },
          ),
        ],
      ),
    );
  }

  void _resetDialog() {
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
              widget.onReset();
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
}
