library open_configurator.globals;

import 'package:flutter/cupertino.dart';
import 'package:open_configurator/services/pconfig.dart';
import 'package:open_configurator/templates/number_widget.dart';

import 'templates/checkbox_widget.dart';
import 'templates/data_widget.dart';
import 'templates/string_widget.dart';

const OC_VERSION = '0.8.0';

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