import 'package:open_configurator/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StringWidget extends StatefulWidget {
  final double width, height;
  final String title;
  final Function getValue, setValue;
  const StringWidget({this.title, this.getValue, this.setValue, this.width, this.height});
  @override
  _StringWidgetState createState() => _StringWidgetState();
}

class _StringWidgetState extends State<StringWidget> {
  final _controller = TextEditingController();
  String _textBefore;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.getValue();
    _focus.addListener(_onFocusChange);
  }

  void _onChange() {
    if (_textBefore != _controller.text) {
      widget.setValue(_controller.text);
      final textBefore = String.fromCharCodes(_textBefore.codeUnits);
      globals.undoList.add(() {
        _controller.text = textBefore;
        widget.setValue(textBefore);
      });
    }
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
          Text("(string)", style: TextStyle(fontSize: 10, color: Colors.blue)),
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
                hintText: "string",
                contentPadding: EdgeInsets.only(top: 17, right: 18),
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
