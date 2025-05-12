import 'package:familyarbore/screens/auth/login/login_screen.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../../generated/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../provider/auth_provider.dart';


class GetStartScreen extends StatefulWidget {
  static String routeName = "/GetStartScreen";
  const GetStartScreen({super.key});

  @override
  GetStartScreenState createState() => GetStartScreenState();
}

class GetStartScreenState extends State<GetStartScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  final appProvider = GetIt.instance<AuthProvider>();



  @override
  void initState() {
    super.initState();
  }


  void _onIntroEnd(BuildContext context){
    appProvider.markGetStartSeen();
    context.go(LoginScreen.routeName);
  }





  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    final pageDecoration = PageDecoration(
      titleTextStyle: GoogleFonts.rubik(textStyle: const TextStyle(fontWeight: FontWeight.w700, color: textColor, fontSize: 20)),
      bodyTextStyle: GoogleFonts.rubik(textStyle: const TextStyle(fontWeight: FontWeight.w400, color: textColorBody, fontSize: 15)),
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: backgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: backgroundColor,
      allowImplicitScrolling: false,
      // autoScrollDuration: 3000,
      infiniteAutoScroll: false,
      pages: [
        PageViewModel(
          title: AppLocalizations.of(context)!.greeting,
          body: AppLocalizations.of(context)!.dec,
          image: SizedBox(
              height: height * 0.31,
              child: Lottie.asset(Assets.lottiesAnimBoardStart)
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
          "Download the Stockpile app and master the market with our mini-lesson.",
          image: SizedBox(
              height: height * 0.31,
              child: Lottie.asset(Assets.lottiesChatAnim)
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis ",
          image: SizedBox(
              height: height * 0.31,
              child: Lottie.asset(Assets.lottiesMediaAnim)
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => {
        _onIntroEnd(context)
      },
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip:  Text('Skip', style: GoogleFonts.rubik(textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black))),
      next: const Icon(Icons.arrow_forward),
      done:  Text('Done', style: GoogleFonts.rubik(textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black))),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator:  const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.black45,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
