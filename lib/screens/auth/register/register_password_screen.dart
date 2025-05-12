
import 'package:familyarbore/generated/assets.dart';
import 'package:familyarbore/provider/auth_provider.dart';
import 'package:familyarbore/screens/auth/login/login_screen.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class RegisterPasswordScreen extends StatefulWidget {
  static String routeName = "/RegisterPasswordScreen";
  final Map<String, dynamic> requestBody;

  const RegisterPasswordScreen({super.key, required this.requestBody});

  @override
  State<RegisterPasswordScreen> createState() => _RegisterPasswordState();
}

class _RegisterPasswordState extends State<RegisterPasswordScreen> {

  late AuthProvider authProvider;

  bool containCapital = false;
  bool containNumber = false;
  bool containCharacter = false;





  bool _focusPassword = false;
  bool _focusConfirmPassword = false;

  late TextEditingController passwordEditingController;
  late TextEditingController confirmPasswordEditingController;

  bool showPassword = false;
  bool showPasswordConfirm = false;

  @override
  void initState() {

    debugPrint(widget.requestBody["email"]);

    authProvider = Provider.of<AuthProvider>(context, listen: false);


    passwordEditingController = TextEditingController();
    confirmPasswordEditingController = TextEditingController();


    super.initState();
  }



  @override
  void dispose() {

    passwordEditingController.dispose();
    confirmPasswordEditingController.dispose();

    super.dispose();
  }




  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            content: SizedBox(
              width: 200,
              height: 190,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(56),
                          color: authProvider.is_success ? successColor.withOpacity(0.6)  : errorColor.withOpacity(0.6)
                      ),
                      child:  Center(
                          child: authProvider.is_success ?
                          const Icon(
                            Icons.check_circle, size: 30, color: successColor,)
                              :
                          const Icon(
                            Icons.error, size: 30, color: errorColor,)
                      ),
                    ),

                    Text(
                        authProvider.forgotMessage, // Text displayed on the button
                        style: GoogleFonts.rubik().copyWith(fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: textColorBody)),


                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: ()=> context.go(LoginScreen.routeName),

                        child: Container(
                            width: 100,
                            height: 45,
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
                                    AppLocalizations.of(context)!.ok, // Text displayed on the button
                                    style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: btnColor)),

                              ],
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          );
        });
  }



  void signupReq() async {

    if(containCharacter && containCapital && containNumber){
      if(passwordEditingController.text.toString().isNotEmpty && confirmPasswordEditingController.text.toString().isNotEmpty){
        if(passwordEditingController.text.toString().length > 8){
          if(passwordEditingController.text.toString() == confirmPasswordEditingController.text.toString()){
            try{

              authProvider.registerUserReq({
                "email": widget.requestBody['email'],
                "first_name": widget.requestBody['first_name'],
                "last_name": widget.requestBody['last_name'],
                "password1": passwordEditingController.text.toString(),
                "password2": confirmPasswordEditingController.text.toString()
              }).then((onValue){
                _showMyDialog();

              });


            }finally{

              passwordEditingController.clear();
              confirmPasswordEditingController.clear();
            }
          }else{
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.passwordMustBeSame);
          }
        }else {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.passwordToShort);
        }
      }else{
        Fluttertoast.showToast(msg: AppLocalizations.of(context)!.pleaseEnterAllFields);
      }
    }




  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                              width: width * 0.27
                          ),
                          Text(
                              AppLocalizations.of(context)!
                                  .password, // Text displayed on the button
                              style: GoogleFonts.rubik().copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54))
                        ],
                      ),
                    ),

                    SizedBox(
                      width: width,
                      height: height ,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, height * 0.1, 0, 0),
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

                                      })
                                    },
                                    child: SizedBox(
                                      width: width,
                                      height: height * 0.6,
                                      child: Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(
                                                AppLocalizations.of(context)!.password,
                                                style: GoogleFonts.rubik().copyWith(fontSize: 17, fontWeight: FontWeight.w600, color: textColor),
                                              ),

                                              const SizedBox(
                                                height: 5,
                                              ),

                                              Text(
                                                AppLocalizations.of(context)!.please_enter_password,
                                                style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
                                              ),

                                              SizedBox(
                                                height: height * 0.02,
                                              ),


                                              SizedBox(
                                                height: height * 0.06,
                                                child: Focus(
                                                  onFocusChange: (value) {
                                                    setState(() {
                                                      _focusPassword = value;
                                                    });
                                                  },
                                                  child: TextField(
                                                    onChanged: (value) => {
                                                      
                                                      if(value.contains(RegExp(r'[0-9]'))){
                                                        setState(() {
                                                          containNumber = true;
                                                        })
                                                      }else{
                                                        setState(() {
                                                          containNumber = false;
                                                        })
                                                      },






                                                      if(value.contains(RegExp(r'[A-Z]'))){
                                                        setState(() {
                                                          containCapital = true;
                                                        })
                                                      }else{
                                                        setState(() {
                                                          containCapital = false;
                                                        })
                                                      },


                                                      if(value.contains(RegExp(r"[$&+,:;=?@#|'<>.^*()%!-]"))){
                                                        setState(() {
                                                          containCharacter = true;
                                                        })
                                                      }else{
                                                        setState(() {
                                                          containCharacter = false;
                                                        })
                                                      }

                                                    },
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


                                              SizedBox(
                                                height: height * 0.01,
                                              ),




                                              SizedBox(
                                                height: height * 0.06,
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

                                              SizedBox(
                                                height: height * 0.02,
                                              ),


                                              Row(
                                                children: [
                                                  Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration: BoxDecoration(
                                                        color: containCapital ? Colors.green.withOpacity(0.2) : hintColor,
                                                        borderRadius: BorderRadius.circular(56)
                                                    ),
                                                    child: Center(
                                                        child:  Icon(Icons.check, color: containCapital ? successColor : Colors.grey, size: 15,)
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                    width: 10,
                                                  ),

                                                  Text(
                                                    AppLocalizations.of(context)!.containsACapitaLetter,
                                                    style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: containCapital ? successColor : hintColor),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration: BoxDecoration(
                                                        color: containNumber ? Colors.green.withOpacity(0.2) : hintColor,
                                                        borderRadius: BorderRadius.circular(56)
                                                    ),
                                                    child: Center(
                                                        child:  Icon(Icons.check, color: containNumber ? successColor : Colors.grey, size: 15,)
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                    width: 10,
                                                  ),

                                                  Text(
                                                    AppLocalizations.of(context)!.containANumber,
                                                    style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: containNumber ? successColor : hintColor),
                                                  ),
                                                ],
                                              ),


                                              SizedBox(
                                                height: height * 0.01,
                                              ),

                                              Row(
                                                children: [
                                                  Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration: BoxDecoration(
                                                        color: containCharacter ? Colors.green.withOpacity(0.2) : hintColor,
                                                        borderRadius: BorderRadius.circular(56)
                                                    ),
                                                    child: Center(
                                                        child:  Icon(Icons.check, color: containCharacter ? successColor : Colors.grey, size: 15,)
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                    width: 10,
                                                  ),

                                                  Text(
                                                    AppLocalizations.of(context)!.containASpacialCharacter,
                                                    style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: containCharacter ? successColor : hintColor),
                                                  ),
                                                ],
                                              ),


                                              SizedBox(
                                                height: height * 0.05,
                                              ),


                                              Center(
                                                child: InkWell(
                                                  onTap: (){
                                                    signupReq();

                                                  },
                                                  child: Container(
                                                      width: width * 0.6,
                                                      height: height * 0.067,
                                                      decoration: BoxDecoration(
                                                          gradient: cardColorBlue,
                                                          borderRadius: BorderRadius.circular(15)
                                                      ),
                                                      child: Consumer<AuthProvider>(builder: (context, data, child) {

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
                                                                AppLocalizations.of(context)!.signUpTitle, // Text displayed on the button
                                                                style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white)),
                                                            SizedBox(
                                                              width: width * 0.02,
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