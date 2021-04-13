import 'dart:io';

import 'package:flutter/cupertino.dart';

class PConfig {
  final String path;
  String version;
  Map<String, dynamic> pConfig;

  PConfig({@required this.path});

  // return value from path as string list
  dynamic getValue(List<String> path, Map<String, dynamic> currentMap) {
    if (path.length == 1) return currentMap == null ? pConfig[path.first] : currentMap[path.first];
    final str = path.first;
    path.removeAt(0);
    return getValue(path, currentMap == null ? pConfig[str] : currentMap[str]);
  }
  
  // set value from path as string list
  void setValue(List<String> path, dynamic value, Map<String, dynamic> currentMap) {
    if (path.length == 1) {
      pConfig[path.first] = value;
    }else {
      if (currentMap == null) currentMap = getValue(List.from(path)..removeLast(), null);
      currentMap[path.last] = value;
      path.removeLast();
      setValue(path, currentMap, getValue(path, null));
    }
  }

  // writes pconfig map back to xml
  Future<void> write(String path) async {
    final pConfig = await this.pConfig;
    if (pConfig == null) return false;
    final str = "\<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
        "\<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
        "\<plist version=\"$version\">\n" + _compose(pConfig, 0) + "\</plist>";
    File(path == null ? this.path : path).writeAsStringSync(str);
  }

  // converts pconfig into map object (see sample/config_converted.json)
  Future<void> read() async {
    // read into string
    String data = File(path).readAsStringSync();
    // remove lines and spaces
    data = data.split("\n").map((String line) {
      for (int i=0; i<line.length; i++) {
        if (line[i] != " " && line[i] != "\t") return line.substring(i);
      }
      return "";
    }).toList().join();
    // find plist, parse meta
    List<dynamic> res;
    while (true) {
      res = _parsePrefix(data);
      data = res[2];
      if (res[0] != null) {
        if (res[0] == "plist") {
          try {
            version = res[1]["version"];
          }catch (e) {
            version = "1.0";
          }
          break;
        }
      }
      if (data.length == 0) throw Exception("Error parsing file (No content left to find plist)");
    }
    // parse plist
    pConfig = _parse("plist", data)[0][0];
  }

  // --- CONVERSION METHODS ---

  String _compose(Map<String, dynamic> map, int indent) {
    switch (map["type"]) {
      case "dict":
        final keys = map["content"].keys.toList();
        if (keys.length == 0) return "\t" * indent + "\<dict/>\n";
        String str = "\t" * indent + "\<dict>\n";
        for (final k in keys) str += "\t" * (indent+1) + _getEntryStr("key", k) + "\n" + _compose(map["content"][k], indent+1);
        return str + "\t" * indent + "\</dict>\n";
      case "array":
        if (map["content"].length == 0) return "\t" * indent + "\<array/>\n";
        String str = "\t" * indent + "\<array>\n";
        for (final e in map["content"]) str += _compose(e, indent+1);
        return str + "\t" * indent + "\</array>\n";
      default:
        return "\t" * indent + _getEntryStr(map["type"], map["content"]) + "\n";
    }
  }

  String _getEntryStr(String type, String content) {
    switch(type) {
      case "bool": return "\<${content == "1" ? "true" : "false"}/>";
      default: return "\<$type>$content\</$type>";
    }
  }

  List<dynamic> _parse(String key, String str) {
    List<dynamic> list = [];
    while (true) {
      if (str.substring(0, key.length + 3) == "\</$key>") {
        if (key == "dict") {
          if (list.length == 0) list.add({});
          return list..add(str.substring(key.length + 3));
        }
        return [list, str.substring(key.length + 3)];
      }
      // next suffix (no comment or meta)
      List<dynamic> res = _nextPrefix(str);
      if (res == null) throw Exception("Suffix not found!");
      str = res[2];
      // analyse type, then add or return
      switch (res[0]) {
        case "dict":
          final res = _parse("dict", str);
          final entry = _getEntryDic("dict", res[0]);
          if (key == "key") return [entry, res[1]];
          list.add(entry);
          str = res[1];
          break;
        case "dict/":
          final entry = _getEntryDic("dict", {});
          if (key == "key") return [entry, str];
          list.add(entry);
          break;
        case "array":
          final res = _parse("array", str);
          final entry = _getEntryDic("array", res[0]);
          if (key == "key") return [entry, res[1]];
          list.add(entry);
          str = res[1];
          break;
        case "array/":
          final entry = _getEntryDic("array", []);
          if (key == "key") return [entry, str];
          list.add(entry);
          break;
        case "bool":
          final entry = _getEntryDic(res[0], res[1]["value"]);
          if (key == "key") return [entry, str];
          list.add(entry);
          break;
        default:
          if (res[0][res[0].length-1] == "/") {
            final type = res[0].substring(0, res[0].length-1);
            if (type == "key") throw Exception("Key has no name");
            else if (key == "key") return [_getEntryDic(type, ""), str];
            list.add(_getEntryDic(type, ""));
          }else {
            final index = str.indexOf("\</${res[0]}>");
            if (index == -1) throw Exception("Error finding end: \"${res[0]}\"");
            final value = str.substring(0, index);
            str = str.substring(index+"\</${res[0]}>".length);
            if (key == "key") return [_getEntryDic(res[0], value), str];
            if (res[0] == "key") {
              if (key != "dict") throw Exception("Key in no dic");
              else if (str.length == 0) throw Exception("Content is missing");
              final res = _parse("key", str);
              if (list.length == 0) list.add({value: res[0]});
              else list[0][value] = res[0];
              str = res[1];
            }else {
              list.add(_getEntryDic(res[0], value));
            }
          }
      }
      if (str.length == 0) {
        if (key == "dict") {
          if (list.length == 0) list.add({});
          return list..add("");
        }
        return [list, ""];
      }
    }
  }

