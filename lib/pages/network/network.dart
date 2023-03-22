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
import 'package:settings/widgets/settings_card.dart';
import 'package:settings/widgets/settings_page.dart';

class SettingsPageNetwork extends StatefulWidget {
  const SettingsPageNetwork({super.key});

  @override
  _SettingsPageNetworkState createState() => _SettingsPageNetworkState();
}

class _SettingsPageNetworkState extends State<SettingsPageNetwork> {
  bool _wifiEnabled = false;
  bool _ethernetEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: strings.settings.pagesNetworkTitle,
      cards: const [
        SettingsCard(
          children: [
            ListTile(
              //TODO add localization String
              title: Text("Not supported on this platform"),
            ),
          ],
        ),
      ],
    );
  }
}
