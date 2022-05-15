import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_configurator/pages/0.8.0/acpi/acpi_page.dart';
import 'package:open_configurator/pages/0.8.0/booter/booter_page.dart';
import 'package:open_configurator/pages/0.8.0/device_pops/device_props_page.dart';
import 'package:open_configurator/pages/0.8.0/kernel/kernel_page.dart';
import 'package:open_configurator/pages/0.8.0/misc/misc_page.dart';
import 'package:open_configurator/pages/0.8.0/nvram/nvram_page.dart';
import 'package:open_configurator/pages/0.8.0/platform_info/platform_info_page.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_page.dart';
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
    "!!!SEPERATE!!!": null,
    "OpenCorePkg": Icons.wb_incandescent_outlined,
    "Gathering Files": Icons.extension_outlined,
  };

  dynamic _getPage(String name) {
    switch (name) {
      case "ACPI":
        return ACPIPage();
      case "Booter":
        return BooterPage();
      case "DevicePropeties":
        return DevicePropsPage();
      case "Kernel":
        return KernelPage();
      case "Misc":
        return MiscPage();
      case "NVRAM":
        return NVRAMPage();
      case "PlatformInfo":
        return PlatformInfoPage();
      case "UEFI":
        return UEFIPage();
      case "OpenCorePkg":
        return globals.openCorePkgPage;
      case "Gathering Files":
        return globals.gatheringFilesPage;
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
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: [
          SizedBox(height: 0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  color: globals.isDark
                      ? Colors.white.withOpacity(0.07)
                      : null,
                  child: ListView(
                    children: [
                      SizedBox(height: 30),
                      ..._ENTRIES.keys.map((String key) {
                        switch(key) {
                          case "!!!SEPERATE!!!": return Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                            height: 2.5,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.all(Radius.circular(2.5)),
                            ),
                          );
                          default: return Container(
                            margin: globals.isMobile ? EdgeInsets.only(bottom: 5) : null,
                            padding: EdgeInsets.only(right: 0),
                            width: double.infinity,
                            height: globals.isMobile ? 31 : 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Material(
                                color: _selectedPage == key
                                    ? Colors.blue
                                    : Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    final result = _getPage(key);
                                    if (result is Function) {
                                      result();
                                    } else {
                                      setState(() => _selectedPage = key);
                                      widget.setPage(result);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        Icon(_ENTRIES[key], size: 14,
                                            color: globals.isDark
                                                ? Colors.white
                                                : Colors.black),
                                        SizedBox(width: 4),
                                        Text(key, style: TextStyle(
                                            fontSize: globals.isMobile
                                                ? 17
                                                : 14,
                                            color: globals.isDark
                                                ? Colors.white
                                                : Colors.black))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }).toList(),
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
                  Text("OpenConfigurator ${globals.DISPLAY_VERSION}", style: TextStyle(fontSize: 10)),
                  Text("OpenCore 0.8.0", style: TextStyle(fontSize: 10)),
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
                  } else
                    globals.undoDialog(context);
                },
                // icon: Icon(Icons.undo, size: 13),
                icon: Icon(Icons.undo, size: globals.isMobile ? 30 : 18),
                padding: EdgeInsets.all(0),
                splashRadius: 12,
              ),
              IconButton(
                onPressed: () => globals.safeDialog(context),
                icon: Icon(Icons.save, size: globals.isMobile ? 25 : 13),
                padding: EdgeInsets.all(0),
                splashRadius: 12,
              ),
              IconButton(
                onPressed: () => globals.resetDialog(context, widget.onReset),
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
}