  Map<String, dynamic> _getEntryDic(String key, dynamic value) => {"type": key, "content": value};

  // find next suffix (no comment or meta)
  List<dynamic> _nextPrefix(String str) {
    List<dynamic> res;
    while (true) {
      res = _parsePrefix(str);
      if (res[0] != null) return res;
      str = res[2];
      if (str.length == 0) return null;
    }
  }

  // map valid attributes
  Map<String, String> _parseAttrs(String str) {
    Map<String, String> attrs = {};
    if (str.length < 3) return attrs;
    //region parse into parts
    bool cap = false, ignore = false;
    String part;
    List<String> parts = [];
    for (int i=0; i<str.length; i++) {
      if (cap) {
        if (ignore) {
          part += str[i];
          if (str[i] == "\"") ignore = false;
        }else if (str[i] == " ") {
          parts.add(part);
          part = null;
          cap = false;
        }else if (str[i] == "\"") {
          part += str[i];
          ignore = true;
        }else part += str[i];
      }else if (str[i] != " ") {
        part = str[i];
        cap = true;
      }
    }
    if (part != null) parts.add(part);
    //endregion
    if (parts.length == 0) return attrs;
    //region parse parts into map
    for (final part in parts) {
      List<String> partParts;
      for (int i=0; i<part.length; i++) {
        if (part[i] == "=" && i != 0) {
          partParts = [part.substring(0, i), part.substring(i+1, part.length)];
          break;
        }
      }
      if (partParts == null || partParts[1].length == 0) continue;
      if (partParts[1][0] == "\"" && partParts[1][partParts[1].length-1] == "\"") {
        attrs[partParts[0]] = partParts[1].substring(1, partParts[1].length-1);
      }else {
        attrs[partParts[0]] = partParts[1];
      }
    }
    //endregion
    return attrs;
  }

  // split into type, attributes, following
  List<dynamic> _parsePrefixHelper(String str, String end, bool parseAttrs) {
    String typeStr, attrsStr, followingStr;
    int x;
    for (int i=0; i<=str.length-end.length; i++) {
      if (typeStr != null) {
        if (str.substring(i, i+end.length) == end) {
          // end after args
          if (parseAttrs) attrsStr = str.substring(x, i);
          followingStr = str.substring(i+end.length);
          break;
        }
      }else if (str[i] == " ") {
        // end with args starting
        typeStr = str.substring(0, i);
        if (parseAttrs) x = i;
      }else if (str.substring(i, i+end.length) == end) {
        // end without args
        typeStr = str.substring(0, i);
        followingStr = str.substring(i+end.length);
        break;
      }
    }
    if (typeStr == null || followingStr == null) throw Exception("Invalid suffix: ${str.length > 10 ? str.substring(0, 10) + "..." : str}");
    if (!parseAttrs || attrsStr == null) return [typeStr, {}, followingStr];
    return [typeStr, _parseAttrs(attrsStr), followingStr];
  }

  // split into type, attributes, following
  List<dynamic> _parsePrefix(String str) {
    if (str[0] != "<") throw Exception("Invalid suffix: ${str.length > 10 ? str.substring(0, 10) + "..." : str}");
    switch (str[1]) {
      case "!":
        return [null, null, _parsePrefixHelper(str.substring(2), ">", false)[2]];
      case "?":
        final res = _parsePrefixHelper(str.substring(2), "?>", true);
        return [null, res[1], res[2]];
      default:
        final res = _parsePrefixHelper(str.substring(1), ">", true);
        if (res[0][res[0].length-1] == "/") {
          switch (res[0]) {
            case "true/": return ["bool", {"value": "1"}, res[2]];
            case "false/": return ["bool", {"value": "0"}, res[2]];
            default: return res;
          }
        }else return res;
    }
  }
}