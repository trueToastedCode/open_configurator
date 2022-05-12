import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/data_widget.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/number_widget.dart';
import 'package:open_configurator/templates/string_widget.dart';

class NvramAddWidget extends StatefulWidget {
  @override
  _NvramAddWidgetState createState() => _NvramAddWidgetState();
}

class _NvramAddWidgetState extends State<NvramAddWidget> {
  @override
  Widget build(BuildContext context) {
    // This could have bve done easier made with mapping and the globals buildWidgetsNoTree, get&set value... however the code already exists now... no need to change it
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DataWidget(
          width: 270,
          title: "DefaultBackgroundColor",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14"]["content"]["DefaultBackgroundColor"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14"]["content"]["DefaultBackgroundColor"]["content"] = value,
        ),
        SizedBox(height: 4),
        DataWidget(
          width: 270,
          title: "rtc-blacklist",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102"]["content"]["rtc-blacklist"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102"]["content"]["rtc-blacklist"]["content"] = value,
        ),
        SizedBox(height: 4),
        StringWidget(
          width: 270,
          title: "#INFO (prev-lang:kbd)",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["#INFO (prev-lang:kbd)"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["#INFO (prev-lang:kbd)"]["content"] = value,
        ),
        SizedBox(height: 4),
        NumberWidget(
          width: 270,
          title: "ForceDisplayRotationInEFI",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["ForceDisplayRotationInEFI"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["ForceDisplayRotationInEFI"]["content"] = value,
        ),
        SizedBox(height: 4),
        DataWidget(
          width: 270,
          title: "SystemAudioVolume",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["SystemAudioVolume"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["SystemAudioVolume"]["content"] = value,
        ),
        SizedBox(height: 4),
        StringWidget(
          width: 270,
          title: "boot-args",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["boot-args"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["boot-args"]["content"] = value,
        ),
        SizedBox(height: 4),
        DataWidget(
          width: 270,
          title: "csr-active-config",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["csr-active-config"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["csr-active-config"]["content"] = value,
        ),
        SizedBox(height: 4),
        DataWidget(
          width: 270,
          title: "prev-lang:kbd",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["prev-lang:kbd"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["prev-lang:kbd"]["content"] = value,
        ),
        SizedBox(height: 4),
        StringWidget(
          width: 270,
          title: "run-efi-updater",
          getValue: () => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["run-efi-updater"]["content"],
          setValue: (value) => globals.pConfig.pConfig["content"]["NVRAM"]["content"]["Add"]["content"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]["content"]["run-efi-updater"]["content"] = value,
        ),
      ],
    );
  }
}
