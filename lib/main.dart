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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/locale.dart' as intl;
import 'package:settings/pages.dart';
import 'package:yatl_flutter/yatl_flutter.dart';
import 'package:zenit_ui/zenit_ui.dart';

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
              getLocale: () => intl.Locale.tryParse(service.locale)?.toFlutterLocale(),
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
    return ListenableServiceBuilder<CustomizationService>(
      builder: (context, child) {
        return MaterialApp(
          theme: dahliaLightTheme,
          darkTheme: dahliaDarkTheme,
          themeMode: CustomizationService.current.darkMode ? ThemeMode.dark : ThemeMode.light,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          localizationsDelegates: [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            context.localizationsDelegate,
          ],
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: ZenitNavigationLayout(
        length: settingsPages.length,
        destinationBuilder: (context, index, selected) {
          return ZenitLayoutTile(
            title: settingsPages[index].titleBuilder(context),
            leading: settingsPages[index].iconBuilder(context, selected),
            selected: selected,
          );
        },
        pageBuilder: (context, index) => settingsPages[index].pageBuilder(context),
      ),
    );
  }
}
