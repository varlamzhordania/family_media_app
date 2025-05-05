import 'package:familyarbore/screens/auth/login/login_screen.dart';
import 'package:familyarbore/screens/auth/register/register_screen.dart';
import 'package:familyarbore/screens/get_start/get_start_screen.dart';
import 'package:familyarbore/screens/home/home_screen.dart';
import 'package:familyarbore/screens/message/message_screen.dart';
import 'package:familyarbore/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../generated/assets.dart';
import '../utils/theme_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Bottom_nav extends StatefulWidget {
  Bottom_nav({Key? key}) : super(key: key);
  @override
  _MybottomnavState createState() => _MybottomnavState();
}

class _MybottomnavState extends State<Bottom_nav> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      backgroundColor: Colors.white,
      tabs: _tabs(context),
      controller: _controller,
      screenTransitionAnimation: ScreenTransitionAnimation(
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
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
        width: 20,
        height: 20,
        Assets.iconsHome,
        semanticsLabel: 'Home',
      ),
      title: AppLocalizations.of(context)!.home,
      activeColorSecondary: yellowColor,
      inactiveForegroundColor: blueColor,
    ),
  ),
  PersistentTabConfig(
    screen: const MessageScreen(),
    item: ItemConfig(
      icon: SvgPicture.asset(
        width: 20,
        height: 20,
        Assets.iconsMessages,
        semanticsLabel: 'Messages',
      ),
      title: AppLocalizations.of(context)!.messages,
      activeColorSecondary: yellowColor,
      inactiveForegroundColor: blueColor,
    ),
  ),
  PersistentTabConfig(
    screen: ProfileScreen(),
    item: ItemConfig(
      icon: SvgPicture.asset(
        width: 20,
        height: 20,
        Assets.iconsUser,
        semanticsLabel: 'User',
      ),
      title: AppLocalizations.of(context)!.profile,
      activeColorSecondary: yellowColor,
      inactiveForegroundColor: blueColor,
    ),
  ),
];

