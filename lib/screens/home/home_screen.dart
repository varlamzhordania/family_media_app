import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:familyarbore/models/comments/comment_model.dart';
import 'package:familyarbore/models/posts/posts_model.dart';
import 'package:familyarbore/provider/post_provider.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../components/comments_modal_fix.dart';
import '../../generated/assets.dart';
import '../../models/comments/comments_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostProvider postProvider;

  double _currentPosition = 0.0;
  double _totalDots = 3;




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




  void likePost(Map<String, dynamic> requestsBody) async {
    await postProvider.likePost(requestsBody);
  }




  @override
  void initState() {
    postProvider = Provider.of<PostProvider>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    double _height = MediaQuery
        .of(context)
        .size
        .height;



    return SafeArea(
        child: Scaffold(
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
                        "Family Abore",
                        style: GoogleFonts.rubik().copyWith(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      Stack(
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
                      )
                    ],
                  ),
                              ),
                              SizedBox(
                  height: _height * 0.03,
                              ),


                              // postProvider.is_loading ?
                              // Center(
                              //   child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.grey, size: 20),
                              // )
                              //     :
                              //
                              //     Container(),


                              Expanded(

                    child: PagedListView<int, Post>(
                        state: _state,
                        fetchNextPage: _fetchNextPage,
                        builderDelegate: PagedChildBuilderDelegate(
                            itemBuilder: (context, items, index){
                              double currentPos = 0;


                              final createdAt = DateTime.parse(items.createdAt.
                              toString());
                                 final now = DateTime.now();




                               String relativeTime = timeago.format(createdAt, clock: now);


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
                                            width: _width * 0.11,
                                            height: _width * 0.11,
                                            child: CircleAvatar(
                                              radius: 56,
                                              backgroundColor: Colors.white.withOpacity(0.5),
                                              child: Padding(
                                                padding: const EdgeInsets.all(3),
                                                // Border radius
                                                child: ClipOval(
                                                    child: items.author!.member!.avatar == null ? Image.asset(Assets.imagesUser, width: _width * 0.1,
                                                      height: _width * 0.1,) : CachedNetworkImage(
                                                      imageUrl: items.author!.member!.avatar.toString(),
                                                      width: _width * 0.1,
                                                      height: _width * 0.1,
                                                    )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: _width * 0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                items.author!.member!.fullName.toString(),
                                                style: GoogleFonts.rubik().copyWith(
                                                    color: textColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                relativeTime,
                                                style: GoogleFonts.rubik().copyWith(
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
                                          return ClipRRect(
                                              borderRadius: BorderRadius.circular(2),
                                              child: CachedNetworkImage(
                                                  imageUrl: post.file.toString(),
                                                  fit: BoxFit.cover));
                                        }).toList(),
                                        options: CarouselOptions(
                                            height: _height * 0.5,
                                            reverse: false,
                              onPageChanged: (index, reason) {
                              setState(() {
                              currentPos = index.toDouble();
                              });
                              },
                                            enableInfiniteScroll: false,
                                            viewportFraction: 1.0)),
                                    SizedBox(
                                      height: _height * 0.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                                      child: SizedBox(
                                        width: _width,
                                        height: _height * 0.04,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: _width * 0.4,
                                              height: _height * 0.05,
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: ()=>{
                                                      // likePost(
                                                      //   // {
                                                      //   //   {"post":8,"action":"LIKE"}
                                                      //   // }
                                                      // )
                                                    },
                                                    child: SvgPicture.asset(
                                                      Assets.iconsHeart,
                                                      color: textColorBody,
                                                      width: _width * 0.06,
                                                      height: _width * 0.06,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: _width * 0.01,
                                                  ),
                                                  Text(
                                                    items.likes!.counter.toString(),
                                                    style: GoogleFonts.rubik().copyWith(
                                                        color: textColorBody,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    width: _width * 0.05,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () => {
                                                        // setState(() {
                                                        //   postId = items.id!.toInt();
                                                        // }),

                                                        buildShowModalBottomSheetComments(
                                                            context, _height, _width, items.id!.toInt())
                                                      },
                                                      child: SvgPicture.asset(
                                                        Assets.iconsMessageText,
                                                        color: textColorBody,
                                                        width: _width * 0.06,
                                                        height: _width * 0.06,
                                                      )),


                                                ],
                                              ),
                                            ),
                                            items.medias!.length > 1 ? Align(
                                                                      alignment: Alignment.topCenter,
                                                                      child: DotsIndicator(
                                                                        dotsCount: items.medias!.length,
                                                                        position: currentPos,
                                                                        decorator: DotsDecorator(
                                                                          color: Colors.grey,
                                                                          activeColor: textColor,
                                                                          size:  Size.square(9.0),
                                                                          activeSize:  Size(18.0, 9.0),
                                                                          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

                                                                        ),
                                                                      )
                                                                    ):
                                                                      Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      child: Text(
                                        items.text.toString(),
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
                      child: Container(
                    width: _width * 0.1,
                    height: _width * 0.1,
                  ))
                ],

              ),
    ),
    )
    );
  }

}

