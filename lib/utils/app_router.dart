import 'dart:io';

import 'package:familyarbore/provider/auth_provider.dart';
import 'package:familyarbore/screens/auth/register/register_password_screen.dart';
import 'package:familyarbore/screens/createPost/create_post_screen.dart';
import 'package:familyarbore/screens/get_start/get_start_screen.dart';
import 'package:familyarbore/screens/home_wrap/home_wrap_screen.dart';
import 'package:familyarbore/screens/requests/requests_screen.dart';
import 'package:familyarbore/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../screens/auth/forgot_password/forgot_password.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/familyList/family_list_screen.dart';
import '../screens/profile/edit/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';

GoRouter appRouter(BuildContext context) => GoRouter(
      refreshListenable: Provider.of<AuthProvider>(context, listen: false),
      debugLogDiagnostics: true,
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
          path: CreatePostScreen.routeName,
          name: CreatePostScreen.routeName,
          builder: (context, state) {
            return const CreatePostScreen();
          },
        ),

        GoRoute(
          path: RequestsScreen.routeName,
          name: RequestsScreen.routeName,
          builder: (context, state) {
            return const RequestsScreen();
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
              GoRoute(
                path: RegisterPasswordScreen.routeName,
                name: RegisterPasswordScreen.routeName,
                builder: (context, state) {
                  return RegisterPasswordScreen(
                      requestBody: state.extra as Map<String, dynamic>);
                },
              ),
            ]),
        GoRoute(
          path: HomeWrapScreen.routeName,
          name: HomeWrapScreen.routeName,
          builder: (context, state) {
            return const HomeWrapScreen();
          },
        ),
      ],
      errorBuilder: (context, state) =>
          ErrorRoute(error: state.error.toString()),
      redirect: (BuildContext context, GoRouterState state) {
        final appProvider = Provider.of<AuthProvider>(context, listen: false);

        debugPrint(
            'Redirect check - isAuthenticated: ${appProvider.isAuthenticated}, location: ${state.matchedLocation}');

        if (appProvider.isChecking) {
          return null;
        }

        final isAuthenticated = appProvider.isAuthenticated;
        final hasSeenGetStarted = appProvider.hasSeenGetStarted;

// Simplify your redirect logic
        if (isAuthenticated) {
          if (state.matchedLocation == (HomeWrapScreen.routeName) ||
              state.matchedLocation == ProfileScreen.routeName ||
              state.matchedLocation == CreatePostScreen.routeName ||
              state.matchedLocation == EditProfileScreen.routeName ||
              state.matchedLocation == RequestsScreen.routeName ||
          state.matchedLocation == FamilyListScreen.routeName) {
            return null; // Allow access to these routes when authenticated
          }

// For any other route, redirect to home when authenticated
          return HomeWrapScreen.routeName;
        }

// Handle unauthenticated state
        if (!hasSeenGetStarted) {
          return GetStartScreen.routeName;
        }

// Allow access to login and its sub-routes
        if (state.matchedLocation.startsWith(LoginScreen.routeName)) {
          return null;
        }

// Default redirect to login for unauthenticated users
        return LoginScreen.routeName;
      },
    );











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
