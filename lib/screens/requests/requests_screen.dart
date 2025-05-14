import 'package:cached_network_image/cached_network_image.dart';
import 'package:familyarbore/models/friendsRequests/friend_model.dart';
import 'package:familyarbore/provider/friend_provider.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/header.dart';
import '../../generated/assets.dart';

class RequestsScreen extends StatefulWidget {
  static String routeName = "/RequestsScreen";
  List<FriendModel>? friendList;

  RequestsScreen({super.key, this.friendList});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  late FriendProvider friendProvider;

  void _refresh() async {
    await friendProvider.getFriendsRequest().then((onValue) {
      setState(() {
        widget.friendList = onValue;
      });
    });
  }

  Future<void> actionFriendRequests(String action, String userId) async {
    await friendProvider.actFriendRequests(action, userId).then((onValue) {
      _refresh();
    });
  }

  @override
  void initState() {
    friendProvider = Provider.of<FriendProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            header(
                width: width,
                checked_pop: false,
                title: AppLocalizations.of(context)!.friendsRequests),
            SizedBox(
              height: height * 0.05,
            ),
            Consumer<FriendProvider>(builder: (context, item, index) {
              return item.is_loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: greyColor,
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: (widget.friendList != null && widget.friendList!.isNotEmpty)
                          ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: widget.friendList != null
                              ? widget.friendList!.length
                              : 0,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.11,
                                          height: width * 0.11,
                                          child: CircleAvatar(
                                            radius: 56,
                                            backgroundColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3),
                                              // Border radius
                                              child: ClipOval(
                                                  child: widget
                                                              .friendList![
                                                                  index]
                                                              .fromUser!
                                                              .avatar ==
                                                          null
                                                      ? Image.asset(
                                                          Assets.imagesUser,
                                                          width: width * 0.1,
                                                          height: width * 0.1,
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl: widget
                                                              .friendList![
                                                                  index]
                                                              .fromUser!
                                                              .avatar
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.friendList![index]
                                                  .fromUser!.fullName
                                                  .toString(),
                                              style: GoogleFonts.rubik()
                                                  .copyWith(
                                                      color: textColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            Text(
                                              "Want add you to Friends",
                                              style: GoogleFonts.rubik()
                                                  .copyWith(
                                                      color: textColorBody,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            actionFriendRequests(
                                                "decline",
                                                widget.friendList![index]
                                                    .fromUser!.id
                                                    .toString());
                                          },
                                          child: Container(
                                            width: 22,
                                            height: 22,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: borderColor,
                                                    width: 1)),
                                            child: const Center(
                                              child: Icon(
                                                Icons.close,
                                                color: btnColor,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.07,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await actionFriendRequests(
                                                "accept",
                                                widget.friendList![index]
                                                    .fromUser!.id
                                                    .toString());
                                          },
                                          child: Container(
                                            width: 22,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              gradient: cardColorBlue,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ));
                          })
                          :
                          SvgPicture.asset(Assets.imagesNoFriedn,)
                    );
            })
          ],
        ),
      ),
    ));
  }
}
