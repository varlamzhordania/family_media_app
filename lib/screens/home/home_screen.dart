import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:familyarbore/models/member/member_model.dart' show MemberModel;
import 'package:familyarbore/provider/post_provider.dart';
import 'package:familyarbore/screens/createPost/create_post_screen.dart';
import 'package:familyarbore/screens/requests/requests_screen.dart';
import 'package:familyarbore/utils/Constant.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';
import '../../components/comments_modal_fix.dart';
import '../../generated/assets.dart';
import '../../models/posts/posts_model.dart';
import '../../service/sharedPreferences_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostProvider postProvider;

  final SharedPreferencesService preferences =
  GetIt.instance<SharedPreferencesService>();


  Map<String, dynamic>? data;
  late List<MemberModel> dataMemberShip;



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

  void getData() async{
    WidgetsFlutterBinding.ensureInitialized();
    dataMemberShip = await preferences.getMemberObject(MEMBERSHIP);
    data = await preferences.getObject(USER);
    setState(() {
    });
  }


  void likePost(Map<String, dynamic> requestsBody) async {
    await postProvider.likePost(requestsBody).then((onValue){
      _fetchNextPage();

    });
  }


  @override
  void initState() {
    getData();
    postProvider = Provider.of<PostProvider>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;


    return SafeArea(
        child: Scaffold(
          floatingActionButton: GestureDetector(
            onTap: ()=> context.push(CreatePostScreen.routeName),
            child: Container(
              width: width * 0.14,
              height: width * 0.14,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Icon(Icons.add),
              ),
            ),
          ),
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.title,
                            style: GoogleFonts.rubik().copyWith(
                                color: textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.push(RequestsScreen.routeName)
                            },
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                  Assets.iconsNotificationBing,
                                  color: textColorBody,
                                  width: 25,
                                  height: 25,
                                ),

                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "2",
                                      style: GoogleFonts.rubik().copyWith(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    Expanded(

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
                                    child: Row(
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
                                        )
                                      ],
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
                                                    if(items.likes!.users!.contains(dataMemberShip[0].id)){
                                                      likePost(
                                                          {"post":items.id,"action":"UNLIKE"}
                                                      )
                                                    }else{
                                                      likePost(
                                                          {"post":items.id,"action":"LIKE"}
                                                      )
                                                    }

                                                  },
                                                  child: items.likes!.users!.contains(dataMemberShip[0].id) ? SvgPicture.asset(
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
                Positioned(
                    right: 20,
                    bottom: 20,
                    child: SizedBox(
                      width: width * 0.1,
                      height: width * 0.1,
                    ))
              ],

            ),
          ),
        )
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
