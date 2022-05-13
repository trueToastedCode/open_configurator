import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/string_in_dict_widget.dart';

import 'checkbox_in_dict_widget.dart';
import 'data_in_dict_widget.dart';
import 'number_in_dict_widget.dart';

class DictDictNoTreeWidget extends StatefulWidget {
  final double width, height, itemWidth, itemHeight;
  final Function getDict, setDict;
  const DictDictNoTreeWidget({this.width, this.height, this.getDict, this.setDict, this.itemWidth, this.itemHeight});
  @override
  _DictDictNoTreeWidgetState createState() => _DictDictNoTreeWidgetState();
}

class _DictDictNoTreeWidgetState extends State<DictDictNoTreeWidget> with TickerProviderStateMixin {
  Map<String, dynamic> _dict;
  List<dynamic> _controllers = [];
  List<String> _textBefore = [];
  List<List<dynamic>> _animationList = [];

  /* TODO ensure that this widget works properly ;D This got a bit messy
  * - I noticed that sometimes a undo triggers that a entry is back but bot shown in the UI...
  */


  @override
  void initState() {
    super.initState();
    _dict = widget.getDict();
    final keys = _dict.keys.toList();
    for (int i=0; i<keys.length; i++) {
      final focusNode = FocusNode();
      final textController = TextEditingController();
      textController.text = keys[i];
      final list = [textController, focusNode];
      focusNode.addListener(() => _onKeyFocusChange(list));
      _controllers.add(list);
      _textBefore.add(null);
      final arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
      _animationList.add([
        arrowAnimationController,
        Tween(begin: 0.0, end: pi).animate(arrowAnimationController),
      ]);
    }
  }

  void _onAdd() {
    final key = "${_dict.keys.length+1}";
    final focusNode = FocusNode();
    final textController = TextEditingController();
    textController.text = key;
    final list = [textController, focusNode];
    focusNode.addListener(() => _onKeyFocusChange(list));
    _controllers.add(list);
    _dict.addAll({key: {"type": "dict", "content": {"1": {"type": "data", "content": ""}}}});
    _textBefore.add(null);
    final arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationList.add([
      arrowAnimationController,
      Tween(begin: 0.0, end: pi).animate(arrowAnimationController),
    ]);
    globals.undoList.add(() {
      final index = _controllers.indexOf(list);
      _dict.remove(key);
      _controllers.removeAt(index);
      _textBefore.removeAt(index);
      _animationList.removeAt(index);
      _setValue(null);
    });
    _setValue(null);
  }

  void _onKeyRm(String key) {
    final mapBcup = _dict[key];
    final index = _dict.keys.toList().indexOf(key);
    _dict.remove(key);
    _controllers.removeAt(index);
    _textBefore.removeAt(index);
    _animationList.removeAt(index);
    globals.undoList.add(() {
      final focusNode = FocusNode();
      final textController = TextEditingController();
      textController.text = key;
      final list = [textController, focusNode];
      focusNode.addListener(() => _onKeyFocusChange(list));
      _controllers.add(list);
      _dict.addAll({key: mapBcup});
      _textBefore.add(null);
        final arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
        _animationList.add([
          arrowAnimationController,
          Tween(begin: 0.0, end: pi).animate(arrowAnimationController),
        ]);
        _setValue(null);
    });
    _setValue(null);
  }

  void _onKeyChange(String key, String newKey, bool withUndo) {
    if (_isKeyValid(newKey)) {
      Map<String, dynamic> newMap = {};
      for (final iterKey in _dict.keys.toList()) {
        if (iterKey != key) newMap[iterKey] = _dict[iterKey];
        else newMap[newKey] = _dict[iterKey];
      }
      _dict = newMap;
      if (withUndo) globals.undoList.add(() {
        _onKeyChange(newKey, key, false);
        for (int i=0; i<_controllers.length; i++) if (_controllers[i][0].text == newKey) {
          _controllers[i][0].text = key;
          break;
        }
      });
      _setValue(null);
    }else {
      for (int i=0; i<_controllers.length; i++) if (_controllers[i][0].text == newKey) {
        _controllers[i][0].text = key;
        break;
      }
    }
  }

  void _onKeyFocusChange(List<dynamic> controllerList) {
    final index = _controllers.indexOf(controllerList);
    if (_controllers[index][1].hasFocus) {
      _textBefore[index] = _controllers[index][0].text;
      setState(() {});
    }else {
      if (_textBefore[index] != _controllers[index][0].text) _onKeyChange(_textBefore[index], _controllers[index][0].text, true);
      _textBefore[index] = null;
    }
  }

  bool _isKeyValid(String newKey) {
    if (newKey.length == 0 || String.fromCharCodes(newKey.codeUnits).replaceAll(" ", "").length == 0) return false;
    return !_dict.keys.toList().contains(newKey);
  }

