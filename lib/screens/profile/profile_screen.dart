import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:familyarbore/provider/auth_provider.dart';
import 'package:familyarbore/screens/familyList/family_list_screen.dart';
import 'package:familyarbore/screens/profile/edit/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/animation_family.dart';
import '../../generated/assets.dart';
import '../../utils/theme_colors.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/ProfileScreen";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  final authProvider = GetIt.instance<AuthProvider>();
  
  final String test_header =
      "https://media.mehrnews.com/d/2018/06/27/3/2818246.jpg";
  final bool test_profile = true;

  List<String> selectedFamily = [];

  final bubbles = [
    'Tournament',
    'Flight Booking',
    'Barber Shop',
    '+',
    // 'hello'
  ];

  final posts = [
    {
      "image":
          "https://dazzlinginsights.com/wp-content/uploads/2020/04/Post_1-862x575.jpeg",
      "body": "a wonderful day with my wife ....",
      "likes": 15,
      "comments": 1
    },
    {
      "image":
          "https://nationaltoday.com/wp-content/uploads/2022/06/20-Perfect-Family-1-1200x834.jpg",
      "body": "a wonderful day with my wife ....",
      "likes": 100,
      "comments": 74
    },
    {
      "image":
          "https://www.verywellmind.com/thmb/QgNHSjmX7obIUVXBAcAYZFRu2oU=/2122x0/filters:no_upscale():max_bytes(150000):strip_icc()/family-parents-grandparents-Morsa-Images-Taxi-56a906ad3df78cf772a2ef29.jpg",
      "body": "a wonderful day with my wife .....",
      "likes": 10,
      "comments": 10
    },
    {
      "image":
          "https://www.relationships.org.au/wp-content/uploads/blended-families.jpeg",
      "body": "a wonderful day with my wife ....",
      "likes": 20,
      "comments": 9
    },
    {
      "image":
          "https://cdn.cdnparenting.com/articles/2019/05/18095611/international-family-day.webp",
      "body": "a wonderful day with my wife ... ",
      "likes": 11,
      "comments": 54
    },
  ];
  var is_liked = false;

  File? selectedHeader;

  selectImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedHeader = File(image.path);
    } else {
      selectedHeader = null;
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
          body: SingleChildScrollView(
            child: Stack(
              children: [
                test_header.isNotEmpty
                    ? Image.network(
                        test_header,
                        width: _width,
                        height: _height * 0.17,
                        fit: BoxFit.fill,
                      )
                    : SvgPicture.asset(
                        width: _width,
                        height: _height * 0.17,
                        fit: BoxFit.fill,
                        Assets.imagesPROFILE,
                        semanticsLabel: 'imagesHeader Profile',
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async{

                              buildShowModalBottomSheetLogout(context, _height, _width);

                            },
                            child: const Logout(),
                          ),
                          GestureDetector(
                            onTap: () async {
                              buildShowModalBottomSheetHeader(context, _height);
                            },
                            child: const headerImage(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _height * 0.05,
                      ),
                      Row(
                        children: [
                          profileAndEdit(test_profile: test_profile),
                          SizedBox(
                            width: _width * 0.17,
                          ),
                          bubbleFamily(context),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: fullName(),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 30, 0),
                        child: bioText(),
                      ),
                      SizedBox(
                        height: _height * 0.04,
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      SizedBox(height: _height * 0.01),
                      SizedBox(
                        width: _width,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: posts.map((post) {
                            var ttf = jsonEncode(post);
                            var ss = jsonDecode(ttf);
                            return userPosts(ss, _width, _height);
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Column userPosts(ss, double _width, double _height) {
    return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                  imageUrl: ss['image'],
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                          LoadingAnimationWidget.threeArchedCircle(
                         color: Colors.black54,
                          size: 50,
                          ),
                                  errorWidget: (context, url, error) => Center(
                                    child: SvgPicture.asset(
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.fill,
                                      color: Colors.grey,
                                      Assets.iconsWarning,
                                      semanticsLabel: 'warning post',
                                    ),
                                  ),
                                  width: _width,
                                  height: _height * 0.4,
                                  fit: BoxFit.fill)
                              ),


                              SizedBox(
                                height: _height * 0.02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => {},
                                      child: Container(
                                        child: Random().nextBool()
                                            ? SvgPicture.asset(
                                                width: 15,
                                                height: 20,
                                                fit: BoxFit.fill,
                                                color: errorColor,
                                                Assets.iconsHeartFill,
                                                semanticsLabel: 'like post',
                                              )
                                            : SvgPicture.asset(
                                                width: 15,
                                                height: 20,
                                                fit: BoxFit.fill,
                                                color: textColor,
                                                Assets.iconsHeart,
                                                semanticsLabel: 'like post',
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _width * 0.01,
                                    ),
                                    Text(ss['likes'].toString(),
                                        style: GoogleFonts.rubik().copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: textColorBody)),
                                    SizedBox(
                                      width: _width * 0.05,
                                    ),
                                    SvgPicture.asset(
                                      width: 15,
                                      height: 20,
                                      fit: BoxFit.fill,
                                      color: textColor,
                                      Assets.iconsMessageText,
                                      semanticsLabel: 'comment post',
                                    ),
                                    SizedBox(
                                      width: _width * 0.01,
                                    ),
                                    Text(ss['comments'].toString(),
                                        style: GoogleFonts.rubik().copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: textColorBody)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _height * 0.01,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text(
                                  ss['body'],
                                  style: GoogleFonts.rubik().copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: textColorBody),
                                ),
                              ),
                              SizedBox(
                                height: _height * 0.1,
                              ),
                            ],
                          );
  }

  SingleChildScrollView bubbleFamily(BuildContext context) {
    return SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 16,
                            children: bubbles.map((bubble) {
                              bool isSelected =
                                  selectedFamily.contains(bubble);
                              return RandomFloatingBubble(
                                text: bubble,
                                isSelected: isSelected,
                                onTap: () {
                                  setState(() {

                                    if(bubble == "+"){
                                      context.push(FamilyListScreen.routeName);
                                    }
                                    // if (isSelected) {
                                    //   selectedFamily.remove(bubble);
                                    // } else {
                                    //   selectedFamily.add(bubble);
                                    // }
                                  });
                                },
                                shrink:
                                    selectedFamily.isNotEmpty && !isSelected,
                                clustering: selectedFamily.length > 1,
                              );
                            }).toList(),
                          ),
                        );
  }

  Future<dynamic> buildShowModalBottomSheetLogout(BuildContext context, double _height, double _width) {
    return showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    height: _height * 0.33,
                                    width: _width,
                                    color: Colors.transparent,
                                    //could change this to Color(0xFF737373),
                                    //so you don't have to change MaterialApp canvasColor
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft:
                                                Radius.circular(10.0),
                                                topRight:
                                                Radius.circular(10.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [

                                              Container(
                                                width: 55,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                    color: Colors.red.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(100)),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    width: 35,
                                                    height: 35,
                                                    fit: BoxFit.fill,
                                                    color: errorColor,
                                                    Assets.iconsLogout,
                                                    semanticsLabel: 'Logout Profile',
                                                  ),
                                                ),
                                              ),

                                          const SizedBox(
                                            height: 10,
                                          ),


                                          Text(
                                              AppLocalizations.of(context)!.logout, // Text displayed on the button
                                              style: GoogleFonts.rubik().copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: textColor)),

                                              Text(
                                                  AppLocalizations.of(context)!.logoutSure, // Text displayed on the button
                                                  style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody)),

                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [


                                                    GestureDetector(
                                                      onTap: () => {
                                                        Navigator.of(context).pop()
                                                      },
                                                      child: Container(
                                                          width: _width * 0.4,
                                                          height: _height * 0.057,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(25),
                                                              border: Border.all(
                                                                color: logoutColor,
                                                                width: 2,
                                                              )),
                                                          child: Center(
                                                            child: Text(AppLocalizations.of(context)!.no,
                                                                // Text displayed on the button
                                                                style: GoogleFonts.rubik().copyWith(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w400,
                                                                    color: logoutColor)),
                                                          )),
                                                    ),



                                                    GestureDetector(
                                                      onTap: () => {
                                                        authProvider.logout()
                                                      },
                                                      child: Container(
                                                          width: _width * 0.4,
                                                          height: _height * 0.057,
                                                          decoration: BoxDecoration(
                                                              gradient: cardColorRed,
                                                              borderRadius: BorderRadius.circular(25)
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                                AppLocalizations.of(context)!.logout, // Text displayed on the button
                                                                style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white)),
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        )),
                                  );
                                });
  }

  Future<dynamic> buildShowModalBottomSheetHeader(BuildContext context, double _height) {
    return showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    height: _height * 0.3,
                                    color: Colors.transparent,
                                    //could change this to Color(0xFF737373),
                                    //so you don't have to change MaterialApp canvasColor
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(10.0),
                                                topRight:
                                                    Radius.circular(10.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: _height * 0.05,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await selectImage(
                                                      source: ImageSource
                                                          .gallery);
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.fill,
                                                      color: Colors.black,
                                                      Assets.iconsGallery,
                                                      semanticsLabel:
                                                          'Gallery chosen',
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(AppLocalizations.of(context)!.chooseFromGallery,
                                                        // Text displayed on the button
                                                        style: GoogleFonts
                                                                .rubik()
                                                            .copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color:
                                                                    textColor))
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await selectImage(
                                                      source:
                                                          ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.fill,
                                                      color: Colors.black,
                                                      Assets.iconsCamera,
                                                      semanticsLabel:
                                                          'Camera chosen',
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(AppLocalizations.of(context)!.takeAPhoto,
                                                        // Text displayed on the button
                                                        style: GoogleFonts
                                                                .rubik()
                                                            .copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color:
                                                                    textColor))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  );
                                });
  }
}

