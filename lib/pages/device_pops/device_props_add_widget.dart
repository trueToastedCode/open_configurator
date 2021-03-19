import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/dict_no_tree_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class DevicePropsAddWidget extends StatefulWidget {
  @override
  _DevicePropsAddWidgetState createState() => _DevicePropsAddWidgetState();
}

class _DevicePropsAddWidgetState extends State<DevicePropsAddWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DictDictNoTreeWidget(
            width: 600,
            getDict: () => globals.pConfig.getValue(["content", "DeviceProperties", "content", "Add", "content"], null),
            setDict: (value) => globals.pConfig.setValue(["content", "DeviceProperties", "content", "Add", "content"], value, null),
          ),
        ),
      ],
    );
  }
}
