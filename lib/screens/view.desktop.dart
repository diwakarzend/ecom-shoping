import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';

class ViewProductDesktop extends StatefulWidget {
  const ViewProductDesktop({super.key});

  @override
  State<ViewProductDesktop> createState() => _ViewProductDesktopState();
}

class _ViewProductDesktopState extends State<ViewProductDesktop> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TopAppBar(),
            Column(
              children: [
                Container(margin: EdgeInsets.symmetric(vertical: height * .03, horizontal: width * .04), child: Image.asset('assets/images/view1.png')),
                Container(margin: EdgeInsets.symmetric(vertical: height * .03, horizontal: width * .04), child: Image.asset('assets/images/view3.png')),
                Container(margin: EdgeInsets.symmetric(vertical: height * .03, horizontal: width * .04), child: Image.asset('assets/images/view4.png')),
                Container(margin: EdgeInsets.symmetric(vertical: height * .03, horizontal: width * .04), child: Image.asset('assets/images/view5.png')),
                Container(margin: EdgeInsets.symmetric(vertical: height * .03, horizontal: width * .04), child: Image.asset('assets/images/view6.png')),
              ],
            ),
            const BottomAppBarPage(),
          ],
        ),
      ),
    );
  }
}
