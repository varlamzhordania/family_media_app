
import 'package:familyarbore/generated/assets.dart';
import 'package:familyarbore/screens/auth/login/login_screen.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  bool _focusFirstName = false;

  bool _focusLastName = false;
  bool _focusEmail = false;
  bool _focusPassword = false;
  bool _focusConfirmPassword = false;

  late TextEditingController firstNameEditingController;
  late TextEditingController lastNameEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  late TextEditingController confirmPasswordEditingController;

  bool showPassword = false;
  bool showPasswordConfirm = false;

  @override
  void initState() {
    firstNameEditingController = TextEditingController();
    lastNameEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    confirmPasswordEditingController = TextEditingController();
    super.initState();
  }



  @override
  void dispose() {
    firstNameEditingController.dispose();
    lastNameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    confirmPasswordEditingController.dispose();

    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;







    return  SafeArea(
      child: Scaffold(
        backgroundColor: lightBluColor2,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),

          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => {Navigator.pop(context)},
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: SvgPicture.asset(
                                width: 25,
                                height: 25,
                                fit: BoxFit.fill,
                                color: Colors.black54,
                                Assets.iconsArrowChevronLeft,
                                semanticsLabel: 'back to Login',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: _width * 0.3
                        ),
                        Text(
                            AppLocalizations.of(context)!
                                .signUpTitle, // Text displayed on the button
                            style: GoogleFonts.rubik().copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54))
                      ],
                    ),
                  ),

                  SizedBox(
                    width: _width,
                    height: _height ,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, _height * 0.1, 0, 0),
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
                                      _focusConfirmPassword = false;
                                      _focusPassword = false;
                                      _focusLastName = false;
                                      _focusEmail = false;

                                    })
                                  },
                                  child: SizedBox(
                                    width: _width,
                                    height: _height * 0.6,
                                    child: Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              AppLocalizations.of(context)!.signUpTitle,
                                              style: GoogleFonts.rubik().copyWith(fontSize: 17, fontWeight: FontWeight.w600, color: textColor),
                                            ),

                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                                AppLocalizations.of(context)!.signUp,
                                              style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),


                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: _height * 0.06,
                                                  width: _width * 0.4,
                                                  child: Focus(
                                                    onFocusChange: (value) {
                                                      setState(() {
                                                        _focusFirstName = value;
                                                      });
                                                    },
                                                    child: TextField(
                                                      keyboardType: TextInputType.text,
                                                      controller: firstNameEditingController,
                                                      style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
                                                      decoration: InputDecoration(

                                                          prefixIcon:
                                                          SvgPicture.asset(
                                                            width: 5,
                                                            height: 5,
                                                            fit: BoxFit.scaleDown,
                                                            Assets.iconsUser,
                                                            semanticsLabel: 'Dart Logo',
                                                            color: _focusFirstName ? borderColor : hintColor,

                                                          ),
                                                          enabledBorder: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                            borderSide: BorderSide(color: hintColor),
                                                          ),
                                                          focusedBorder: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                            borderSide: BorderSide(color: borderColor),
                                                          ),
                                                          disabledBorder: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                            borderSide: BorderSide(color: hintColor),
                                                          ),

                                                          hintText: AppLocalizations.of(context)!.firstName,
                                                          hintStyle: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: hintColor),
                                                          contentPadding: const EdgeInsets.symmetric(
                                                              vertical: 12.0, horizontal: 16.0),
                                                          border: InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: _height * 0.06,
                                                  width: _width * 0.4,
                                                  child: Focus(
                                                    onFocusChange: (value) {
                                                      setState(() {
                                                        _focusLastName = value;
                                                      });
                                                    },
                                                    child: TextField(
                                                      keyboardType: TextInputType.text,
                                                      controller: lastNameEditingController,
                                                      style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
                                                      decoration: InputDecoration(

                                                          prefixIcon:
                                                          SvgPicture.asset(
                                                            width: 5,
                                                            height: 5,
                                                            fit: BoxFit.scaleDown,
                                                            Assets.iconsUser,
                                                            semanticsLabel: 'lastName icon',
                                                            color: _focusLastName ? borderColor : hintColor,

                                                          ),
                                                          enabledBorder: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                            borderSide: BorderSide(color: hintColor),
                                                          ),
                                                          focusedBorder: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                            borderSide: BorderSide(color: borderColor),
                                                          ),
                                                          hintText: AppLocalizations.of(context)!.lastName,
                                                          hintStyle: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: hintColor),
                                                          contentPadding: const EdgeInsets.symmetric(
                                                              vertical: 12.0, horizontal: 16.0),
                                                          border: InputBorder.none),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),

                                            const SizedBox(
                                              height: 10,
                                            ),


                                            SizedBox(
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
                                            ),



                                            const SizedBox(
                                              height: 10,
                                            ),


                                            SizedBox(
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
                                            ),


                                            const SizedBox(
                                              height: 10,
                                            ),


                                            SizedBox(
                                              height: _height * 0.06,
                                              child: Focus(
                                                onFocusChange: (value) {
                                                  setState(() {
                                                    _focusConfirmPassword = value;
                                                  });
                                                },
                                                child: TextField(
                                                  keyboardType: TextInputType.text,
                                                  controller: confirmPasswordEditingController,
                                                  obscureText: showPasswordConfirm ? false : true,
                                                  style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
                                                  decoration: InputDecoration(

                                                      prefixIcon:
                                                      SvgPicture.asset(
                                                        width: 5,
                                                        height: 5,
                                                        fit: BoxFit.scaleDown,
                                                        Assets.iconsLock,
                                                        semanticsLabel: 'password icon',
                                                        color: _focusConfirmPassword ? borderColor : hintColor,

                                                      ),

                                                      suffixIcon: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            showPasswordConfirm = !showPasswordConfirm;
                                                          });
                                                        },
                                                        child: showPasswordConfirm ? SvgPicture.asset(
                                                          width: 5,
                                                          height: 5,
                                                          fit: BoxFit.scaleDown,
                                                          Assets.iconsEye,
                                                          semanticsLabel: 'password icon',
                                                          color: _focusConfirmPassword ? hintColor : hintColor,

                                                        ) :
                                                        SvgPicture.asset(
                                                          width: 5,
                                                          height: 5,
                                                          fit: BoxFit.scaleDown,
                                                          Assets.iconsEyeSlash,
                                                          semanticsLabel: 'password icon',
                                                          color: _focusConfirmPassword ? hintColor : hintColor,

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
                                                      hintText: AppLocalizations.of(context)!.confirmPassword,
                                                      hintStyle: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: hintColor),
                                                      contentPadding: const EdgeInsets.symmetric(
                                                          vertical: 12.0, horizontal: 16.0),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),

                                            Center(
                                              child: Container(
                                                width: _width * 0.6,
                                                height: _height * 0.067,
                                                decoration: BoxDecoration(
                                                  gradient: cardColorBlue,
                                                  borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [

                                                      Text(
                                                          AppLocalizations.of(context)!.signUpTitle, // Text displayed on the button
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
                                                  )
                                                  ),
                                                ),

                                            SizedBox(
                                              height: 10,
                                            ),


                                            // Center(
                                            //   child: Text(
                                            //     "Or",
                                            //     style: GoogleFonts.rubik().copyWith(fontSize: 17, fontWeight: FontWeight.w600, color: hintColor),
                                            //   ),
                                            // ),

                                            // SizedBox(
                                            //   height: 2,
                                            // ),



                                            Center(
                                              child: GestureDetector(
                                                  onTap: ()=> context.push(LoginScreen.routeName),

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
                                                            AppLocalizations.of(context)!.signIn, // Text displayed on the button
                                                            style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: btnColor)),
                                                        SizedBox(
                                                          width: _width * 0.02,
                                                        ),


                                                        // SvgPicture.asset(
                                                        //   width: 15,
                                                        //   height: 15,
                                                        //   fit: BoxFit.scaleDown,
                                                        //   Assets.iconsArrowRight,
                                                        //   semanticsLabel: 'login icon',
                                                        //   color: btnColor,
                                                        //
                                                        // ),

                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),









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