import 'package:flutter/services.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberInDictWidget extends StatefulWidget {
  final double width, height;
  final String title;
  final Function setTitle, setType, getValue, setValue, onRm, isNewKeyValid;
  const NumberInDictWidget({this.width, this.height, this.title, this.setTitle, this.setType, this.getValue, this.setValue, this.onRm, this.isNewKeyValid});
  @override
  _NumberInDictWidgetState createState() => _NumberInDictWidgetState();
}

class _NumberInDictWidgetState extends State<NumberInDictWidget> {
  final _controllerTitle = TextEditingController(), _controllerValue = TextEditingController();
  FocusNode _focusTitle = FocusNode(), _focusValue = FocusNode();
  String _titleBefore, _valueBefore;

  @override
  void initState() {
    super.initState();
    _controllerTitle.text = widget.title;
    _focusTitle.addListener(_onFocusTitleChange);
    _controllerValue.text = widget.getValue();
    _focusValue.addListener(_onFocusValueChange);
  }

  void _onTitleChange() {
    widget.setTitle(_controllerTitle.text);
    final textBefore = String.fromCharCodes(_titleBefore.codeUnits);
    globals.undoList.add(() {
      _controllerTitle.text = textBefore;
      widget.setTitle(_controllerTitle.text);
    });
  }

  void _onValueChange() {
    if (_controllerValue.text.length == 0) _controllerValue.text = "0";
    widget.setValue(_controllerValue.text);
    final textBefore = String.fromCharCodes(_valueBefore.codeUnits);
    globals.undoList.add(() {
      _controllerValue.text = textBefore;
      widget.setValue(_controllerValue.text);
    });
  }

  void _onFocusTitleChange() {
    if (_focusTitle.hasFocus) _titleBefore = _controllerTitle.text;
    else {
      if (_titleBefore != _controllerTitle.text) {
        if (widget.isNewKeyValid(_controllerTitle.text)) _onTitleChange();
        else _controllerTitle.text = _titleBefore;
      }
      _titleBefore = null;
    }
  }

  void _onFocusValueChange() {
    if (_focusValue.hasFocus) _valueBefore = _controllerValue.text;
    else {
      if (_valueBefore != _controllerValue.text) _onValueChange();
      _valueBefore = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: Colors.black.withOpacity(0.2),
        width: (widget.width == null || widget.width == -1) ? null : widget.width,
        height: (widget.height == null || widget.height == -1) ? null : widget.height,
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                focusNode: _focusTitle,
                maxLines: 1,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "integer",
                  contentPadding: EdgeInsets.only(top: 17),
                ),
                style: TextStyle(fontSize: 12),
                textAlignVertical: TextAlignVertical.bottom,
                controller: _controllerTitle,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(width: 5),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: "integer",
                icon: const Icon(Icons.settings, color: Colors.blue, size: 13),
                style: TextStyle(color: Colors.blue, fontSize: 13),
                onChanged: (value) => widget.setType(value),
                items: <String>["string", "data", "bool", "integer"].map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                )).toList(),
              ),
            ),
            Flexible(
              child: TextFormField(
                focusNode: _focusValue,
                maxLines: 1,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "integer",
                  contentPadding: EdgeInsets.only(top: 17),
                ),
                style: TextStyle(fontSize: 12),
                textAlignVertical: TextAlignVertical.bottom,
                controller: _controllerValue,
                textAlign: TextAlign.right,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
                ],
              ),
            ),
            SizedBox(
              width: 25,
              child: IconButton(
                onPressed: widget.onRm,
                icon: Icon(Icons.delete, size: 15, color: Colors.red),
                padding: EdgeInsets.all(0),
                splashRadius: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
