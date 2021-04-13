import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

import 'kernel_add_widget.dart';
import 'kernel_block_widget.dart';
import 'kernel_emulate_widget.dart';
import 'kernel_force_widget.dart';
import 'kernel_patch_widget.dart';
import 'kernel_quirks_widget.dart';
import 'kernel_scheme_widget.dart';

class KernelPage extends StatefulWidget {
  @override
  _KernelPageState createState() => _KernelPageState();
}

class _KernelPageState extends State<KernelPage> {
  @override
  void initState() {
    super.initState();
    globals.changeColorMode2 = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: globals.isDark == true ? Color(0xff505050) : Colors.black.withOpacity(0.35),
              ),
              tabs: [
                Tab(text: "Add", icon: Icon(Icons.add, size: 19)),
                Tab(text: "Block", icon: Icon(Icons.block, size: 19)),
                Tab(text: "Emulate", icon: Icon(Icons.add_to_queue, size: 19)),
                Tab(text: "Force", icon: Icon(Icons.whatshot, size: 19)),
                Tab(text: "Patch", icon: Icon(Icons.construction_outlined, size: 19)),
                Tab(text: "Quirks", icon: Icon(Icons.auto_awesome, size: 19)),
                Tab(text: "Scheme", icon: Icon(Icons.layers_outlined, size: 19)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            KernelAddWidget(),
            KernelBlockWidget(),
            KernelEmulateWidget(),
            KernelForceWidget(),
            KernelPatchWidget(),
            KernelQuirksWidget(),
            KernelSchemeWidget(),
          ],
        ),
      ),
    );
  }
}
