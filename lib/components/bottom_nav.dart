import 'package:familyarbore/screens/home_post/home_screen.dart';
import 'package:familyarbore/screens/message/message_screen.dart';
import 'package:familyarbore/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../generated/assets.dart';
import '../utils/theme_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
  @override
  _MybottomnavState createState() => _MybottomnavState();
}

class _MybottomnavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      backgroundColor: Colors.white,
      tabs: _tabs(context),
      controller: controller,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        curve: Curves.ease,
        duration: Duration(milliseconds: 400),
      ),

      navBarBuilder: (navBarConfig) => Style2BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration:NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white
        ),
      ),
      // navBarOverlap: NavBarOverlap.full(),
      navBarHeight: 55,
    );

  }


}


List<PersistentTabConfig> _tabs(BuildContext context) => [
  PersistentTabConfig(
    screen: const HomeScreen(),
    item: ItemConfig(
      icon: SvgPicture.asset(
        width: 23,
        height: 23,
        Assets.iconsHome,
        color: greyColor,
        semanticsLabel: 'Home',
      ),
      title: AppLocalizations.of(context)!.home,
      activeColorSecondary: greyColorLight,
      inactiveForegroundColor: blueColor,

    ),
  ),
  PersistentTabConfig(
    screen: const MessageScreen(),
    item: ItemConfig(
      icon: SvgPicture.asset(
        width: 23,
        height: 23,
        Assets.iconsMessages,
        semanticsLabel: 'Messages',
        color: greyColor,
      ),
      title: AppLocalizations.of(context)!.messages,
      activeColorSecondary: greyColorLight,
      inactiveForegroundColor: blueColor,
    ),
  ),
  PersistentTabConfig(
    screen: const ProfileScreen(),
    item: ItemConfig(
      icon: SvgPicture.asset(
        width: 23,
        height: 23,
        Assets.iconsProfile,
        semanticsLabel: 'User',
        color: greyColor,
      ),
      title: AppLocalizations.of(context)!.profile,
      activeColorSecondary: greyColorLight,
      inactiveForegroundColor: blueColor,
    ),
  ),
];

