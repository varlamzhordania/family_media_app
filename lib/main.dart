import 'package:familyarbore/provider/auth_provider.dart';
import 'package:familyarbore/provider/event_provider.dart';
import 'package:familyarbore/provider/post_provider.dart';
import 'package:familyarbore/provider/friend_provider.dart';
import 'package:familyarbore/provider/profile_provider.dart';
import 'package:familyarbore/screens/requests/requests_screen.dart';
import 'package:familyarbore/service/sharedPreferences_service.dart';
import 'package:familyarbore/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'animationRouter/src/go_transition.dart';
import 'animationRouter/src/go_transitions.dart';

final getIt = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();

void setupDi() {
  getIt.registerSingletonAsync(() async => SharedPreferencesService());
  getIt.registerLazySingleton(() => AuthProvider());
  getIt.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);

}

Future<void> setupDiAsync() async{
  await getIt.isReady<SharedPreferencesService>();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupDi();
  await setupDiAsync();




  runApp(
     MultiProvider(
         providers: [
           ChangeNotifierProvider(create: (_) => AuthProvider()),
           ChangeNotifierProvider(create: (_) => PostProvider()),
           ChangeNotifierProvider(create: (_) => FriendProvider()),
           ChangeNotifierProvider(create: (_) => ProfileProvider()),
           ChangeNotifierProvider(create: (_) => EventProvider())

         ],
         child: const MyApp()),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {


    GoTransition.defaultCurve = Curves.easeInOut;
    GoTransition.defaultDuration = const Duration(milliseconds: 600);

    final appRouterTest = GoRouter(
        debugLogDiagnostics: true,
        initialLocation: RequestsScreen.routeName, routes: [
      GoRoute(
        path: RequestsScreen.routeName,
        name: RequestsScreen.routeName,
        builder: (context, state) {
          return RequestsScreen();
        },
      ),
    ]);


    return MaterialApp.router(
      title: "Family Arbore",
      locale: const Locale("en", "EN"),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      routerConfig: appRouter(context),

      // routerConfig: appRouterTest,

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.rubik().fontFamily,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          secondaryHeaderColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.light,
          ),

        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: GoTransitions.cupertino,
            TargetPlatform.iOS: GoTransitions.cupertino,
            TargetPlatform.macOS: GoTransitions.cupertino,
          },
        ),


      ),
    );
  }
}





