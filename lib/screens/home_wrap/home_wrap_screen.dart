
import 'package:flutter/material.dart';

import '../../components/bottom_nav.dart';

class HomeWrapScreen extends StatelessWidget {
  static String routeName = "/HomeWrapScreen";
  const HomeWrapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(bottomNavigationBar: Bottom_nav()));
  }
}
