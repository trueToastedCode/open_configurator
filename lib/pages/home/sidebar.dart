import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  final Function setPage, onSave, onReset;
  const SideBar({this.setPage, this.onSave, this.onReset});
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
      width: 150,
      height: double.infinity,
      color: globals.isDark ? Color(0xff0C0C0D) : null,
      child: Column(
        children: [
          ..._ENTRIES.keys.map((String key) => Container(
            padding: EdgeInsets.only(right: 12),
            width: double.infinity,
            height: 25,
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
                        Text(key, style: TextStyle(fontSize: 14, color: globals.isDark ? Colors.white : Colors.black))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )).toList(),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("OpenConfigurator 0.0.0", style: TextStyle(fontSize: 10)),
                  Text("OpenCore 0.6.3", style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (globals.undoList.length != 0) {
                    globals.undoList.last();
                    globals.undoList.removeLast();
                  }
                },
                // icon: Icon(Icons.undo, size: 13),
                icon: Icon(Icons.undo, size: 18),
                padding: EdgeInsets.all(0),
                splashRadius: 12,
              ),
              IconButton(
                onPressed: widget.onSave,
                icon: Icon(Icons.save, size: 13),
                padding: EdgeInsets.all(0),
                splashRadius: 12,
              ),
              IconButton(
                onPressed: widget.onReset,
                icon: Icon(Icons.exit_to_app, size: 13),
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
