import 'package:familyarbore/models/events/event_model.dart';
import 'package:familyarbore/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/assets.dart';

class RequestsScreen extends StatefulWidget {
  static String routeName = "/RequestsScreen";

  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {


  final List<EventModel> _event = [

    EventModel(
      id: 0,
      description: "ALi like your Post",
      name: "like",
      eventDate: "2024-12-01 10:18",
      isActive: true,
      family: 1,
      createdAt: "2024-12-01 10:18",
      updatedAt: "2024-12-01 10:18"
    ),

    EventModel(
        id: 0,
        description: "ALi like your Post",
        name: "Invite",
        eventDate: "2024-02-01 10:18",
        isActive: true,
        family: 1,
        createdAt: "2024-12-01 10:18",
        updatedAt: "2024-12-01 10:18"
    ),
    EventModel(
        id: 0,
        description: "ALi like your Post",
        name: "like",
        eventDate: "2024-12-01 15:18",
        isActive: true,
        family: 1,
        createdAt: "2024-12-01 10:18",
        updatedAt: "2024-12-01 10:18"
    )

  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(child: Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            header(width: width, ),

            Expanded(
              flex: 1,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Container(
                      child: Row(

                        children: [

                          SvgPicture.asset(Assets.iconsInfoCircle,
                            width: width * 0.07,
                            height: width * 0.07,
                            color: hintColor,

                          ),
                          
                          Text(_event[index].name.toString())

                        ],

                      ),
                    ),
                  );


              }),
            )
          ],
        ),
      ),
    ));
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
          width: _width * 0.3,
        ),

        Text(
            AppLocalizations.of(context)!.events, // Text displayed on the button
            style: GoogleFonts.rubik().copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: textColor))
      ],
    );


  }
}
