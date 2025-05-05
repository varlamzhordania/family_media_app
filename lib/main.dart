import 'dart:io';
import 'package:familyarbore/provider/auth_provider.dart';
import 'package:familyarbore/screens/auth/forgot_password/forgot_password.dart';
import 'package:familyarbore/screens/auth/login/login_screen.dart';
import 'package:familyarbore/screens/auth/register/register_screen.dart';
import 'package:familyarbore/screens/familyList/family_list_screen.dart';
import 'package:familyarbore/screens/get_start/get_start_screen.dart';
import 'package:familyarbore/screens/home_wrap/home_wrap_screen.dart';
import 'package:familyarbore/screens/profile/edit/edit_profile_screen.dart';
import 'package:familyarbore/screens/profile/profile_screen.dart';
import 'package:familyarbore/screens/splash/splash_screen.dart';
import 'package:familyarbore/service/sharedPreferences_service.dart';
import 'package:familyarbore/test_screen.dart';
import 'package:familyarbore/utils/Constant.dart';
import 'package:familyarbore/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final getIt = GetIt.instance;


void setupDi() {
  getIt.registerSingletonAsync(() async => SharedPreferencesService());
  getIt.registerLazySingleton(() => AuthProvider());

}

Future<void> setupDiAsync() async{
  await getIt.isReady<SharedPreferencesService>();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupDi();
  await setupDiAsync();

  runApp(
     const MyApp(),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

      ],
      child: MaterialApp.router(
        title: "Family Arbore",
        locale: const Locale("en", "EN"),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        routerConfig: AppRouter.router,

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: GoogleFonts.rubik().fontFamily,
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            secondaryHeaderColor: Colors.white

        ),
      ),
    );
  }
}





