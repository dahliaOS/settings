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

import 'package:animations/animations.dart';
import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/locale.dart' as intl;
import 'package:provider/provider.dart';
import 'package:settings/pages/about.dart';
import 'package:settings/pages/applications.dart';
import 'package:settings/pages/connections/connected_devices.dart';
import 'package:settings/pages/customization/customization.dart';
import 'package:settings/pages/developer_options.dart';
import 'package:settings/pages/display.dart';
import 'package:settings/pages/locale.dart';
import 'package:settings/pages/network/network.dart';
import 'package:settings/pages/notifications.dart';
import 'package:settings/pages/sound.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

void main() {
  runApp(
    ServiceBuilderWidget(
      services: [
        const ServiceEntry<LocaleService>(LocaleService.build),
        ServiceEntry<PreferencesService>(
          PreferencesService.build,
          PreferencesService.fallback(),
        ),
        const ServiceEntry<CustomizationService>(CustomizationService.build),
      ],
      builder: (context, loaded, child) {
        if (!loaded) return const ColoredBox(color: Colors.black);

        return ListenableServiceBuilder<CustomizationService>(
          builder: (context, child) {
            final CustomizationService service = CustomizationService.current;
            return YatlApp(
              core: yatl,
              getLocale: () =>
                  intl.Locale.tryParse(service.locale)?.toFlutterLocale(),
              setLocale: (locale) => service.locale = locale?.toString(),
              child: child!,
            );
          },
          child: child,
        );
      },
      child: const Settings(),
    ),
  );
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => _SettingsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: buildDahliaTheme(context),
        home: const Scaffold(
          backgroundColor: Colors.transparent,
          body: _SettingsHome(),
        ),
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          context.localizationsDelegate,
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _SettingsHome extends StatefulWidget {
  const _SettingsHome();

  @override
  State<_SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<_SettingsHome> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Consumer<_SettingsProvider>(
      builder: (context, provider, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final bool isExpanded = constraints.maxWidth > 1024;

            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: isExpanded ? 340 : 90,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _settingsTiles.length,
                      itemBuilder: (context, index) {
                        //check if tile is a header
                        final bool isTile =
                            _settingsTiles[index].subtitle != null;
                        final bool isSelected = provider._pageIndex == index;

                        return !isTile && !isExpanded
                            ? const SizedBox(
                                height: 16,
                              )
                            : SizedBox(
                                height: !isTile ? 40 : 60,
                                child: Padding(
                                  padding: isTile
                                      ? const EdgeInsets.symmetric(
                                          vertical: 2.0,
                                          horizontal: 8,
                                        )
                                      : const EdgeInsets.only(left: 8),
                                  child: Tooltip(
                                    verticalOffset: 32,
                                    waitDuration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    showDuration:
                                        const Duration(milliseconds: 250),
                                    message: isExpanded
                                        ? ""
                                        : _settingsTiles[index].title,
                                    child: ListTile(
                                      dense: true,
                                      onTap: !isTile
                                          ? null
                                          : () {
                                              provider.pageIndex = index;
                                            },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      tileColor: isTile
                                          ? isSelected
                                              ? theme.accent
                                              : Colors.transparent
                                          : Colors.transparent,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: isTile ? 0.0 : 0,
                                        horizontal: 12,
                                      ),
                                      title: isExpanded
                                          ? Text(
                                              _settingsTiles[index].title,
                                              style: TextStyle(
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: isSelected
                                                    ? theme.foregroundColor
                                                    : null,
                                              ),
                                            )
                                          : const Text(""),
                                      subtitle: isTile
                                          ? isExpanded
                                              ? Text(
                                                  _settingsTiles[index]
                                                      .subtitle!,
                                                  style: TextStyle(
                                                    fontWeight: isSelected
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                    color: isSelected
                                                        ? theme.foregroundColor
                                                        : null,
                                                  ),
                                                )
                                              : const Text("")
                                          : null,
                                      leading: !isTile
                                          ? null
                                          : Container(
                                              margin: EdgeInsets.only(
                                                left: isExpanded ? 0 : 4,
                                              ),
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: theme.accent,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                _settingsTiles[index].icon,
                                                color: theme.foregroundColor,
                                                size: 20,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: PageTransitionSwitcher(
                    transitionBuilder:
                        (child, primaryAnimation, secondaryAnimation) {
                      return FadeThroughTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        fillColor: Colors.transparent,
                        child: child,
                      );
                    },
                    child: ClipRRect(
                      key: ValueKey(provider.pageIndex),
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(8)),
                      child: Scaffold(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        body: _settingsTiles[provider.pageIndex].page ??
                            const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SettingsTileData {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? page;

  const _SettingsTileData({
    required this.title,
    this.subtitle,
    this.icon,
    this.page,
  });
}

List<_SettingsTileData> get _settingsTiles => <_SettingsTileData>[
      //Search HEADER
      const _SettingsTileData(
        title: "Search",
      ),
      //Connectivity HEADER
      _SettingsTileData(
        title: strings.settings.headersConnectivity,
      ),
      //Connectivity TILES
      _SettingsTileData(
        title: strings.settings.pagesNetworkTitle,
        subtitle: strings.settings.pagesNetworkSubtitle,
        icon: Icons.wifi,
        page: const SettingsPageNetwork(),
      ),
      _SettingsTileData(
        title: strings.settings.pagesConnectionsTitle,
        subtitle: strings.settings.pagesConnectionsSubtitle,
        icon: Icons.devices_rounded,
        page: const SettingsPageConnectedDevices(),
      ),
      //Personalize HEADER
      _SettingsTileData(
        title: strings.settings.headersPersonalize,
      ),
      //Personalize TILES
      _SettingsTileData(
        title: strings.settings.pagesCustomizationTitle,
        subtitle: strings.settings.pagesCustomizationSubtitle,
        icon: Icons.color_lens_outlined,
        page: const SettingsPageCustomization(),
      ),

      //Device & applications HEADER
      _SettingsTileData(
        title: strings.settings.headersDevice,
      ),
      //Device & applications TILES
      _SettingsTileData(
        title: strings.settings.pagesDisplayTitle,
        subtitle: strings.settings.pagesDisplaySubtitle,
        icon: Icons.desktop_windows,
        page: const SettingsPageDisplay(),
      ),
      _SettingsTileData(
        title: strings.settings.pagesSoundTitle,
        subtitle: strings.settings.pagesSoundSubtitle,
        icon: Icons.volume_up_rounded,
        page: const SettingsPageSound(),
      ),
      _SettingsTileData(
        title: strings.settings.pagesLocaleTitle,
        subtitle: strings.settings.pagesLocaleSubtitle,
        icon: Icons.translate_rounded,
        page: const SettingsPageLocale(),
      ),
      _SettingsTileData(
        title: strings.settings.pagesNotificationsTitle,
        subtitle: strings.settings.pagesNotificationsSubtitle,
        icon: Icons.notifications_none_rounded,
        page: const SettingsPageNotifications(),
      ),
      _SettingsTileData(
        title: strings.settings.pagesApplicationsTitle,
        subtitle: strings.settings.pagesApplicationsSubtitle,
        icon: Icons.apps_rounded,
        page: const SettingsPageApplications(),
      ),
      //System HEADER
      _SettingsTileData(
        title: strings.settings.headersSystem,
      ),
      _SettingsTileData(
        title: strings.settings.pagesDeveloperOptionsTitle,
        subtitle: strings.settings.pagesDeveloperOptionsSubtitle,
        icon: Icons.developer_mode_rounded,
        page: const SettingsPageDeveloperOptions(),
      ),
      //System TILES
      _SettingsTileData(
        title: strings.settings.pagesAboutTitle,
        subtitle: strings.settings.pagesAboutSubtitle,
        icon: Icons.laptop_mac_rounded,
        page: const SettingsPageAbout(),
      ),
    ];

class _SettingsProvider extends ChangeNotifier {
  int? _pageIndex = 2;
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;
  int get pageIndex => _pageIndex!;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}
