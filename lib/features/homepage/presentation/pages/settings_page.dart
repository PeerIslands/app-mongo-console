import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/text_input_dialog.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/settings_repository.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final SettingsRepository _settingsRepository =
        injector<SettingsRepository>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: handleBackPressed,
        child: Container(
          child: Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBarDefault(title: 'Settings'),
                backgroundColor: primaryColor(context),
                body: StaggeredGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 50.0,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 30, bottom: 8),
                  children: <Widget>[
                    SettingsList(
                      sections: [
                        SettingsSection(
                          title: 'Basic',
                          tiles: [
                            SettingsTile(
                              iosChevron: null,
                              title: 'Language',
                              subtitle: 'English',
                              leading: Icon(Icons.language),
                              onPressed: (_) => doNothing(),
                            ),
                            SettingsTile(
                              iosChevron: null,
                              title: 'Environment',
                              subtitle: 'Develop',
                              leading: Icon(Icons.cloud),
                              onPressed: (_) => doNothing(),
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: 'Style',
                          tiles: [
                            SettingsTile.switchTile(
                              title: 'Dark mode',
                              leading: Icon(Icons.dark_mode),
                              switchValue: isThemeCurrentlyDark(context),
                              onToggle: (_) =>
                                  EasyDynamicTheme.of(context).changeTheme(),
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: 'Environment setup',
                          tiles: [
                            SettingsTile(
                              title: 'Client Id',
                              subtitle: '*******',
                              leading: Icon(Icons.password),
                              onPressed: (_) => displayTextInputDialog(
                                  context,
                                  'Client ID',
                                  '*******',
                                  (String value) => _settingsRepository
                                      .updateClientAndSecret(clientId: value)),
                            ),
                            SettingsTile(
                              title: 'Secret',
                              subtitle: '*******',
                              leading: Icon(Icons.password),
                              onPressed: (_) => displayTextInputDialog(
                                  context,
                                  'Secret',
                                  '*******',
                                  (String value) => _settingsRepository
                                      .updateClientAndSecret(secret: value)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                  staggeredTiles: [
                    StaggeredTile.extent(2, 580),
                  ],
                ),
              ),
              BottomMenuPage(),
            ],
          ),
        ),
      ),
    );
  }
}
