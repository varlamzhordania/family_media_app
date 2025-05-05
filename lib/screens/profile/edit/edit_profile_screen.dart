import 'dart:io';

import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../generated/assets.dart';

class EditProfileScreen extends StatefulWidget {
  static String routeName = "/EditProfileScreen";

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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

  File? selectedImage;


  selectImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
    } else {
      selectedImage = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.pop(context)
                      },
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
                            color: Colors.black,
                            Assets.iconsArrowChevronLeft,
                            semanticsLabel: 'back to Profile',
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                        width: _width * 0.27,
                     ),

                    Text(
                        AppLocalizations.of(context)!.editProfile, // Text displayed on the button
                        style: GoogleFonts.rubik().copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: textColor))
                  ],
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundColor: Colors.white.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(3), // Border radius
                            child: ClipOval(
                                child: selectedImage != null ? Image.file(
                                  selectedImage!,
                                  width: 115,
                                  height: 115,
                                  fit: BoxFit.fill,
                                ) :Image.asset(
                              Assets.imagesFile,
                              width: 115,
                              height: 115,
                                  fit: BoxFit.fill,

                                )),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 45,
                        child: GestureDetector(
                          onTap: () => {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    height: _height * 0.2,
                                    color: Colors.transparent,
                                    //could change this to Color(0xFF737373),
                                    //so you don't have to change MaterialApp canvasColor
                                    child:  Container(
                                        decoration:  const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:  BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(10.0),
                                                topRight: Radius.circular(
                                                    10.0))),
                                        child:  Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(

                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               SizedBox(
                                                height: _height * 0.05,
                                              ),

                                              GestureDetector(
                                                onTap: () async{
                                                  await selectImage(source: ImageSource.gallery);
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.fill,
                                                      color: Colors.black,
                                                      Assets.iconsGallery,
                                                      semanticsLabel: 'Gallery chosen',
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        AppLocalizations.of(context)!.messages, // Text displayed on the button
                                                        style: GoogleFonts.rubik().copyWith(fontSize: 15, fontWeight: FontWeight.w300, color: textColor))
                                                  ],

                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              GestureDetector(
                                                onTap: () async{
                                                  await selectImage(source: ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.fill,
                                                      color: Colors.black,
                                                      Assets.iconsCamera,
                                                      semanticsLabel: 'Camera chosen',
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        AppLocalizations.of(context)!.takeAPhoto, // Text displayed on the button
                                                        style: GoogleFonts.rubik().copyWith(fontSize: 15, fontWeight: FontWeight.w300, color: textColor))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  );
                                })
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SvgPicture.asset(
                                width: 15,
                                height: 20,
                                fit: BoxFit.fill,
                                color: hintColor,
                                Assets.iconsGalleryAdd,
                                semanticsLabel: 'edit Profile',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: _height * 0.06,
                  child: Focus(
                    onFocusChange: (value) {
                      setState(() {
                        _focusFirstName = value;
                      });
                    },
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: firstNameEditingController,
                      style: GoogleFonts.rubik().copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: textColorBody),
                      decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
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
                          hintStyle: GoogleFonts.rubik().copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: hintColor),
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
                        _focusLastName = value;
                      });
                    },
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: lastNameEditingController,
                      style: GoogleFonts.rubik().copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: textColorBody),
                      decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
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
                          hintStyle: GoogleFonts.rubik().copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: hintColor),
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
                        _focusEmail = value;
                      });
                    },
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailEditingController,
                      style: GoogleFonts.rubik().copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: textColorBody),
                      decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
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
                          hintStyle: GoogleFonts.rubik().copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: hintColor),
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
                      style: GoogleFonts.rubik().copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: textColorBody),
                      decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
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
                            child: showPassword
                                ? SvgPicture.asset(
                                    width: 5,
                                    height: 5,
                                    fit: BoxFit.scaleDown,
                                    Assets.iconsEye,
                                    semanticsLabel: 'password icon',
                                    color:
                                        _focusPassword ? hintColor : hintColor,
                                  )
                                : SvgPicture.asset(
                                    width: 5,
                                    height: 5,
                                    fit: BoxFit.scaleDown,
                                    Assets.iconsEyeSlash,
                                    semanticsLabel: 'password icon',
                                    color:
                                        _focusPassword ? hintColor : hintColor,
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
                          hintStyle: GoogleFonts.rubik().copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: hintColor),
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
                      style: GoogleFonts.rubik().copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: textColorBody),
                      decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            width: 5,
                            height: 5,
                            fit: BoxFit.scaleDown,
                            Assets.iconsLock,
                            semanticsLabel: 'password icon',
                            color:
                                _focusConfirmPassword ? borderColor : hintColor,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPasswordConfirm = !showPasswordConfirm;
                              });
                            },
                            child: showPasswordConfirm
                                ? SvgPicture.asset(
                                    width: 5,
                                    height: 5,
                                    fit: BoxFit.scaleDown,
                                    Assets.iconsEye,
                                    semanticsLabel: 'password icon',
                                    color: _focusConfirmPassword
                                        ? hintColor
                                        : hintColor,
                                  )
                                : SvgPicture.asset(
                                    width: 5,
                                    height: 5,
                                    fit: BoxFit.scaleDown,
                                    Assets.iconsEyeSlash,
                                    semanticsLabel: 'password icon',
                                    color: _focusConfirmPassword
                                        ? hintColor
                                        : hintColor,
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
                          hintText:
                              AppLocalizations.of(context)!.confirmPassword,
                          hintStyle: GoogleFonts.rubik().copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: hintColor),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: borderColor,
                            width: 2,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.edit,
                              // Text displayed on the button
                              style: GoogleFonts.rubik().copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: btnColor)),
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
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
