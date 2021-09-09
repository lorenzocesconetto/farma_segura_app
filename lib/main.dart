import 'package:farma_segura_app/providers/users_with_access.dart';
import 'package:farma_segura_app/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import './providers/inventories.dart';
import './providers/notification_service.dart';
import './providers/scheduled_medications.dart';
import './providers/backend_api.dart';
import './providers/selected_date.dart';
import './providers/profiles.dart';

import './widgets/adaptive_app.dart';
import './widgets/adaptive_scaffold_nav.dart';

import './screen_add_profile/main.dart';
import './screen_login/main.dart';
import './screen_manage/main.dart';
import './screen_settings/main.dart';
import './screen_add_medication/main.dart';
import './screen_day/main.dart';
import './screen_pharmacists/main.dart';
import './screen_symptoms/main.dart';

void main() async {
  // Wait for flutter to be initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize date formatting package
  await initializeDateFormatting('pt_BR', null);
  // Initialize notification system
  // await initializeSettings();
  // Initialize timezones package
  tz.initializeTimeZones();
  // Disallow portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      ScreenDay(),
      ScreenManage(),
      ScreenSymptoms(),
      ScreenPharmacist(),
      ScreenSettings(),
    ];
    List<String> _titles = [
      'Diário',
      'Gerenciar',
      'Sintomas',
      'Farmacêuticos',
      'Configuração',
    ];
    List<IconData> _icons = [
      Icons.home,
      Icons.history,
      Icons.healing,
      Icons.people,
      Icons.settings,
    ];
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedDate()),
        ChangeNotifierProvider(create: (context) => BackendApi()),
        ChangeNotifierProxyProvider<BackendApi, Profiles>(
          create: (context) => Profiles(
            backendApi: null,
            initProfiles: null,
            initialProfileId: null,
          ),
          update: (context, backend, previousProfiles) => Profiles(
            backendApi: backend,
            initProfiles: previousProfiles.profiles,
            initialProfileId: previousProfiles.selectedProfileId,
          ),
        ),
        ChangeNotifierProxyProvider<BackendApi, UsersWithAccess>(
          create: (context) => UsersWithAccess(api: null),
          update: (context, api, previousProvider) => UsersWithAccess(api: api),
        ),
        ChangeNotifierProxyProvider<BackendApi, Inventories>(
          create: (context) => Inventories(
            api: null,
            initialValues: null,
          ),
          update: (context, backend, previousInventoryProvider) => Inventories(
            api: backend,
            initialValues: previousInventoryProvider.inventories,
          ),
        ),
        ChangeNotifierProxyProvider3<BackendApi, Inventories, Profiles,
            ScheduledMedications>(
          create: (context) => ScheduledMedications(
            api: null,
            inventoryProvider: null,
          ),
          update: (context, backend, inventoryProvider, profilesProvider,
                  previousProviderInstance) =>
              ScheduledMedications(
            profilesProvider: profilesProvider,
            api: backend,
            inventoryProvider: inventoryProvider,
          ),
        ),
        ChangeNotifierProxyProvider2<ScheduledMedications, Profiles,
            NotificationService>(
          create: (context) => NotificationService(null, null),
          update: (context, scheduledMedications, profiles, _) =>
              NotificationService(scheduledMedications, profiles),
        ),
      ],
      child: AdaptiveApp(
        routes: {
          ScreenAddMedication.routeName: (context) => ScreenAddMedication(),
          ScreenAddSubProfile.routeName: (context) => ScreenAddSubProfile(),
        },
        homePage: Consumer<BackendApi>(
          builder: (context, authProvider, child) {
            final mainApp = AdaptiveScaffoldNav(
              screens: _screens,
              titles: _titles,
              icons: _icons,
            );
            if (authProvider.isAuthenticated) {
              Provider.of<NotificationService>(context);
              return mainApp;
            } else {
              return FutureBuilder(
                future: authProvider.tryAutoLogin(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SplashScreen();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return ScreenLogin();
                    } else if (snapshot.hasData) {
                      return snapshot.data ? mainApp : ScreenLogin();
                    }
                  }
                  return ScreenLogin();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