class bioText extends StatelessWidget {
  const bioText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "a android developer with a good family",
      style: GoogleFonts.rubik().copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 12,
          color: textColorBody),
    );
  }
}

class fullName extends StatelessWidget {
  const fullName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Mohammad Hossein Chavazi",
      style: GoogleFonts.rubik().copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 17,
          color: textColor),
    );
  }
}

class profileAndEdit extends StatelessWidget {
  const profileAndEdit({
    super.key,
    required this.test_profile,
  });

  final bool test_profile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 90,
          height: 90,
          child: CircleAvatar(
            radius: 56,
            backgroundColor:
                Colors.white.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(3),
              // Border radius
              child: ClipOval(
                  child: test_profile
                      ? Image.asset(
                          Assets.imagesFile,
                          width: 85,
                          height: 85,
                        )
                      : Image.asset(
                          Assets.imagesUser,
                          width: 85,
                          height: 85,
                        )),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 15,
          child: GestureDetector(
            onTap: ()=>{
              context.push(EditProfileScreen.routeName)
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: SvgPicture.asset(
                    width: 15,
                    height: 20,
                    fit: BoxFit.fill,
                    color: greenColor,
                    Assets.iconsEdit,
                    semanticsLabel: 'edit Profile',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class headerImage extends StatelessWidget {
  const headerImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100)),
      child: Center(
          child: Text("+",
              style: GoogleFonts.rubik().copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Colors.grey))),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: errorColor,
          Assets.iconsLogout,
          semanticsLabel: 'Logout Profile',
        ),
      ),
    );
  }
}


