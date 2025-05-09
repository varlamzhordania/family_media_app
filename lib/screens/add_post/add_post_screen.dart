import 'dart:io';

import 'package:choice/choice.dart';
import 'package:familyarbore/generated/assets.dart';
import 'package:familyarbore/provider/post_provider.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  static String routeName = "/AddPostScreen";

  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  List<String> choices = [
    'Chavazi',
    'Badri',
  ];

  List<XFile>? selectedImages = [
    XFile("/data/user/0/com.digicube.familyarbore/cache/2f46032e-49f4-4183-a86a-6a71e895068c/IMG_20250416_224455.jpg")
  ];




  selectMultiImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? image = await picker.pickMultipleMedia();
    if (image != null) {
      if(selectedImages!.isNotEmpty || selectedImages != null){

        image.forEach((action){
          selectedImages!.add(action);
        });

      }
    } else {
      selectedImages = null;
    }
    setState(() {});
  }

  selectImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImages!.add(image);
    } else {
      selectedImages = null;
    }
    setState(() {});
  }


  Future<dynamic> buildShowModalBottomSheetHeader(BuildContext context, double _height, double _width) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return SizedBox(
              height: _height * 0.3,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [

                  Container(
                    height: _height * 0.15,
                    width: _width * 0.8,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await selectMultiImage();
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.chooseFromGallery,
                                // Text displayed on the button
                                style: GoogleFonts
                                    .rubik()
                                    .copyWith(
                                    fontSize: 18,
                                    fontWeight:
                                    FontWeight
                                        .w300,
                                    color:
                                    Colors.blueAccent)),
                          ),
                          GestureDetector(
                              onTap: () async {
                                await selectImageCamera();
                                Navigator.pop(context);
                              },
                              child:Center(
                                child: Text(AppLocalizations.of(context)!.takeAPhoto,
                                    // Text displayed on the button
                                    style: GoogleFonts
                                        .rubik()
                                        .copyWith(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight
                                            .w300,
                                        color:
                                        Colors.blueAccent)),
                              )
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: _height * 0.08,
                      width: _width * 0.8,
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(AppLocalizations.of(context)!.cancel,
                              // Text displayed on the button
                              style: GoogleFonts
                                  .rubik()
                                  .copyWith(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight
                                      .w300,
                                  color:
                                  Colors.blueAccent)),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }


  List<String> multipleSelected = [];

  final decEditingController = TextEditingController();

  final focusNodeDec = FocusNode();

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }



  @override
  void dispose() {
    decEditingController.dispose();
    focusNodeDec.dispose();
    selectedImages = null;



    super.dispose();
  }

  SizedBox decField(double _height, BuildContext context) {
    return SizedBox(
      height: _height * 0.12,
      child: TextField(
        maxLines: 50,
        keyboardType: TextInputType.text,
        focusNode: focusNodeDec,
        controller: decEditingController,
        style: GoogleFonts.rubik().copyWith(
            fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
        decoration: InputDecoration(

            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: hintColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: borderColor),
            ),
            hintText: AppLocalizations.of(context)!.telUsPost,
            hintStyle: GoogleFonts.rubik().copyWith(
                fontSize: 12, fontWeight: FontWeight.w400, color: hintColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            border: InputBorder.none),
      ),
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header(width: _width),
            SizedBox(
              height: _height * 0.015,
            ),
            familySelect(_width),
            decField(_height, context),
            SizedBox(
              height: _height * 0.015,
            ),
            imageSelect(_width, _height, context),
            SizedBox(
              height: _height * 0.3,
            ),
            Center(
              child: InkWell(
                onTap: () =>{
                  context.pop()
                },
                child: Container(
                    width: _width * 0.8,
                    height: _height * 0.057,
                    decoration: BoxDecoration(
                        gradient: cardColorBlue,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Consumer<PostProvider>(builder: (context, data, child) {
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
                              AppLocalizations.of(context)!.post, // Text displayed on the button
                              style: GoogleFonts.rubik().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white)),
                          SizedBox(
                            width: _width * 0.02,
                          ),


                          SvgPicture.asset(
                            width: 15,
                            height: 15,
                            fit: BoxFit.scaleDown,
                            Assets.iconsSend2,
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
    ));
  }

  Container imageSelect(double _width, double _height, BuildContext context) {
    return Container(
            width: _width,
            height: _height * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: hintColor,
                width: 1.0
              )
            ),
            child: (selectedImages == null || selectedImages!.isEmpty) ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () => {
                    buildShowModalBottomSheetHeader(context, _height, _width)
                  },
                  child: SvgPicture.asset(Assets.iconsGalleryAdd,
                  color: hintColor.withOpacity(0.5),
                  width: _width * 0.1,
                  height: _width * 0.1,
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Text(
                  "Select file",
                  style: GoogleFonts.spaceGrotesk().copyWith(
                    color: textColorBody,
                    fontSize: 14
                  ),
                )
              ],
            ):
                SizedBox(
                  width: _width,
                  height: _height * 0.13,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: selectedImages!.isNotEmpty ? (selectedImages!.length + 1) : selectedImages!.length,
                      itemBuilder: (context, index){

                        debugPrint(selectedImages![0].path.toString());


                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: _width * 0.23,
                            height: _height * 0.1,
                            child: index == (selectedImages!.length) ?
                                GestureDetector(
                                  onTap: ()=>{
                                    buildShowModalBottomSheetHeader(context, _height, _width)
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                        color: hintColor,
                                        width: 1.0
                                      )
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        Assets.iconsGalleryAdd,
                                        width: _width * 0.1,
                                        height: _width * 0.1,
                                        fit: BoxFit.fill,
                                        color: hintColor.withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                )
                                : Stack(
                                  children: [
                                    Positioned.fill(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                          width: _width,
                                          height: _height * 0.1,
                                          child: Image.file(
                                            File(selectedImages![index].path),
                                            width: _width,
                                            height: _height * 0.1,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 1,
                                      left:1,
                                      child: GestureDetector(
                                        onTap: () =>{
                                          selectedImages!.removeAt(index),
                                          setState(() {

                                          })
                                        },
                                        child: Container(
                                          width: _width * 0.06,
                                          height: _width * 0.06,
                                          decoration: BoxDecoration(
                                            color: errorColor,
                                            borderRadius: BorderRadius.circular(12)
                                          ),

                                          child: Center(
                                            child: SvgPicture.asset(
                                              Assets.iconsTrash,
                                              width: _width * 0.03,
                                              height: _width * 0.03,
                                              color: Colors.white,

                                            ),
                                          ),

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                          ),
                        );



                  }),
                )
          );
  }

  SizedBox familySelect(double _width) {
    return SizedBox(
            width: _width,
            child: Card(
              color: backgroundColor,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Choice<String>.prompt(
                title: 'Family',
                multiple: false,
                value: multipleSelected,
                onChanged: setMultipleSelected,
                itemCount: choices.length,
                itemBuilder: (state, i) {
                  return CheckboxListTile(

                    fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.white;
                      }
                      if (states.contains(WidgetState.focused)) {
                        return Colors.white;
                      }
                      return Colors.white;
                    }),
                    value: state.selected(choices[i]),
                    onChanged: state.onSelected(choices[i]),
                    title: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                modalHeaderBuilder: ChoiceModal.createHeader(
                  automaticallyImplyLeading: false,
                ),
                promptDelegate: ChoicePrompt.delegateBottomSheet(),
              ),
            ),
          );
  }
}

class header extends StatelessWidget {
  const header({
    super.key,
    required double width,
  }) : _width = width;

  final double _width;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          width: _width * 0.25,
        ),
    
        Text(
            AppLocalizations.of(context)!.addPostTitle, // Text displayed on the button
            style: GoogleFonts.rubik().copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: textColor))
      ],
    );
  }
}


class btn_cancel extends StatelessWidget {
  const btn_cancel({
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
        onTap: () =>         context.pop(),
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
                    AppLocalizations.of(context)!.cancel, // Text displayed on the button
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
