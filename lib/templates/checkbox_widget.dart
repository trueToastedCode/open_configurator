import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

class CheckboxWidget extends StatefulWidget {
  final double width, height;
  final String title;
  final Function getValue, setValue;
  const CheckboxWidget({this.title, this.getValue, this.setValue, this.width, this.height});
  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {

  void _onCheck(bool withUndo) {
    widget.setValue("1");
    if (withUndo) globals.undoList.add(() => _onUncheck(false));
    try {
      setState(() {});
    }catch (e) {}
  }

  void _onUncheck(bool withUndo) {
    widget.setValue("0");
    if (withUndo) globals.undoList.add(() => _onCheck(false));
    try {
      setState(() {});
    }catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.width == null || widget.width == -1) ? null : widget.width,
      height: (widget.height == null || widget.height == -1) ? null : widget.height,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: TextStyle(fontSize: 14)),
          Checkbox(
            activeColor: Colors.blue,
            value: widget.getValue() == "1" ? true : false,
            onChanged: (value) => value == true ? _onCheck(true) : _onUncheck(true),
            splashRadius: 15.0,
          ),
        ],
      ),
    );
  }
}
