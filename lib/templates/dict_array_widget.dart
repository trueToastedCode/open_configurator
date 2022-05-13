import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

import 'checkbox_widget.dart';
import 'data_widget.dart';
import 'number_widget.dart';
import 'string_widget.dart';

class DictArrayWidget extends StatefulWidget {
  final double width, height, itemWidth, itemHeight;
  final Function getArray, setArray, getDummyEntry;
  final String keyForHeader;
  const DictArrayWidget({this.width, this.height, this.getArray, this.setArray, this.keyForHeader, this.getDummyEntry, this.itemHeight, this.itemWidth});
  @override
  _DictArrayWidgetState createState() => _DictArrayWidgetState();
}

class _DictArrayWidgetState extends State<DictArrayWidget> with TickerProviderStateMixin {
  List<Map<String, dynamic>> _list = [];
  List<List<dynamic>> _animationList = [];

  @override
  void initState() {
    super.initState();
    _list = [...widget.getArray()];
    for (int i=0; i<_list.length; i++) {
      final arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
      _animationList.add([
        arrowAnimationController,
        Tween(begin: 0.0, end: pi).animate(arrowAnimationController),
      ]);
    }
  }

  List<Widget> _buildWidgetsNoTree(Map<String, dynamic> map) {
    List<Widget> widgets = [];
    for (final key in map["content"].keys) {
      switch (map["content"][key]["type"]) {
        case "bool":
          widgets.addAll([
            CheckboxWidget(
              title: key,
              width: widget.itemWidth,
              height: widget.itemHeight,
              getValue: () => _list[_list.indexOf(map)]["content"][key]["content"],
              setValue: (value) => _setValue(() => _list[_list.indexOf(map)]["content"][key]["content"] = value),
            ),
            SizedBox(height: 5),
          ]);
          break;
        case "integer":
          widgets.addAll([
            NumberWidget(
              title: key,
              width: widget.itemWidth,
              height: widget.itemHeight,
              getValue: () => _list[_list.indexOf(map)]["content"][key]["content"],
              setValue: (value) => _setValue(() => _list[_list.indexOf(map)]["content"][key]["content"] = value),
            ),
            SizedBox(height: 5),
          ]);
          break;
        case "data":
          widgets.addAll([
            DataWidget(
              title: key,
              width: widget.itemWidth,
              height: widget.itemHeight,
              getValue: () => _list[_list.indexOf(map)]["content"][key]["content"],
              setValue: (value) => _setValue(() => _list[_list.indexOf(map)]["content"][key]["content"] = value),
            ),
            SizedBox(height: 5),
          ]);
          break;
        case "string":
          widgets.addAll([
            StringWidget(
              title: key,
              width: widget.itemWidth,
              height: widget.itemHeight,
              getValue: () => _list[_list.indexOf(map)]["content"][key]["content"],
              setValue: (value) => _setValue(() => _list[_list.indexOf(map)]["content"][key]["content"] = value),
            ),
            SizedBox(height: 5),
          ]);
          break;
        default:
          throw UnimplementedError("Tried to build type \"${map[key]["type"]}\"");
      }
    }
    if (widgets.isNotEmpty) widgets.removeLast();
    return widgets;
  }

  void _setValue(Function localUpdateFunction) {
    localUpdateFunction();
    widget.setArray(_list);
    try {
      setState(() {});
    }catch (e) {}
  }

  int _entrieCounter;
  String _getEntrieHeader(Map<String, dynamic> map) {
    String str;
    if (widget.keyForHeader == null || map["content"][widget.keyForHeader]["content"].length == 0) str = "Item $_entrieCounter";
    else str = map["content"][widget.keyForHeader]["content"];
    _entrieCounter++;
    return str;
  }

  Color _getColorBasedOnEnabled(Map<String, dynamic> map) {
    for (final key in map["content"].keys) {
      if (map["content"][key]["type"] == "bool" && key == "Enabled") {
        return map["content"][key]["content"] == "1" ? Colors.green : Colors.red;
      }
    }
    return null;
  }

  void _onUp(Map<String, dynamic> map, bool withUndo) {
    final index = _list.indexOf(map);
    if (index == -1 || index == 0) return;
    _list.removeAt(index);
    _list.insert(index-1, map);
    widget.setArray(_list);
    if (withUndo) globals.undoList.add(() => _onDown(map, false));
    try {
      setState(() {});
    }catch (e) {}
  }

  void _onDown(Map<String, dynamic> map, bool withUndo) {
    final index = _list.indexOf(map);
    if (index == -1 || index == _list.length-1) return;
    _list.removeAt(index);
    _list.insert(index+1, map);
    widget.setArray(_list);
    if (withUndo) globals.undoList.add(() => _onUp(map, false));
    try {
      setState(() {});
    }catch (e) {}
  }

  void _onAdd(int index, Map<String, dynamic> map, bool withUndo) {
    if (index == -1) return;
    _list.insert(index, map);
    final arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationList.insert(index, [
      arrowAnimationController,
      Tween(begin: 0.0, end: pi).animate(arrowAnimationController),
    ]);
    widget.setArray(_list);
    if (withUndo) globals.undoList.add(() => _onRm(map, false));
    try {
      setState(() {});
    }catch (e) {}
  }

