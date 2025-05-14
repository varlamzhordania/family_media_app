
import 'package:flutter/material.dart';

import '../../components/bottom_nav.dart';



class HomeWrapScreen extends StatefulWidget {
  static String routeName = "/HomeWrapScreen";

  const HomeWrapScreen({super.key});

  @override
  State<HomeWrapScreen> createState() => _HomeWrapScreenState();
}

class _HomeWrapScreenState extends State<HomeWrapScreen> {

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child:

    Scaffold(bottomNavigationBar: BottomNav()));

  }
}
