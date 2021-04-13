import 'dart:convert';
import 'package:open_configurator/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:hex/hex.dart";

class DataWidget extends StatefulWidget {
  final double width, height;
  final String title;
  final Function getValue, setValue;
  final bool isTypeChange, isLeadingExtended, isTitleEditable;
  const DataWidget({this.title, this.getValue, this.setValue, this.width, this.height, this.isTypeChange, this.isLeadingExtended, this.isTitleEditable});
  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  final _controller = TextEditingController();
  String _textBefore;
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = HEX.encode(base64.decode(widget.getValue())); // Base64 <-> Hex <-> String
    _focus.addListener(_onFocusChange);
  }

  void _onChange() {
    if (_controller.text.length == 0) widget.setValue("");
    else widget.setValue(base64.encode(HEX.decode(_controller.text))); // String <-> Hex <-> Base64
    final textBefore = String.fromCharCodes(_textBefore.codeUnits);
    globals.undoList.add(() {
      _controller.text = textBefore;
      widget.setValue(textBefore.length == 0 ? "" : base64.encode(HEX.decode(textBefore)));
    });
    _textBefore = null;
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      _textBefore = _controller.text;
    }else if (_textBefore != _controller.text) {
      _onChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.width == null || widget.width == -1) ? null : widget.width,
      height: (widget.height == null || widget.height == -1) ? null : widget.height,
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Text(widget.title, style: TextStyle(fontSize: 14)),
          SizedBox(width: 5),
          Text("(data)", style: TextStyle(fontSize: 10, color: Colors.blue)),
          Flexible(
            child: TextFormField(
              focusNode: _focus,
              maxLines: 1,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "hex",
                contentPadding: EdgeInsets.only(top: 17),
              ),
              style: TextStyle(fontSize: 12),
              textAlignVertical: TextAlignVertical.bottom,
              controller: _controller,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