  bool _isKeyInChildValid(String mainKey, String newKey) {
    if (newKey.length == 0 || String.fromCharCodes(newKey.codeUnits).replaceAll(" ", "").length == 0) return false;
    return !_dict[mainKey]["content"].keys.toList().contains(newKey);
  }

  List<Widget> _buildWidgetsNoTree(String key) {
    List<Widget> widgets = [];
    final map = _dict[key]["content"];
    for (final key2 in map.keys) {
      switch (map[key2]["type"]) {
        case "data":
          widgets.addAll([
            DataInDictWidget(
              title: key2,
              width: widget.itemWidth,
              height: widget.itemHeight,
              getValue: () => _dict[key]["content"][key2]["content"],
              setValue: (value) => _setValue(() => _dict[key]["content"][key2]["content"] = value),
              setTitle: (value) => _onKeyInChildChange(key, key2, value),
              onRm: () => _onRmInChild(key, key2, true),
              setType: (value) => _onTypeChange(key, key2, value),
              isNewKeyValid: (value) => _isKeyInChildValid(key, value),
            ),
            SizedBox(height: 5),
          ]);
          break;
        case "string":
          widgets.addAll([
            StringInDictWidget(
              title: key2,
              width: widget.itemWidth,
              height: widget.itemHeight,
              getValue: () => _dict[key]["content"][key2]["content"],
              setValue: (value) => _setValue(() => _dict[key]["content"][key2]["content"] = value),
              setTitle: (value) => _onKeyInChildChange(key, key2, value),
              onRm: () => _onRmInChild(key, key2, true),
              setType: (value) => _onTypeChange(key, key2, value),
              isNewKeyValid: (value) => _isKeyInChildValid(key, value),
            ),
            SizedBox(height: 5),
          ]);
          break;
        case "integer":
          widgets.addAll([
            NumberInDictWidget(
              title: key2,
              width: widget.itemWidth,
              height: widget.itemHeight,
              getValue: () => _dict[key]["content"][key2]["content"],
              setValue: (value) => _setValue(() => _dict[key]["content"][key2]["content"] = value),
              setTitle: (value) => _onKeyInChildChange(key, key2, value),
              onRm: () => _onRmInChild(key, key2, true),
              setType: (value) => _onTypeChange(key, key2, value),
              isNewKeyValid: (value) => _isKeyInChildValid(key, value),
            ),
            SizedBox(height: 5),
          ]);
          break;
        case "bool":
          widgets.addAll([
            CheckboxInDictWidget(
              title: key2,
              width: widget.itemWidth,
              height: widget.itemHeight,
              getValue: () => _dict[key]["content"][key2]["content"],
              setValue: (value) => _setValue(() => _dict[key]["content"][key2]["content"] = value),
              setTitle: (value) => _onKeyInChildChange(key, key2, value),
              onRm: () => _onRmInChild(key, key2, true),
              setType: (value) => _onTypeChange(key, key2, value),
              isNewKeyValid: (value) => _isKeyInChildValid(key, value),
            ),
            SizedBox(height: 5),
          ]);
          break;
      }
    }
    return widgets;
  }

  void _onKeyInChildChange(String mainKey, String key, String newKey) {
    final Map<String, dynamic> map = _dict[mainKey]["content"];
    Map<String, dynamic> newMap = {};
    for (final iterKey in map.keys.toList()) {
      if (iterKey != key) {
        newMap[iterKey] = map[iterKey];
      }else {
        newMap[newKey] = map[iterKey];
      }
    }
    _dict[mainKey]["content"] = newMap;
    _setValue(null);
  }

