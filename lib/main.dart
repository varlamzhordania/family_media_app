import 'package:familyarbore/provider/auth_provider.dart';
import 'package:familyarbore/provider/post_provider.dart';
import 'package:familyarbore/screens/add_post/add_post_screen.dart';
import 'package:familyarbore/screens/splash/splash_screen.dart';
import 'package:familyarbore/service/sharedPreferences_service.dart';
import 'package:familyarbore/test_screen.dart';
import 'package:familyarbore/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

         ],
         child: const MyApp()),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final appRouterTest = GoRouter(
        debugLogDiagnostics: true,
        initialLocation: AddPostScreen.routeName, routes: [
      GoRoute(
        path: AddPostScreen.routeName,
        name: AddPostScreen.routeName,
        builder: (context, state) {
          return const AddPostScreen();
        },
      ),
    ]);


    return MaterialApp.router(
      title: "Family Arbore",
      locale: const Locale("en", "EN"),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // routerConfig: appRouter(context),

      routerConfig: appRouterTest,

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


      ),
    );
  }
}





