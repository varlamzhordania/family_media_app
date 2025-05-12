import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:familyarbore/models/member/member_model.dart';
import 'package:familyarbore/provider/auth_provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:familyarbore/provider/post_provider.dart';
import 'package:familyarbore/screens/familyList/family_list_screen.dart';
import 'package:familyarbore/screens/profile/edit/edit_profile_screen.dart';
import 'package:familyarbore/service/sharedPreferences_service.dart';
import 'package:familyarbore/utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../components/animation_family.dart';
import '../../components/comments_modal_fix.dart';
import '../../generated/assets.dart';
import '../../models/posts/posts_model.dart';
import '../../utils/theme_colors.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/ProfileScreen";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final SharedPreferencesService sharedPreferences = GetIt.instance<SharedPreferencesService>();
  
  late final PostProvider postProvider;
  late final AuthProvider authProvider;

  Map<String, dynamic>? dataUser;
  List<MemberModel>? dataMemberShip;

  int currentIndex = 0;

  PagingState<int, Post> _state = PagingState();

  void _fetchNextPage() async {
    if (_state.isLoading) return;

    setState(() {
      _state = _state.copyWith(isLoading: true, error: null);
    });

    try {
      final newKey = (_state.keys?.last ?? 0) + 1;
      final newItems = await postProvider.getHomePost(newKey);

      final isLastPage = postProvider.is_lastPage;

      setState(() {
        _state = _state.copyWith(
          pages: [...?_state.pages, newItems],
          keys: [...?_state.keys, newKey],
          hasNextPage: !isLastPage,
          isLoading: false,
        );
      });
    } catch (error) {
      setState(() {
        _state = _state.copyWith(
          error: error,
          isLoading: false,
        );
      });
    }
  }


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


  Future<void> _getDataLoaded() async{
    WidgetsFlutterBinding.ensureInitialized();
    postProvider = Provider.of<PostProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    dataUser = await sharedPreferences.getObject(USER);
    dataMemberShip = await sharedPreferences.getMemberObject(MEMBERSHIP);

    setState(() {

    });
    debugPrint("dataUser: ${dataUser!['bg_cover']}");
  }


  @override
  void initState() {
    _getDataLoaded();
    super.initState();

  }

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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              dataUser!['bg_cover'] != null
                  ? CachedNetworkImage(
                      imageUrl: dataUser!['bg_cover'],
                      width: width,
                      height: height * 0.17,
                      fit: BoxFit.fill,

                    )
                  : SizedBox(
                    width: width,
                    child: SvgPicture.asset(
                      Assets.imagesPatt,
                      width: width,
                      height: height * 0.17,
                      fit: BoxFit.fill,

                    ),
                  ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async{

                              buildShowModalBottomSheetLogout(context, height, width);

                            },
                            child: const Logout(),
                          ),
                          GestureDetector(
                            onTap: () async {
                              buildShowModalBottomSheetHeader(context, height);
                            },
                            child: const headerImage(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        children: [
                          profileAndEdit(test_profile: dataUser!["avatar"]),
                          SizedBox(
                            width: width * 0.17,
                          ),
                          bubbleFamily(context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: fullName(name: dataUser!["full_name"]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 30, 0),
                      child: bioText(bio: dataUser!["bio"] ?? "No bio set"),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    SizedBox(height: height * 0.01),
                    Expanded(
                      flex: 1,
                      child: PagedListView<int, Post>(
                        state: _state,
                        fetchNextPage: _fetchNextPage,
                        builderDelegate: PagedChildBuilderDelegate(

                          itemBuilder: (context, items, index) {


                            final createdAt = DateTime.parse(items.createdAt.
                            toString());
                            final now = DateTime.now();


                            String relativeTime = timeago.format(
                                createdAt, clock: now);


                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      width: width,
                                      height: height * 0.048,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Row(
                                            children: [

                                              SizedBox(
                                                width: width * 0.11,
                                                height: width * 0.11,
                                                child: CircleAvatar(
                                                  radius: 56,
                                                  backgroundColor: Colors.white
                                                      .withOpacity(0.5),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(3),
                                                    // Border radius
                                                    child: ClipOval(
                                                        child: items.author!.member!
                                                            .avatar == null
                                                            ? Image.asset(
                                                          Assets.imagesUser,
                                                          width: width * 0.1,
                                                          height: width * 0.1,)
                                                            : CachedNetworkImage(
                                                          imageUrl: items.author!
                                                              .member!.avatar
                                                              .toString(),
                                                          width: width * 0.1,
                                                          height: width * 0.1,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.02,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    items.author!.member!.fullName
                                                        .toString(),
                                                    style: GoogleFonts.rubik()
                                                        .copyWith(
                                                        color: textColor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  Text(
                                                    relativeTime,
                                                    style: GoogleFonts.rubik()
                                                        .copyWith(
                                                        color: textColorBody,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                            ]
                                          ),

                                          const Icon(Icons.more_vert_rounded, size: 20)
                                        ],
                                      ),
                                    ),
                                  ),
                                  CarouselSlider(
                                      items: items.medias!.map((post) {
                                        if(post.ext == ".mp4"){

                                          return ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  2),
                                              child: _BumbleBeeRemoteVideo(movieLink: post.file!));
                                        }else{

                                          return ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  2),
                                              child: CachedNetworkImage(
                                                  imageUrl: post.file.toString(),
                                                  fit: BoxFit.cover));

                                        }

                                      }).toList(),
                                      options: CarouselOptions(
                                          height: height * 0.5,
                                          reverse: false,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              currentIndex = index;
                                            });
                                          },
                                          enableInfiniteScroll: false,
                                          viewportFraction: 1.0)),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 4, 0, 0),
                                    child: SizedBox(
                                      width: width,
                                      height: height * 0.04,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.4,
                                            height: height * 0.05,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () =>
                                                  {
                                                    // likePost(
                                                    //   // {
                                                    //   //   {"post":8,"action":"LIKE"}
                                                    //   // }
                                                    // )
                                                  },
                                                  child: items.likes!.users!.contains(dataMemberShip![0].id) ? SvgPicture.asset(
                                                    Assets.iconsHeartFill,
                                                    color: errorColor,
                                                    width: width * 0.06,
                                                    height: width * 0.06,
                                                  )
                                                      :
                                                  SvgPicture.asset(
                                                    Assets.iconsHeart,
                                                    color: textColorBody,
                                                    width: width * 0.06,
                                                    height: width * 0.06,

                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                Text(
                                                  items.likes!.counter
                                                      .toString(),
                                                  style: GoogleFonts.rubik()
                                                      .copyWith(
                                                      color: textColorBody,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight
                                                          .w400),
                                                ),
                                                SizedBox(
                                                  width: width * 0.05,
                                                ),
                                                GestureDetector(
                                                    onTap: () =>
                                                    {
                                                      // setState(() {
                                                      //   postId = items.id!.toInt();
                                                      // }),

                                                      buildShowModalBottomSheetComments(
                                                          context, height,
                                                          width,
                                                          items.id!.toInt())
                                                    },
                                                    child: SvgPicture.asset(
                                                      Assets.iconsMessageText,
                                                      color: textColorBody,
                                                      width: width * 0.06,
                                                      height: width * 0.06,
                                                    )),


                                              ],
                                            ),
                                          ),
                                          items.medias!.length > 1 ? Align(
                                              alignment: Alignment.topCenter,
                                              child: DotsIndicator(
                                                dotsCount: items.medias!.length,
                                                position: currentIndex.toDouble(),
                                                decorator: DotsDecorator(
                                                  color: Colors.grey,
                                                  activeColor: textColor,
                                                  size: const Size.square(5.0),
                                                  activeSize: const Size(7.0, 7.0),
                                                  activeShape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(5.0)),

                                                ),
                                              )
                                          ) :
                                          Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 5, 0),
                                    child: Text(
                                      utf8.decode(items.text.toString().runes.toList()),
                                      style: GoogleFonts.rubik().copyWith(
                                        color: textColorBody,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Column userPosts(ss, double width, double height) {
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
                                  width: width,
                                  height: height * 0.4,
                                  fit: BoxFit.fill)
                              ),


                              SizedBox(
                                height: height * 0.02,
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
                                      width: width * 0.01,
                                    ),
                                    Text(ss['likes'].toString(),
                                        style: GoogleFonts.rubik().copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: textColorBody)),
                                    SizedBox(
                                      width: width * 0.05,
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
                                      width: width * 0.01,
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
                                height: height * 0.01,
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
                                height: height * 0.1,
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

  Future<dynamic> buildShowModalBottomSheetLogout(BuildContext context, double height, double width) {
    return showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    height: height * 0.26,
                                    width: width,

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
                                                          width: width * 0.4,
                                                          height: height * 0.057,
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
                                                          width: width * 0.4,
                                                          height: height * 0.057,
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

  Future<dynamic> buildShowModalBottomSheetHeader(BuildContext context, double height) {
    return showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    height: height * 0.26,
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
                                                height: height * 0.05,
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
  final String bio;
  const bioText({
    super.key, required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      bio,
      style: GoogleFonts.rubik().copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 12,
          color: textColorBody),
    );
  }
}

class fullName extends StatelessWidget {
  final String name;
  const fullName({
    super.key, required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
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
    this.test_profile,
  });

  final String? test_profile;

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
                  child: test_profile == null
                      ? Image.asset(
                          Assets.imagesUser,
                          width: 85,
                          height: 85,
                    fit: BoxFit.fill,

                  )
                      : CachedNetworkImage(
                          imageUrl: test_profile.toString(),
                          width: 85,
                          height: 85,
                          fit: BoxFit.fill,
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





class _BumbleBeeRemoteVideo extends StatefulWidget {
  final String movieLink;

  const _BumbleBeeRemoteVideo({required this.movieLink});
  @override
  _BumbleBeeRemoteVideoState createState() => _BumbleBeeRemoteVideoState();
}

class _BumbleBeeRemoteVideoState extends State<_BumbleBeeRemoteVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          widget.movieLink),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool is_play = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: AspectRatio(
              aspectRatio: 16.0/16.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[

                  VideoPlayer(_controller),
                  _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true, colors: const VideoProgressColors(playedColor: Colors.black12),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_circle_filled_rounded,
                color: Colors.white,
                size: 100.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),

      ],
    );
  }
}
