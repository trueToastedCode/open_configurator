import 'package:clipboard/clipboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_configurator/services/pconfig.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'dart:io' show Platform;

import 'package:permission_handler/permission_handler.dart';

class LoadConfigPage extends StatefulWidget {
  final Function onConfigLoaded;
  const LoadConfigPage({this.onConfigLoaded});
  @override
  _LoadConfigPageState createState() => _LoadConfigPageState();
}

class _LoadConfigPageState extends State<LoadConfigPage> {
  String _errorMsg, _dropdownValue = '0.8.0';
  static const _dropdownOptions = ['0.8.0'];

  Future<void> _loadConfig() async {
    // check permission
    bool storageError = false;
    // load
    String value;
    if (Platform.isAndroid) {
      // load form android
      if (! await Permission.storage.request().isGranted) storageError = true;
      // else if (! await Permission.manageExternalStorage.request().isGranted) storageError = true;
      if (storageError) {
        Fluttertoast.showToast(
          msg: "Please set ManageExternalStorage manually in Settings!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
        );
        return;
      }
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      value = result.files.single.path;
    } else if (Platform.isIOS) {
      // load from iOS / iPadOS
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      value = result.files.single.path;
    } else {
      // load from desktop os
      value = await FlutterClipboard.paste();
      if (value == null || value.length == 0) {
        // error: clipboard is empty
        _showError("Error (Clipboard is empty)");
        return;
      }
      // remove quotation marks
      if (value[0] == "\"" && value[value.length-1] == "\"") {
        value = value.substring(1, value.length-1);
        if (value.length == 0) {
          // error: clipboard is empty
          _showError("Error (Clipboard is empty)");
          return;
        }
      }
    }
    // read and parse file
    final pConfig = PConfig(path: value);
    try {
      await pConfig.read();
    }catch (e) {
      // error: read or parse
      _showError("Error (Reading or parsing file)");
      return;
    }
    // update globals and ui
    globals.pConfig = pConfig;
    widget.onConfigLoaded('0.8.0');
  }

  void _showError(String msg) async {
    setState(() => _errorMsg = msg == null ? "": msg);
    await Future.delayed(Duration(seconds: 1));
    setState(() => _errorMsg = null);
  }

  Widget _getErrorWidget() {
    return SizedBox(
      height: 20,
      child: _errorMsg == null
          ? null
          : Center(
              child: Text(
                _errorMsg,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
    );
  }

  final _gradient = LinearGradient(colors: [
    Color(0xffCD5A75),
    Color(0xffD169C8),
    Color(0xffBA6BFE)
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globals.isDark ? Color(0xff1a1a1a) : null,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: globals.isDark ? Colors.black.withOpacity(0.4) : /*Colors.white.withOpacity(0.7)Color(0xffEEEEEE)*/Colors.black.withOpacity(0.01),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: globals.isDark ? Colors.white38 : Colors.black54, width: 1),
              ),
              width: 380,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 22),
              child: Column(
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => _gradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      "OpenConfigurator",
                      style: TextStyle(
                        fontSize: 21,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 0),
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "OC ",
                          style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: -0.5,
                            color: Colors.red,
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _dropdownValue,
                            style: TextStyle(
                              fontSize: 15.0,
                              letterSpacing: -0.5,
                              color: Colors.red,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _dropdownValue = newValue;
                              });
                            },
                            items: _dropdownOptions.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [Color(0xff28CBA4), Color(0xff43E37E)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [0.1, 1],
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _loadConfig,
                          child: Center(
                            child: Text(
                              Platform.isAndroid || Platform.isIOS ? "Open" : "Paste path",
                              style: TextStyle(
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          splashColor: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...(globals.isMobile
                ? []
                : [
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.4),
                        // border: Border.all(color: Colors.white38, width: 1),
                      ),
                      width: 380,
                      child: Column(
                        children: [
                          Text(
                            "How to get the path",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "MacOS: Mark file in finder, press Cmd-Opt-C",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "Windows: Mark file in explorer, click home and copy path",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "Linux: Depends on Distro",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: 10),
                  _getErrorWidget(),
                ],
        ),
      ),
    );
  }
}
