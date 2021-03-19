import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

class StringArrayWidget extends StatefulWidget {
  final double width, height;
  final Function getStringArray, setStringArray;
  const StringArrayWidget({this.width, this.height, this.getStringArray, this.setStringArray});
  @override
  _StringArrayWidgetState createState() => _StringArrayWidgetState();
}

class _StringArrayWidgetState extends State<StringArrayWidget> {
  List<TextEditingController> _controllers = [];

  final _scrollController = ScrollController();
  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();
    for (final item in widget.getStringArray()) {
      final controller = TextEditingController();
      controller.text = item["content"];
      _controllers.add(controller);
    }
  }

  void _onAdd() => setState(() {
    final controller = TextEditingController();
    _controllers.add(controller);
    _onChange();
    globals.undoList.add(() {
      _controllers.remove(controller);
      _onChange();
      try {
        setState(() {});
      }catch (e) {}
    });
    _scrollToBottom();
  });

  void _onRm(TextEditingController controller) => setState(() {
    final index = _controllers.indexOf(controller);
    globals.undoList.add(() {
      _controllers.insert(index, controller);
      _onChange();
      try {
        setState(() {});
      }catch (e) {}
    });
    _controllers.remove(controller);
    _onChange();
  });

  void _onChange() {
    List<Map<String, dynamic>> list = [];
    if (_controllers.length != 0) for (final controller in _controllers) {
      if (controller.text.length != 0) list.add(<String, dynamic>{
        "type": "string",
        "content": controller.text,
      });
    }
    widget.setStringArray(list);
  }

  void _onUp(TextEditingController controller, bool withUndo) {
    final index = _controllers.indexOf(controller);
    if (index == -1 || index == 0) return;
    _controllers.removeAt(index);
    _controllers.insert(index-1, controller);
    _onChange();
    if (withUndo) globals.undoList.add(() => _onDown(controller, false));
    try {
      setState(() {});
    }catch (e) {}
  }

  void _onDown(TextEditingController controller, bool withUndo) {
    final index = _controllers.indexOf(controller);
    if (index == -1 || index == _controllers.length-1) return;
    _controllers.removeAt(index);
    _controllers.insert(index+1, controller);
    _onChange();
    if (withUndo) globals.undoList.add(() => _onUp(controller, false));
    try {
      setState(() {});
    }catch (e) {}
  }

  int _colorCounter;
  Color _getColor() {
    if (_colorCounter%2 == 0) {
      _colorCounter++;
      return Colors.blueAccent;
    }
    _colorCounter++;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _colorCounter = 1;
    return Container(
      width: (widget.width == null || widget.width == -1) ? null : widget.width,
      height: (widget.height == null || widget.height == -1) ? null : widget.height,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: _controllers.map((TextEditingController controller) => SizedBox(
                width: double.infinity,
                height: 25,
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "string",
                        ),
                        controller: controller,
                        style: TextStyle(fontSize: 12, color: _getColor()),
                        textAlignVertical: TextAlignVertical.bottom,
                        onFieldSubmitted: (e) => _onChange(),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: IconButton(
                          onPressed: () => _onUp(controller, true),
                          icon: Icon(Icons.keyboard_arrow_up, size: 11, color: Colors.green),
                          padding: EdgeInsets.all(0),
                          splashRadius: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: IconButton(
                          onPressed: () => _onDown(controller, true),
                          icon: Icon(Icons.keyboard_arrow_down, size: 11, color: Colors.blue),
                          padding: EdgeInsets.all(0),
                          splashRadius: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: IconButton(
                          onPressed: () => _onRm(controller),
                          icon: Icon(Icons.remove, size: 11, color: Colors.red),
                          padding: EdgeInsets.all(0),
                          splashRadius: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
          Container(
            height: 20,
            color: Colors.black.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _onAdd,
                  icon: Icon(Icons.add, size: 13),
                  padding: EdgeInsets.all(0),
                  splashRadius: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
