import 'package:familyarbore/main.dart';
import 'package:familyarbore/provider/auth_provider.dart';
import 'package:familyarbore/screens/auth/forgot_password/forgot_password.dart';
import 'package:familyarbore/screens/auth/register/register_screen.dart';
import 'package:familyarbore/utils/Constant.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../home_wrap/home_wrap_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _focusEmail = false;
  bool _focusPassword = false;

  late   AuthProvider authProvider;

  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;

  bool showPassword = false;
  bool showPasswordConfirm = false;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();

    super.dispose();
  }



  void loginReq() async {

    if(emailEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty){


      if(emailEditingController.text.toString().contains("@")){
        try{

          await authProvider.loginUserReq({
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET,
            "grant_type": "password",
            "password": passwordEditingController.text.toString(),
            "username": emailEditingController.text.toString()
          }).then((onValue){
            debugPrint("heloo: ${authProvider.isAuthenticated}");
              if(context.mounted){
                context.go(HomeWrapScreen.routeName);
              }

          });

          // if(authProvider.isAuthenticated){
          //   context.go("${LoginScreen.routeName}${HomeWrapScreen.routeName}");
          // }

        }finally{
          // passwordEditingController.clear();
          // emailEditingController.clear();


        }
      }else{
        Fluttertoast.showToast(msg: "Email is not valid");

      }

    }else{
      Fluttertoast.showToast(msg: "Please enter all fields");

    }





  }











  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;







    return  SafeArea(
      child: Scaffold(
          backgroundColor: lightBluColor2,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: _width,
                      height: _height ,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, _height * 0.18, 0, 0),
                        child: CustomPaint(
                            painter: const MyCustomPainter([2, 3, 2]),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  GestureDetector(
                                    onTap: () =>{
                                      setState(() {
                                        _focusPassword = false;
                                        _focusEmail = false;

                                      })
                                    },
                                    child: SizedBox(
                                      width: _width,
                                      height: _height * 0.55,
                                      child: Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              const title(),

                                              const SizedBox(
                                                height: 5,
                                              ),

                                              const title_dec(),

                                              const SizedBox(
                                                height: 20,
                                              ),



                                              email_field(_height, context),

                                              
                                              const SizedBox(
                                                height: 10,
                                              ),


                                              password_field(_height, context),

                                              const SizedBox(
                                                height: 20,
                                              ),


                                              const forgotPass(),


                                              const SizedBox(
                                                height: 20,
                                              ),

                                              Center(
                                                child: InkWell(
                                                  onTap: () =>{
                                                    loginReq()
                                                  },
                                                  child: Container(
                                                      width: _width * 0.6,
                                                      height: _height * 0.067,
                                                      decoration: BoxDecoration(
                                                          gradient: cardColorBlue,
                                                          borderRadius: BorderRadius.circular(15)
                                                      ),
                                                      child: Consumer<AuthProvider>(builder: (context, data, child) {
                                                        debugPrint("loading: ${data
                                                            .is_loading}");
                                                        return data.is_loading ?
                                                            Center(child: LoadingAnimationWidget.progressiveDots(
                                                              color: Colors.white,
                                                              size: 25
                                                            ))
                                                            : Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [

                                                            Text(
                                                                AppLocalizations.of(context)!.signIn, // Text displayed on the button
                                                                style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white)),
                                                            SizedBox(
                                                              width: _width * 0.02,
                                                            ),


                                                            SvgPicture.asset(
                                                              width: 15,
                                                              height: 15,
                                                              fit: BoxFit.scaleDown,
                                                              Assets.iconsArrowRight,
                                                              semanticsLabel: 'login icon',
                                                              color: Colors.white,

                                                            ),

                                                          ],
                                                        );

                                                      })
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),


                                              btn_register(width: _width, height: _height),





                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            )),
                      ),
                    ),




                  ],
                ),

                Positioned(
                    top: 100,
                    left: 150,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(100)
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }

  SizedBox password_field(double _height, BuildContext context) {
    return SizedBox(
                                              height: _height * 0.06,
                                              child: Focus(
                                                onFocusChange: (value) {
                                                  setState(() {
                                                    _focusPassword = value;
                                                  });
                                                },
                                                child: TextField(
                                                  keyboardType: TextInputType.text,
                                                  controller: passwordEditingController,
                                                  obscureText: showPassword ? false : true,
                                                  style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
                                                  decoration: InputDecoration(

                                                      prefixIcon:
                                                      SvgPicture.asset(
                                                        width: 5,
                                                        height: 5,
                                                        fit: BoxFit.scaleDown,
                                                        Assets.iconsLock,
                                                        semanticsLabel: 'password icon',
                                                        color: _focusPassword ? borderColor : hintColor,

                                                      ),

                                                      suffixIcon: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            showPassword = !showPassword;
                                                          });
                                                        },
                                                        child: showPassword ? SvgPicture.asset(
                                                          width: 5,
                                                          height: 5,
                                                          fit: BoxFit.scaleDown,
                                                          Assets.iconsEye,
                                                          semanticsLabel: 'password icon',
                                                          color: _focusPassword ? hintColor : hintColor,

                                                        ) :
                                                        SvgPicture.asset(
                                                          width: 5,
                                                          height: 5,
                                                          fit: BoxFit.scaleDown,
                                                          Assets.iconsEyeSlash,
                                                          semanticsLabel: 'password icon',
                                                          color: _focusPassword ? hintColor : hintColor,

                                                        ),
                                                      ),
                                                      enabledBorder: const OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        borderSide: BorderSide(color: hintColor),
                                                      ),
                                                      focusedBorder: const OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        borderSide: BorderSide(color: borderColor),
                                                      ),
                                                      hintText: AppLocalizations.of(context)!.password,
                                                      hintStyle: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: hintColor),
                                                      contentPadding: const EdgeInsets.symmetric(
                                                          vertical: 12.0, horizontal: 16.0),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            );
  }

  SizedBox email_field(double _height, BuildContext context) {
    return SizedBox(
                                              height: _height * 0.06,
                                              child: Focus(
                                                onFocusChange: (value) {
                                                  setState(() {
                                                    _focusEmail = value;
                                                  });
                                                },
                                                child: TextField(
                                                  keyboardType: TextInputType.emailAddress,
                                                  controller: emailEditingController,
                                                  style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
                                                  decoration: InputDecoration(

                                                      prefixIcon:
                                                      SvgPicture.asset(
                                                        width: 5,
                                                        height: 5,
                                                        fit: BoxFit.scaleDown,
                                                        Assets.iconsSmsTracking,
                                                        semanticsLabel: 'email icon',
                                                        color: _focusEmail ? borderColor : hintColor,

                                                      ),
                                                      enabledBorder: const OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        borderSide: BorderSide(color: hintColor),
                                                      ),
                                                      focusedBorder: const OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        borderSide: BorderSide(color: borderColor),
                                                      ),
                                                      hintText: AppLocalizations.of(context)!.email,
                                                      hintStyle: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: hintColor),
                                                      contentPadding: const EdgeInsets.symmetric(
                                                          vertical: 12.0, horizontal: 16.0),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            );
  }



}



