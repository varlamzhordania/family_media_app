import 'package:familyarbore/main.dart';
import 'package:familyarbore/provider/auth_provider.dart';
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
class ForgotPassword extends StatefulWidget {
  static String routeName = "/ForgotPassword";
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final authProvider = GetIt.instance<AuthProvider>();


  bool _focusEmail = false;

  late TextEditingController emailEditingController;


  @override
  void initState() {
    // authProvider = Provider.of<AuthProvider>(context, listen: false);
    emailEditingController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    emailEditingController.dispose();
    super.dispose();
  }



  Future<void> _showMyDialog() async {

    debugPrint("test ${authProvider.forgotMessage.toString()}");
    debugPrint("test2 ${authProvider.is_success.toString()}");


    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            content: SizedBox(
              width: 200,
              height: 120,
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
                         Icon(
                          Icons.check_circle, size: 30, color: successColor,)
                          :
                        Icon(
                          Icons.error, size: 30, color: errorColor,)
                      ),
                    ),

                    Text(
                        authProvider.forgotMessage, // Text displayed on the button
                        style: GoogleFonts.rubik().copyWith(fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: textColorBody)),
                  ],
                ),
              ),
            ),

          );
        });
  }


  void forgotPasswordViaEmail() async{

    if(emailEditingController.text.isNotEmpty){
      if(emailEditingController.text.contains("@")){
        try{
          await authProvider.forgotPasswordReq({
            "email": emailEditingController.text.toString()
          });
        }finally{
          _showMyDialog();
        }


      }else{
        Fluttertoast.showToast(msg: "The Input Must be Email");
      }

    }else{
      Fluttertoast.showToast(msg: "Please Enter Your Email");
    }



  }






  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;







    return  SafeArea(
      child: Scaffold(
          backgroundColor: lightBluColor2,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
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
                            onTap: () => context.pop(),
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
                            width: _width * 0.2
                          ),
                          Text(
                              AppLocalizations.of(context)!
                                  .forgetPasswordScreenTitle, // Text displayed on the button
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
                                        _focusEmail = false;
                                                
                                      })
                                    },
                                    child: SizedBox(
                                      width: _width,
                                      height: _height * 0.5,
                                      child: Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                
                                              Text(
                                                AppLocalizations.of(context)!.forgetPasswordScreenTitle,
                                                style: GoogleFonts.rubik().copyWith(fontSize: 17, fontWeight: FontWeight.w600, color: textColor),
                                              ),
                                                
                                              const SizedBox(
                                                height: 5,
                                              ),
                                                
                                              Text(
                                                AppLocalizations.of(context)!.pleaseEnterYouEmail,
                                                style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
                                              ),
                                                
                                              const SizedBox(
                                                height: 20,
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
                                                height: 20,
                                              ),
                                                
                                              Center(
                                                child: InkWell(
                                                  onTap: (){
                                                    forgotPasswordViaEmail();
                                                  },
                                                  child: Container(
                                                      width: _width * 0.6,
                                                      height: _height * 0.067,
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
                                                                AppLocalizations.of(context)!.sendEmail, // Text displayed on the button
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
