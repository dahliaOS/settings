import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
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
import 'package:zenit_ui/zenit_ui.dart';

final settingsPages = <ZenitLayoutItem>[
  ZenitLayoutItem(
    titleBuilder: (context) => const Text("Network"),
    pageBuilder: (context) => const SettingsPageNetwork(),
    iconBuilder: (context, selected) => const Icon(Icons.wifi),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesConnectionsTitle),
    iconBuilder: (context, selected) => const Icon(Icons.devices_rounded),
    pageBuilder: (context) => const SettingsPageConnectedDevices(),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesCustomizationTitle),
    iconBuilder: (context, selected) => const Icon(Icons.color_lens_outlined),
    pageBuilder: (context) => const SettingsPageCustomization(),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesDisplayTitle),
    iconBuilder: (context, selected) => const Icon(Icons.desktop_windows),
    pageBuilder: (context) => const SettingsPageDisplay(),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesSoundTitle),
    iconBuilder: (context, selected) => const Icon(Icons.volume_up_rounded),
    pageBuilder: (context) => const SettingsPageSound(),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesLocaleTitle),
    iconBuilder: (context, selected) => const Icon(Icons.translate_rounded),
    pageBuilder: (context) => const SettingsPageLocale(),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesNotificationsTitle),
    iconBuilder: (context, selected) => const Icon(Icons.notifications_none_rounded),
    pageBuilder: (context) => const SettingsPageNotifications(),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesApplicationsTitle),
    iconBuilder: (context, selected) => const Icon(Icons.apps_rounded),
    pageBuilder: (context) => const SettingsPageApplications(),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesDeveloperOptionsTitle),
    iconBuilder: (context, selected) => const Icon(Icons.developer_mode_rounded),
    pageBuilder: (context) => const SettingsPageDeveloperOptions(),
  ),
  ZenitLayoutItem(
    titleBuilder: (context) => Text(strings.settings.pagesAboutTitle),
    iconBuilder: (context, selected) => const Icon(Icons.laptop_mac_rounded),
    pageBuilder: (context) => const SettingsPageAbout(),
  ),
];
