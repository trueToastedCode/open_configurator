import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/pages/home/sidebar.dart';
import 'package:open_configurator/pages/nvram/nvram_page.dart';

class HomePage extends StatefulWidget {
  final Function onReset;
  const HomePage({this.onReset});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _page = NVRAMPage();
  void _setPage(Widget page) => setState(() => this._page = page);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          children: [
            SideBar(setPage: _setPage, onReset: widget.onReset),
            Expanded(child: _page),
          ],
        ),
      ),
    );
  }
}
