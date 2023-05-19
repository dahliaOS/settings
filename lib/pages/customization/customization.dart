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
import 'package:settings/data/presets.dart';
import 'package:settings/widgets/accent_color_button.dart';
import 'package:settings/widgets/settings_content_header.dart';
import 'package:settings/widgets/settings_page.dart';
import 'package:settings/widgets/taskbar_alignment_button.dart';
import 'package:settings/widgets/theme_mode_button.dart';

class SettingsPageCustomization extends StatefulWidget {
  const SettingsPageCustomization({super.key});

  @override
  _SettingsPageCustomizationState createState() => _SettingsPageCustomizationState();
}

class _SettingsPageCustomizationState extends State<SettingsPageCustomization>
    with StateServiceListener<CustomizationService, SettingsPageCustomization> {
  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    return SettingsPage(
      title: strings.settings.pagesCustomizationTitle,
      cards: [
        SettingsContentHeader(strings.settings.pagesCustomizationTheme),
        Card(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: SettingsPresets.themeModePresets.map((e) => ThemeModeButton(model: e)).toList(),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: BuiltinColor.values.map((e) => AccentColorButton(color: e)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SettingsContentHeader("Taskbar Alignment"),
        //TODO make this strings.settings.pagesCustomizationTaskbarAlignment
        Card(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        SettingsPresets.taskbarAlignmentPresets.map((e) => TaskbarAlignmentButton(model: e)).toList(),
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