class btn_register extends StatelessWidget {
  const btn_register({
    super.key,
    required double width,
    required double height,
  }) : _width = width, _height = height;

  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () =>         context.push("${LoginScreen.routeName}${RegisterScreen.routeName}"),
        child: Container(
            width: _width * 0.6,
            height: _height * 0.067,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: borderColor,
                  width: 2,
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
    
                Text(
                    AppLocalizations.of(context)!.signUpTitle, // Text displayed on the button
                    style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: btnColor)),
    
                SizedBox(
                  width: _width * 0.02,
                ),
              ],
            )
        ),
      ),
    );
  }
}



class forgotPass extends StatelessWidget {
  const forgotPass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>
      {
        debugPrint("${LoginScreen.routeName}${ForgotPassword.routeName}"),
        context.push("${LoginScreen.routeName}${ForgotPassword.routeName}")},
      child: Text(
        AppLocalizations.of(context)!.forgetYourPassword,
        style: GoogleFonts.rubik().copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: textColorBody, decoration: TextDecoration.underline),
      ),
    );
  }
}

class title_dec extends StatelessWidget {
  const title_dec({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.signInDec,
      style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
    );
  }
}

class title extends StatelessWidget {
  const title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.signIn,
      style: GoogleFonts.rubik().copyWith(fontSize: 17, fontWeight: FontWeight.w600, color: textColor),
    );
  }
}


class MyCustomPainter extends CustomPainter {
  final List<int> ppp;

  const MyCustomPainter(this.ppp);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / ppp[0], size.height / ppp[1], size.width,
          ppp[2].toDouble())
      ..lineTo(size.width, size.height)..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}