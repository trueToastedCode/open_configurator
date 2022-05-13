import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/pages/0.8.0/uefi/uefi_apfs_widget.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_appleinput_widget.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_audio_widget.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_drivers_widget.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_input_widget.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_output_widget.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_protocol_overrides_widget.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_quirks_widget.dart';
import 'package:open_configurator/pages/0.8.0/uefi/uefi_reserved_memory_widget.dart';

class UEFIPage extends StatefulWidget {
  @override
  _UEFIPageState createState() => _UEFIPageState();
}

class _UEFIPageState extends State<UEFIPage> {
  @override
  void initState() {
    super.initState();
    globals.changeColorMode2 = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 9,
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
                  Tab(text: "APFS", icon: Icon(Icons.assistant_photo, size: 19)),
                  Tab(text: "AppleInput", icon: Icon(Icons.album, size: 19)),
                  Tab(text: "Audio", icon: Icon(Icons.speaker, size: 19)),
                  Tab(text: "Drivers", icon: Icon(Icons.drive_eta, size: 19)),
                  Tab(text: "Input", icon: Icon(Icons.keyboard, size: 19)),
                  Tab(text: "Output", icon: Icon(Icons.drive_file_move_outline, size: 19)),
                  Tab(text: "ProtocolOverrides", icon: Icon(Icons.edit_road_rounded, size: 19)),
                  Tab(text: "Quirks", icon: Icon(Icons.auto_awesome, size: 19)),
                  Tab(text: "ReservedMemory", icon: Icon(Icons.all_inbox, size: 19)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiAPFSWidget()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiAppleInputWidget()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiAudioWidget()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiDriversWidget()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiInputWidgets()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiOutputWidget()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiProtocolOverridesWidget()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiQuriksWidget()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: globals.INNER_PADDING),
                child: SingleChildScrollView(child: UefiReservedMemoryWidget()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
