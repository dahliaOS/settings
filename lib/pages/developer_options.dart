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
import 'package:settings/widgets/settings_page.dart';
import 'package:zenit_ui/zenit_ui.dart';

class SettingsPageDeveloperOptions extends StatefulWidget {
  const SettingsPageDeveloperOptions({super.key});

  @override
  _SettingsPageDeveloperOptionsState createState() => _SettingsPageDeveloperOptionsState();
}

class _SettingsPageDeveloperOptionsState extends State<SettingsPageDeveloperOptions> {
  bool _devModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: strings.settings.pagesDeveloperOptionsTitle,
      cards: [
        Card(
          child: Column(
            children: [
              ZenitSwitchListTile(
                title: Text(
                  strings.settings.pagesDeveloperOptionsDeveloperModeTileTitle,
                ),
                subtitle: Text(
                  strings.settings.pagesDeveloperOptionsDeveloperModeTileSubtitle,
                ),
                secondary: const Icon(Icons.developer_mode),
                value: _devModeEnabled,
                onChanged: (val) {
                  setState(() => _devModeEnabled = val);
                },
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  "Reset Database",
                ),
                subtitle: const Text(
                  "Needs restart to take effect",
                ),
                leading: const Icon(Icons.new_releases_outlined),
                trailing: ZenitTextButton(
                  onPressed: PreferencesService.current.clear,
                  child: const Text(
                    "Reset Database",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
