import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/pages/0.8.0/home/sidebar.dart';
import 'package:open_configurator/pages/0.8.0/nvram/nvram_page.dart';

class HomePage080 extends StatefulWidget {
  final Function onReset;
  const HomePage080({this.onReset});
  @override
  _HomePage080State createState() => _HomePage080State();
}

class _HomePage080State extends State<HomePage080> {

  Widget _page = NVRAMPage();

  void _setPage(Widget page) => setState(() => this._page = page);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          SideBar(setPage: _setPage, onReset: widget.onReset),
          Expanded(child: _page),
        ],
      ),
    );
  }
}
