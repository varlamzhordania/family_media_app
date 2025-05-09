// Create a separate StatefulWidget for the comments modal
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../generated/assets.dart';
import '../models/comments/comments_model.dart';
import '../provider/post_provider.dart';
import '../utils/theme_colors.dart';

class CommentsModal extends StatefulWidget {
  final int postId;
  final double height;
  final double width;

  const CommentsModal({
    Key? key,
    required this.postId,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  _CommentsModalState createState() => _CommentsModalState();
}

class _CommentsModalState extends State<CommentsModal> {
  PagingState<int, Comments> _state = PagingState();
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();
  late PostProvider postProvider;

  @override
  void initState() {
    super.initState();
    postProvider = Provider.of<PostProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchNextPageComments();
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  void _fetchNextPageComments() async {
    if (_state.isLoading) return;


    setState(() {
      _state = _state.reset();
    });

    setState(() {
      _state = _state.copyWith(isLoading: true, error: null,
      );
    });

    try {
      final newKey = (_state.keys?.last ?? 0) + 1;
      final newItems = await postProvider.getCommentsPost(newKey, widget.postId);

      final isLastPage = postProvider.is_lastPage_comment;

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


  void _addComments() async {
    if (_state.isLoading) return;

    if(commentController.text.isNotEmpty){

      try {

        debugPrint("postid: ${widget.postId}");

        await postProvider.addCommentsPost({"post_id": widget.postId,"text": commentController.text.toString()}).then((onValue){
          _fetchNextPageComments();

        });



      } catch (error) {
        Fluttertoast.showToast(msg: error.toString());

      }finally{
        commentController.clear();
      }
    }else{
      Fluttertoast.showToast(msg: "write you comment");
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: commentFocusNode.hasFocus ? widget.height * 0.7 : widget.height * 0.4,
        color: Colors.transparent,
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  // Show loading indicator while data is being fetched
                  if (_state.isLoading && (_state.pages == null || _state.pages!.isEmpty))
                    const Center(child: CircularProgressIndicator())
                  else
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, widget.height * 0.1),
                      child: PagedListView<int, Comments>(
                        state: _state,
                        fetchNextPage: _fetchNextPageComments,
                        builderDelegate: PagedChildBuilderDelegate(
                          itemBuilder: (context, item, index) {
                            return ListTile(
                              leading: SizedBox(
                                width: widget.width * 0.08,
                                height: widget.width * 0.08,
                                child: CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.white.withOpacity(0.5),
                                  child: ClipOval(
                                      child: item.author!.member!.avatar != null
                                          ? CachedNetworkImage(
                                        imageUrl: item.author!.member!.avatar.toString(),
                                        width: widget.width * 0.1,
                                        height: widget.width * 0.1,
                                      )
                                          : Image.asset(
                                        Assets.imagesFile,
                                        width: widget.width * 0.1,
                                        height: widget.width * 0.1,
                                      )
                                  ),
                                ),
                              ),
                              title: Text.rich(
                                TextSpan(
                                    text: item.author!.member!.fullName,
                                    style: GoogleFonts.rubik().copyWith(
                                        color: textColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600
                                    ),
                                    children: [
                                      WidgetSpan(
                                          child: SizedBox(
                                            width: widget.width * 0.01,
                                          )
                                      ),
                                      TextSpan(
                                          text: item.text,
                                          style: GoogleFonts.rubik().copyWith(
                                              color: textColorBody,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400
                                          )
                                      )
                                    ]
                                ),
                              ),
                            );
                          },
                          noItemsFoundIndicatorBuilder: (_) => Center(
                            child: Text('No comments yet'),
                          ),
                          firstPageErrorIndicatorBuilder: (_) => Center(
                            child: Text('Error loading comments. Tap to retry.'),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: commentFocusNode.hasFocus ? widget.height * 0.34 : 5,
                    left: 1,
                    right: 1,
                    child: Container(
                      color: backgroundColor,
                      height: widget.height * 0.06,
                      child: TextField(
                        focusNode: commentFocusNode,
                        keyboardType: TextInputType.text,
                        controller: commentController,
                        style: GoogleFonts.rubik().copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: textColorBody
                        ),
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _addComments();
                              },
                              child: SvgPicture.asset(
                                width: 10,
                                height: 10,
                                fit: BoxFit.scaleDown,
                                Assets.iconsSend2,
                                semanticsLabel: 'send icon',
                                color: btnColor,
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
                            hintText: 'Add a comment...',
                            hintStyle: GoogleFonts.rubik().copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: hintColor
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}

// Modified function to show the modal
Future<dynamic> buildShowModalBottomSheetComments(
    BuildContext context, double height, double width, int postId) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return CommentsModal(
          postId: postId,
          height: height,
          width: width,
        );
      }
  );
}