  void _onTypeChange(String mainKey, String key, String newType) {
    final before = Map.from(_dict[mainKey]["content"][key]);
    globals.undoList.add(() {
      // _dict[mainKey]["content"][key] = before;  // TODO _TypeError did occure here, ensure its working now
      _dict[mainKey]["content"][key]["type"] = before["type"];
      _dict[mainKey]["content"][key]["content"] = before["content"];
      _setValue(null);
    });
    // TODO fix conversion errors
    switch (_dict[mainKey]["content"][key]["type"]) {
      case "data":
        switch (newType) {
          case "data":
            break;
          case "bool":
            _dict[mainKey]["content"][key]["content"] = "0";
            break;
          case "string":
            _dict[mainKey]["content"][key]["content"] = _dict[mainKey]["content"][key]["content"].length == 0 ? "" : HEX.encode(base64.decode(_dict[mainKey]["content"][key]["content"]));
            break;
          case "integer":
            _dict[mainKey]["content"][key]["content"] = _dict[mainKey]["content"][key]["content"].length == 0 ? "0" : int.parse(HEX.encode(base64.decode(_dict[mainKey]["content"][key]["content"])), radix: 16).toString();
            break;
          default:
            throw Exception("Unable to convert");
        }
        break;
      case "bool":
        switch (newType) {
          case "data":
            _dict[mainKey]["content"][key]["content"] = base64.encode([int.parse(_dict[mainKey]["content"][key]["content"])]);
            break;
          case "bool":
          case "string":
          case "integer":
            break;
          default:
            throw Exception("Unable to convert");
        }
        break;
      case "string":
        switch (newType) {
          case "data":
            _dict[mainKey]["content"][key]["content"] = _dict[mainKey]["content"][key]["content"].length == 0 ? "" : base64.encode(HEX.decode(_dict[mainKey]["content"][key]["content"]));
            break;
          case "bool":
            _dict[mainKey]["content"][key]["content"] = "0";
            break;
          case "string":
            break;
          case "integer":
            if (_dict[mainKey]["content"][key]["content"].length == 0) _dict[mainKey]["content"][key]["content"] = "0";
            else {
              final str = _dict[mainKey]["content"][key]["content"];
              String newStr = "";
              for (int i=0; i<str.length ; i++) if (["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."].contains(str[i])) newStr += str[i];
              if (newStr.length == 0) newStr = "0";
              _dict[mainKey]["content"][key]["content"] = newStr;
            }
            break;
          default:
            throw Exception("Unable to convert");
        }
        break;
      case "integer":
        switch (newType) {
          case "data":
            _dict[mainKey]["content"][key]["content"] = _dict[mainKey]["content"][key]["content"].length == 0 ? "" : base64.encode(HEX.decode(int.parse(_dict[mainKey]["content"][key]["content"]).toRadixString(16)));
            break;
          case "bool":
            _dict[mainKey]["content"][key]["content"] = "0";
            break;
          case "string":
          case "integer":
            break;
          default:
            throw Exception("Unable to convert");
        }
        break;
      default:
        throw Exception("Unable to convert");
    }
    _dict[mainKey]["content"][key]["type"] = newType;
    _setValue(null);
  }

  void _onRmInChild(String mainKey, String key, bool withUndo) {
    if (withUndo) {
      final Map<String, String> map = _dict[mainKey]["content"][key].cast<String, String>(); // TODO inspect if more cast errors
      globals.undoList.add(() {
        _dict[mainKey]["content"].addAll({key: map});
        _setValue(null);
      });
    }
    _dict[mainKey]["content"].remove(key);
    _setValue(null);
  }

  void _onAddInChild(String mainKey) {
    final key = "key${_dict[mainKey]["content"].keys.length+1}";
    _dict[mainKey]["content"].addAll({key: {"type": "data", "content": ""}});
    _setValue(null);
    globals.undoList.add(() => _onRmInChild(mainKey, key, false));
  }

