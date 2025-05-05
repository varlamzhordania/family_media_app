import 'dart:io';
import 'package:familyarbore/provider/auth_provider.dart';
import 'package:familyarbore/screens/get_start/get_start_screen.dart';
import 'package:familyarbore/screens/home_wrap/home_wrap_screen.dart';
import 'package:familyarbore/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/forgot_password/forgot_password.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/familyList/family_list_screen.dart';
import '../screens/profile/edit/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRouter {

  static final GoRouter router = GoRouter(
    refreshListenable: GetIt.instance<AuthProvider>(),
    initialLocation: SplashScreen.routeName,
    routes: <RouteBase>[
      GoRoute(
        path: SplashScreen.routeName,
        name: SplashScreen.routeName,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),

      GoRoute(
        path: GetStartScreen.routeName,
        name: GetStartScreen.routeName,
        builder: (context, state) {
          return const GetStartScreen();
        },
      ),

      GoRoute(
        path: HomeWrapScreen.routeName,
        name: HomeWrapScreen.routeName,
        builder: (context, state) {
          return const HomeWrapScreen();
        },
      ),


      GoRoute(
        path: ProfileScreen.routeName,
        name: ProfileScreen.routeName,
        builder: (context, state) {
          return const ProfileScreen();
        },
      ),

      GoRoute(
        path: EditProfileScreen.routeName,
        name: EditProfileScreen.routeName,
        builder: (context, state) {
          return const EditProfileScreen();
        },
      ),

      GoRoute(
        path: FamilyListScreen.routeName,
        name: FamilyListScreen.routeName,
        builder: (context, state) {
          return const FamilyListScreen();
        },
      ),

      GoRoute(
        path: LoginScreen.routeName,
        name: LoginScreen.routeName,
        builder: (context, state) {
          return const LoginScreen();
        },
        routes: [
          GoRoute(
            path: ForgotPassword.routeName,
            name: ForgotPassword.routeName,
            builder: (context, state) {
              return const ForgotPassword();
            },
          ),

          GoRoute(
            path: RegisterScreen.routeName,
            name: RegisterScreen.routeName,
            builder: (context, state) {
              return const RegisterScreen();
            },
          ),


        ]
      ),


    ],

    errorBuilder: (context, state) => ErrorRoute(error: state.error.toString()),
    redirect: (BuildContext context, GoRouterState state) {

      final appProvider = GetIt.instance<AuthProvider>();


      if(appProvider.isChecking){
        return null;
      }



      final isAuthenticated = appProvider.isAuthenticated;
      final hasSeenGetStarted = appProvider.hasSeenGetStarted;



      final isGoingToLogin = state.matchedLocation == LoginScreen.routeName;
      final isGoingToHome = state.matchedLocation == HomeWrapScreen.routeName;
      final isGoingToGetStart = state.matchedLocation == GetStartScreen.routeName;

      final isGoingToForgotPassword = state.matchedLocation == "${LoginScreen.routeName}${ForgotPassword.routeName}";
      final isGoingToRegister = state.matchedLocation == "${LoginScreen.routeName}${RegisterScreen.routeName}";

      if(isGoingToForgotPassword){
        debugPrint(ForgotPassword.routeName);

        return null;
      }

      if(isGoingToRegister){
        debugPrint(RegisterScreen.routeName);
        return null;
      }


      if(isAuthenticated && !isGoingToHome){
        debugPrint(HomeWrapScreen.routeName);

        return HomeWrapScreen.routeName;
      }




      if(!hasSeenGetStarted && !isGoingToGetStart){
        debugPrint(GetStartScreen.routeName);

        return GetStartScreen.routeName;
      }


      if(!isAuthenticated && !isGoingToLogin && hasSeenGetStarted){
        debugPrint(LoginScreen.routeName);
        return LoginScreen.routeName;
      }



      return null;



    },
  );
}














class ErrorRoute extends StatelessWidget {
  final String error;
  const ErrorRoute({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error - $error"),
        leading: IconButton(
          icon: IconButton(
            icon: Platform.isIOS
                ? const Icon(Icons.arrow_back_ios)
                : const Icon(Icons.arrow_back_outlined),
            onPressed: () => Navigator.pop(context),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text(
          "Page Not Found....",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

