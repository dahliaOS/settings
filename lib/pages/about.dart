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
import 'package:settings/widgets/settings_card.dart';
import 'package:settings/widgets/settings_content_header.dart';

class SettingsPageAbout extends StatelessWidget {
  const SettingsPageAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: 200,
                color: context.theme.accent,
              ),
              Image.asset(
                "assets/images/other/about-mask.png",
                width: double.maxFinite,
                height: 200,
                fit: BoxFit.fitWidth,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                    ),
                    Image.asset(
                      "assets/images/logos/dahliaOS-white.png",
                      height: 50,
                    ),
                    const Text(
                      //TODO Localize
                      "0",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(50),
            child: Column(
              children: [
                SettingsContentHeader(
                  strings.settings.pagesAboutSystemInformation,
                ),
                SettingsCard(
                  children: [
                    ListTile(
                      title: Text(
                        strings.settings.pagesAboutSystemInformationEnvironment,
                      ),
                      subtitle: const Text("0"),
                      leading: const Icon(Icons.memory),
                    ),
                    ListTile(
                      title: Text(
                        strings
                            .settings.pagesAboutSystemInformationArchitecture,
                      ),
                      subtitle: const Text("0"),
                      leading: const Icon(Icons.architecture),
                    ),
                    ListTile(
                      title: Text(
                        strings.settings.pagesAboutSystemInformationDesktop,
                      ),
                      subtitle: const Text("Settings 0"),
                      leading: const Icon(Icons.desktop_mac),
                    )
                  ],
                ),
                SettingsContentHeader(
                  strings.settings.pagesAboutSoftwareUpdate,
                ),
                SettingsCard(
                  children: [
                    ListTile(
                      title: Text(
                        strings.settings
                            .pagesAboutSoftwareUpdateTileTitle("220222"),
                      ),
                      subtitle: Text(
                        strings.settings.pagesAboutSoftwareUpdateTileSubtitle(
                          "2/22/2022",
                        ),
                      ),
                      leading: const Icon(Icons.update),
                      trailing: ElevatedButton(
                        onPressed: null,
                        child: Padding(
                          padding: ThemeConstants.buttonPadding,
                          child: const Text(
                            "Check for update",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SettingsContentHeader("Legal"),
                SettingsCard(
                  children: [
                    RouterListTile(
                      leading: const Icon(Icons.info_outline_rounded),
                      title: const Text("Licenses"),
                      subtitle: const Text("Show third party licenses"),
                      onTap: () => showLicensePage(
                        context: context,
                        applicationName: "Settings",
                        applicationIcon: Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Image.asset(
                            "assets/images/logos/pangolin.png",
                            height: 64,
                            width: 64,
                          ),
                        ),
                        applicationLegalese: "Apache-2.0 License",
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