  void _setValue(Function localUpdateFunction) {
    if (localUpdateFunction != null) localUpdateFunction();
    widget.setDict(_dict);
    try {
      setState(() {});
    }catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.width == null || widget.width == -1) ? null : widget.width,
      height: (widget.height == null || widget.height == -1) ? null : widget.height,
      child: Column(
        children: [
          // Expanded(
          //   child: ListView(
          //     children: _dict.keys.map((String key) => Padding(
          //       padding: EdgeInsets.only(bottom: 5),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(15),
          //         child: Material(
          //           color: globals.isDark ? Color(0xff434547) : Color(0xffededed),
          //           child: ExpansionTile(
          //             onExpansionChanged: (value) {
          //               final controller = _animationList[_dict.keys.toList().indexOf(key)][0];
          //               controller.isCompleted
          //                   ? controller.reverse()
          //                   : controller.forward();
          //             },
          //             title: TextFormField(
          //               focusNode: _controllers[_dict.keys.toList().indexOf(key)][1],
          //               maxLines: 1,
          //               decoration: InputDecoration(
          //                 isDense: true,
          //                 border: InputBorder.none,
          //                 focusedBorder: InputBorder.none,
          //                 enabledBorder: InputBorder.none,
          //                 errorBorder: InputBorder.none,
          //                 disabledBorder: InputBorder.none,
          //                 hintText: "key",
          //                 contentPadding: EdgeInsets.only(top: 17),
          //               ),
          //               style: TextStyle(fontSize: 12),
          //               textAlignVertical: TextAlignVertical.bottom,
          //               controller: _controllers[_dict.keys.toList().indexOf(key)][0],
          //               textAlign: TextAlign.left,
          //             ),
          //             trailing: Container(
          //               // color: Colors.blue.withOpacity(0.1),
          //               width: 75,
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   SizedBox(
          //                     width: 25,
          //                     child: _controllers[_dict.keys.toList().indexOf(key)][1].hasFocus
          //                         ? IconButton(
          //                             icon: Icon(Icons.check, size: 17, color: Colors.green),
          //                             onPressed: () => setState(() => _controllers[_dict.keys.toList().indexOf(key)][1].unfocus()),
          //                             padding: EdgeInsets.all(0),
          //                             splashRadius: 12,
          //                           )
          //                         : IconButton(
          //                             icon: Icon(Icons.edit, size: 15, color: Colors.blue,),
          //                             onPressed: () => setState(() => _controllers[_dict.keys.toList().indexOf(key)][1].requestFocus()),
          //                             padding: EdgeInsets.all(0),
          //                             splashRadius: 12,
          //                           ),
          //                   ),
          //                   SizedBox(
          //                     width: 25,
          //                     child: IconButton(
          //                       onPressed: () => _onKeyRm(key),
          //                       icon: Icon(Icons.delete, size: 15, color: Colors.red),
          //                       padding: EdgeInsets.all(0),
          //                       splashRadius: 12,
          //                     ),
          //                   ),
          //                   AnimatedBuilder(
          //                     animation: _animationList[_dict.keys.toList().indexOf(key)][0],
          //                     builder: (context, child) => Transform.rotate(
          //                       angle: _animationList[_dict.keys.toList().indexOf(key)][1].value,
          //                       child: Icon(
          //                         Icons.expand_more,
          //                         size: 22.0,
          //                         color: Colors.blue,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             children: [
          //               ..._buildWidgetsNoTree(key),
          //               SizedBox(height: 5),
          //               ClipRRect(
          //                 borderRadius: BorderRadius.circular(15),
          //                 child: Container(
          //                   // color: globals.isDark ? Color(0xff383b3d) : Color(0xffd4d4d4),
          //                   color: Colors.black.withOpacity(0.2),
          //                   height: 20,
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.end,
          //                     children: [
          //                       SizedBox(
          //                         width: 25,
          //                         child: IconButton(
          //                           onPressed: () => _onAddInChild(key),
          //                           icon: Icon(Icons.add, size: 20),
          //                           padding: EdgeInsets.all(0),
          //                           splashRadius: 12,
          //                         ),
          //                       ),
          //                       SizedBox(width: 20),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     )).toList(),
          //   ),
          // ),
          ..._dict.keys.map((String key) => Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                color: globals.isDark ? Color(0xff434547) : Color(0xffededed),
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    final controller = _animationList[_dict.keys.toList().indexOf(key)][0];
                    controller.isCompleted
                        ? controller.reverse()
                        : controller.forward();
                  },
                  title: TextFormField(
                    focusNode: _controllers[_dict.keys.toList().indexOf(key)][1],
                    maxLines: 1,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "key",
                      contentPadding: EdgeInsets.only(top: 0),
                    ),
                    style: TextStyle(fontSize: 12),
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: _controllers[_dict.keys.toList().indexOf(key)][0],
                    textAlign: TextAlign.left,
                  ),
                  trailing: Container(
                    // color: Colors.blue.withOpacity(0.1),
                    width: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 25,
                          child: _controllers[_dict.keys.toList().indexOf(key)][1].hasFocus
                              ? IconButton(
                            icon: Icon(Icons.check, size: 17, color: Colors.green),
                            onPressed: () => setState(() => _controllers[_dict.keys.toList().indexOf(key)][1].unfocus()),
                            padding: EdgeInsets.all(0),
                            splashRadius: 12,
                          )
                              : IconButton(
                            icon: Icon(Icons.edit, size: 15, color: Colors.blue,),
                            onPressed: () => setState(() => _controllers[_dict.keys.toList().indexOf(key)][1].requestFocus()),
                            padding: EdgeInsets.all(0),
                            splashRadius: 12,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          child: IconButton(
                            onPressed: () => _onKeyRm(key),
                            icon: Icon(Icons.delete, size: 15, color: Colors.red),
                            padding: EdgeInsets.all(0),
                            splashRadius: 12,
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _animationList[_dict.keys.toList().indexOf(key)][0],
                          builder: (context, child) => Transform.rotate(
                            angle: _animationList[_dict.keys.toList().indexOf(key)][1].value,
                            child: Icon(
                              Icons.expand_more,
                              size: 22.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ..._buildWidgetsNoTree(key),
                    SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        // color: globals.isDark ? Color(0xff383b3d) : Color(0xffd4d4d4),
                        color: Colors.black.withOpacity(0.2),
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                onPressed: () => _onAddInChild(key),
                                icon: Icon(Icons.add, size: 20),
                                padding: EdgeInsets.all(0),
                                splashRadius: 12,
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              // color: globals.isDark ? Color(0xff383b3d) : Color(0xffd4d4d4),
              color: Colors.black.withOpacity(0.2),
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 25,
                    child: IconButton(
                      onPressed: _onAdd,
                      icon: Icon(Icons.add, size: 20),
                      padding: EdgeInsets.all(0),
                      splashRadius: 12,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
