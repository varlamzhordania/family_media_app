
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../generated/assets.dart';
import '../../provider/auth_provider.dart';
import '../../utils/theme_colors.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  late AuthProvider appProvider;

  void onStartUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Future.delayed(const Duration(seconds: 2));
    await appProvider.getUserDetail();
    await appProvider.onAppStart();
  }

  @override
  void initState() {
    appProvider = Provider.of<AuthProvider>(context, listen: false);
    onStartUp();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;




    return SafeArea(child: Scaffold(
      body: Container(

        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: cardColorBlue
        ),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(
              height: height * 0.2,
            ),

           Column(
             children: [
               Image.asset(Assets.imagesParents, width: 100, height: 150, color: Colors.white.withOpacity(0.3),),
               SizedBox(
                 height: height * 0.05,
               ),

               Text(
                   AppLocalizations.of(context)!.title, // Text displayed on the button
                   style: GoogleFonts.rubik().copyWith(fontSize: 15,
                       fontWeight: FontWeight.w600,
                       color: Colors.white)),
             ],
           ),


            LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 30),


            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                  "V 2.01.0", // Text displayed on the button
                  style: GoogleFonts.rubik().copyWith(fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            ),

          ],
        )
      ),
    ));
  }
}
