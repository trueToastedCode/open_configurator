import 'package:open_configurator/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckboxInDictWidget extends StatefulWidget {
  final double width, height;
  final String title;
  final Function setTitle, setType, getValue, setValue, onRm, isNewKeyValid;
  const CheckboxInDictWidget({this.width, this.height, this.title, this.setTitle, this.setType, this.getValue, this.setValue, this.onRm, this.isNewKeyValid});
  @override
  _CheckboxInDictWidgetState createState() => _CheckboxInDictWidgetState();
}

class _CheckboxInDictWidgetState extends State<CheckboxInDictWidget> {
  final _controllerTitle = TextEditingController();
  FocusNode _focusTitle = FocusNode();
  String _titleBefore;

  @override
  void initState() {
    super.initState();
    _controllerTitle.text = widget.title;
    _focusTitle.addListener(_onFocusTitleChange);
  }

  void _onTitleChange() {
    widget.setTitle(_controllerTitle.text);
    final textBefore = String.fromCharCodes(_titleBefore.codeUnits);
    globals.undoList.add(() {
      _controllerTitle.text = textBefore;
      widget.setTitle(_controllerTitle.text);
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
                  hintText: "key",
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
                value: "bool",
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
              child: Align(
                alignment: Alignment.centerRight,
                child: Checkbox(
                  activeColor: Colors.blue,
                  value: widget.getValue() == "1" ? true : false,
                  onChanged: (value) => value == true ? _onCheck(true) : _onUncheck(true),
                  splashRadius: 15.0,
                ),
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
            )
          ],
        ),
      ),
    );
  }
}