  void _onRm(Map<String, dynamic> map, bool withUndo) {
    final index = _list.indexOf(map);
    if (index == -1) return;
    _list.removeAt(index);
    _animationList.removeAt(index);
    widget.setArray(_list);
    if (withUndo) globals.undoList.add(() => _onAdd(index, map, false));
    try {
      setState(() {});
    }catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    _entrieCounter = 1;
    return Container(
      width: (widget.width == null || widget.width == -1) ? null : widget.width,
      height: (widget.height == null || widget.height == -1) ? null : widget.height,
      child: Column(
        children: [
          // Expanded(
          //   child: ListView(
          //     children: _list.map((Map<String, dynamic> map) => Padding(
          //       padding: EdgeInsets.only(bottom: 5),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(15),
          //         child: Material(
          //           color: globals.isDark ? Color(0xff434547) : Color(0xffededed),
          //           child: ExpansionTile(
          //             title: Text(_getEntrieHeader(map), style: TextStyle(color: _getColorBasedOnEnabled(map), fontSize: 12)),
          //             children: _buildWidgetsNoTree(map),
          //             onExpansionChanged: (value) {
          //               final controller = _animationList[_list.indexOf(map)][0];
          //               controller.isCompleted
          //                   ? controller.reverse()
          //                   : controller.forward();
          //             },
          //             trailing: Container(
          //               width: 125,
          //               // color: Colors.green,
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   SizedBox(
          //                     width: 25,
          //                     child: IconButton(
          //                       onPressed: () => _onUp(map, true),
          //                       icon: Icon(Icons.keyboard_arrow_up, size: 15, color: Colors.blue),
          //                       padding: EdgeInsets.all(0),
          //                       splashRadius: 12,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 25,
          //                     child: IconButton(
          //                       onPressed: () => _onDown(map, true),
          //                       icon: Icon(Icons.keyboard_arrow_down, size: 15, color: Colors.red),
          //                       padding: EdgeInsets.all(0),
          //                       splashRadius: 12,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 25,
          //                     child: IconButton(
          //                       onPressed: () => _onAdd(_list.indexOf(map), {"type": "dict", "content": widget.getDummyEntry()}, true),
          //                       icon: Icon(Icons.widgets_outlined, size: 15, color: Colors.blue),
          //                       padding: EdgeInsets.all(0),
          //                       splashRadius: 12,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 25,
          //                     child: IconButton(
          //                       onPressed: () => _onRm(map, true),
          //                       icon: Icon(Icons.delete, size: 15, color: Colors.red),
          //                       padding: EdgeInsets.all(0),
          //                       splashRadius: 12,
          //                     ),
          //                   ),
          //                   AnimatedBuilder(
          //                     animation: _animationList[_list.indexOf(map)][0],
          //                     builder: (context, child) => Transform.rotate(
          //                       angle: _animationList[_list.indexOf(map)][1].value,
          //                       child: Icon(
          //                         Icons.expand_more,
          //                         size: 22.0,
          //                         color: globals.isDark ? Colors.white : Colors.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )).toList(),
          //   ),
          // ),
          ..._list.map((Map<String, dynamic> map) => Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                color: globals.isDark ? Color(0xff434547) : Color(0xffededed),
                child: ExpansionTile(
                  title: Text(_getEntrieHeader(map), style: TextStyle(color: _getColorBasedOnEnabled(map), fontSize: 12)),
                  children: _buildWidgetsNoTree(map),
                  onExpansionChanged: (value) {
                    final controller = _animationList[_list.indexOf(map)][0];
                    controller.isCompleted
                        ? controller.reverse()
                        : controller.forward();
                  },
                  trailing: Container(
                    width: 125,
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 25,
                          child: IconButton(
                            onPressed: () => _onUp(map, true),
                            icon: Icon(Icons.keyboard_arrow_up, size: 15, color: Colors.blue),
                            padding: EdgeInsets.all(0),
                            splashRadius: 12,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          child: IconButton(
                            onPressed: () => _onDown(map, true),
                            icon: Icon(Icons.keyboard_arrow_down, size: 15, color: Colors.red),
                            padding: EdgeInsets.all(0),
                            splashRadius: 12,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          child: IconButton(
                            onPressed: () => _onAdd(_list.indexOf(map), {"type": "dict", "content": widget.getDummyEntry()}, true),
                            icon: Icon(Icons.widgets_outlined, size: 15, color: Colors.blue),
                            padding: EdgeInsets.all(0),
                            splashRadius: 12,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          child: IconButton(
                            onPressed: () => _onRm(map, true),
                            icon: Icon(Icons.delete, size: 15, color: Colors.red),
                            padding: EdgeInsets.all(0),
                            splashRadius: 12,
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _animationList[_list.indexOf(map)][0],
                          builder: (context, child) => Transform.rotate(
                            angle: _animationList[_list.indexOf(map)][1].value,
                            child: Icon(
                              Icons.expand_more,
                              size: 22.0,
                              color: globals.isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )).toList(),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: globals.isDark ? Color(0xff383b3d) : Color(0xffd4d4d4),
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 25,
                    child: IconButton(
                      onPressed: () => _onAdd(_list.length, {"type": "dict", "content": widget.getDummyEntry()}, true),
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
