import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../models/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var settings = Settings();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: Scaffold(
            appBar: AppBar(title: const Text("Settings")),
            body: SettingsList(sections: [
              SettingsSection(title: const Text("Weather"), tiles: [
                SettingsTile(
                    title: const Text("Temperature Units"),
                    leading: const Icon(Icons.thermostat),
                    trailing: DropdownButton<TempUnits>(
                        items: const <DropdownMenuItem<TempUnits>>[
                          DropdownMenuItem(
                              child: Text("C"), value: TempUnits.C),
                          DropdownMenuItem(child: Text("F"), value: TempUnits.F)
                        ],
                        onChanged: (TempUnits? unit) {
                          setState(() {
                            settings.unit = unit ?? TempUnits.C;
                          });
                        },
                        value: settings.unit),
                    onPressed: (context) {}),
                SettingsTile(
                  title: const Text("Weather Data Source"),
                  leading: const Icon(Icons.cloud_outlined),
                  trailing: DropdownButton<APISource>(
                      items: const <DropdownMenuItem<APISource>>[
                        DropdownMenuItem(
                            child: Text("IQAir"), value: APISource.iqAir)
                      ],
                      onChanged: (APISource? api) {
                        setState(() {
                          settings.api = api ?? APISource.iqAir;
                        });
                      },
                      value: settings.api),
                  onPressed: (context) {},
                ),
                SettingsTile(
                    title: const Text("Show top favourite city in weather"),
                    leading: const Icon(Icons.favorite),
                    trailing: Checkbox(
                        onChanged: (bool? a) {
                          setState(() {
                            settings.showFavCity = !settings.showFavCity;
                          });
                        },
                        value: settings.showFavCity),
                    onPressed: (context) {})
              ])
            ])));
  }
}

Route createSettingsRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const double begin = 0.0;
      const double end = 1.0;
      const curve = Curves.linear;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );
      return FadeTransition(
        opacity: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
