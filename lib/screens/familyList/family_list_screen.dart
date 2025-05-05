import 'dart:convert';

import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math;
import '../../components/drop_down_menu_painter.dart';
import '../../generated/assets.dart';

class FamilyListScreen extends StatefulWidget {
  static String routeName = "/FamilyListScreen";

  const FamilyListScreen({super.key});

  @override
  State<FamilyListScreen> createState() => _FamilyListScreenState();
}

class _FamilyListScreenState extends State<FamilyListScreen> {
  final testFamily = [
    {"groupName": "Chavazi Family", "bio": "hello and welcome my children"},
    {"groupName": "Badri Family", "bio": "welcome to my soul society"}
  ];

  final groupMembers = [
    "Alex Montana",
    "ALi chavaiz",
    "James Chavazi",
    "Marya Chavazi",
    "Mania Badri",
    "Peeter Chavazi",
    "+"
  ];

  String _selectedCompany = "";

  List<DropdownMenuItem> _dropdownMenuItems = [
    DropdownMenuItem(child: Text("Test")),
    DropdownMenuItem(child: Text("Test2"))
  ];

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
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
                    AppLocalizations.of(context)!
                        .familyList, // Text displayed on the button
                    style: GoogleFonts.rubik().copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textColor))
              ],
            ),
            SingleChildScrollView(
              child: SizedBox(
                  child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: testFamily.map((test) {
                  var ttf = jsonEncode(test);
                  var ss = jsonDecode(ttf);

                  return Card(
                    color: backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  profile(),
                                  SizedBox(
                                    width: _width * 0.03,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: groupName(
                                          group: ss["groupName"].toString(),
                                        ),
                                      ),
                                      bioText(bio: ss["bio"].toString()),
                                    ],
                                  ),
                                ],
                              ),
                          
                          
                          
                              SizedBox(
                                width: _width,
                                height: _height * 0.1,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: groupMembers.map((member) {
                          
                                    return profileTextLikeImage(memberName: member);
                          
                                  }).toList()),
                              )
                            ],
                          ),
                          Positioned(
                            right: 10,
                              top: 10,
                              child: GestureDetector(
                                onTap: () => {
                                  CustomDropdownButton(
                                    value: _selectedCompany,
                                    items: _dropdownMenuItems,
                                    onChanged: (value) => {

                                    },
                                  ),
                                },
                                child: SvgPicture.asset(
                                                            width: 20,
                                                            height: 20,
                                                            fit: BoxFit.fill,
                                                            color: Colors.grey,
                                                            Assets.iconsMore,
                                                            semanticsLabel: 'back to Profile',
                                                          ),
                              ))
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
            ),
          ],
        ),
      ),
    ));
  }
}

class profile extends StatelessWidget {
  const profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      height: 65,
      child: CircleAvatar(
        radius: 56,
        backgroundColor: Colors.white.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(3),
          // Border radius
          child: ClipOval(
              child: Image.asset(
            Assets.imagesFile,
            width: 50,
            height: 50,
          )),
        ),
      ),
    );
  }
}


class profileTextLikeImage extends StatelessWidget {
  final String memberName;

  const profileTextLikeImage({
    super.key, required this.memberName,
  });




  @override
  Widget build(BuildContext context) {
    var member = memberName.split(" ");
    var fmember = member.first.toString().toUpperCase().split("");
    var lmember = member.last.toString().toUpperCase().split("");
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircleAvatar(
          radius: 56,
          backgroundColor: memberName != "+" ? Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2) : Colors.grey.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(3),
            // Border radius
            child: ClipOval(
                child: Text(
                  memberName != "+" ? fmember.first + lmember.first : memberName,
                  style: GoogleFonts.rubik().copyWith(
                      fontWeight: FontWeight.w800, fontSize: memberName != "+" ? 12 : 18, color: textColorBody),
                )),
          ),
        ),
      ),
    );
  }
}


class bioText extends StatelessWidget {
  final String bio;
  const bioText({
    super.key,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      bio,
      style: GoogleFonts.rubik().copyWith(
          fontWeight: FontWeight.w300, fontSize: 12, color: textColorBody),
    );
  }
}

class groupName extends StatelessWidget {
  final String group;
  const groupName({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      group,
      style: GoogleFonts.rubik().copyWith(
          fontWeight: FontWeight.w700, fontSize: 13, color: textColor),
    );
  }
}
