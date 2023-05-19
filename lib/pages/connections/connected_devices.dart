/*
Copyright 2021 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:settings/widgets/list_tiles.dart';
import 'package:settings/widgets/settings_content_header.dart';
import 'package:settings/widgets/settings_page.dart';

class SettingsPageConnectedDevices extends StatelessWidget {
  const SettingsPageConnectedDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: strings.settings.pagesConnectionsTitle,
      cards: [
        SettingsContentHeader(strings.settings.pagesConnectionsBluetooth),
        Card(
          child: Column(
            children: [
              ExpandableZenitSwitchListTile(
                value: false,
                onChanged: (val) {},
                title: Text(
                  strings.settings.pagesConnectionsBluetoothSwitchTileTitle,
                ),
                subtitle: Text(
                  strings.settings.pagesConnectionsBluetoothSwitchTileSubtitleDisabled,
                ),
                leading: const Icon(Icons.bluetooth_rounded),
              ),
              RouterListTile(
                title: Text(
                  strings.settings.pagesConnectionsBluetoothFileTransferTileTitle,
                ),
                leading: const Icon(Icons.file_copy_rounded),
              ),
            ],
          ),
        ),
        SettingsContentHeader(
          strings.settings.pagesConnectionsPhoneIntegration,
        ),
        Card(
          child: Column(
            children: [
              ExpandableListTile(
                value: false,
                title: Text(
                  strings.settings.pagesConnectionsPhoneIntegrationTileTitle,
                ),
                subtitle: Text(
                  strings.settings.pagesConnectionsPhoneIntegrationTileSubtitle,
                ),
                leading: const Icon(Icons.phone_android_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
