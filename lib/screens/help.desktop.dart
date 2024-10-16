import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';

class HelpScreenDesktop extends StatefulWidget {
  const HelpScreenDesktop({super.key});

  @override
  State<HelpScreenDesktop> createState() => _HelpScreenDesktopState();
}

class _HelpScreenDesktopState extends State<HelpScreenDesktop> {
  late UrlHelper _urlHelper;

  @override
  void initState() {
    _urlHelper = UrlHelper.internal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const TopAppBar(),
            Container(
              padding: EdgeInsets.only(top: height * .10, left: width * .13),
              width: width,
              height: height * .20,
              color: const Color(0xff030d4e),
              child: const Text(
                'Need help with any issue',
                style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    padding: EdgeInsets.only(left: width * .13),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      top: height * .03,
                    ),
                    height: height * .06,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Please, select the request type:',
                      style: TextStyle(fontSize: 14.0, color: Colors.black, letterSpacing: 1.0, fontFamily: 'Montserrat'),
                    )),
                Container(
                    padding: EdgeInsets.only(left: width * .01),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: width * .13, top: height * .02, right: width * .6, bottom: height * .03),
                    height: height * .06,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8A01C),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.router.push(const OrderHelpRoute());
                      },
                      child: const Text(
                        'I have an issue with an order',
                        style: TextStyle(fontSize: 14.0, color: Colors.black, letterSpacing: 1.0, fontFamily: 'Montserrat'),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(left: width * .01),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: width * .13, right: width * .6, bottom: height * .03),
                    height: height * .06,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8A01C),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.router.push(const OrderHelpRoute());
                      },
                      child: const Text(
                        "I'm experiencing a technical issue",
                        style: TextStyle(fontSize: 14.0, color: Colors.black, letterSpacing: 1.0, fontFamily: 'Montserrat'),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(left: width * .01),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: width * .13, right: width * .53, bottom: height * .03),
                    height: height * .06,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8A01C),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.router.push(const OrderHelpRoute());
                      },
                      child: const Text(
                        "I have a question that wasn't answered in the FAQs",
                        style: TextStyle(fontSize: 14.0, color: Colors.black, letterSpacing: 1.0, fontFamily: 'Montserrat'),
                      ),
                    )),
                SizedBox(
                  height: height * .08,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: height * .05),
                    alignment: Alignment.center,
                    width: width,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xffF8A01C),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Still Need Help?',
                          style: TextStyle(fontSize: 23.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        const Text(
                          'Reach out to the swacchLife support team',
                          style: TextStyle(fontSize: 13.0, color: Colors.white, fontFamily: 'Montserrat', letterSpacing: 1),
                        ),
                        InkWell(
                          onTap: () => _urlHelper.launchNonUrl(url: 'tel:+917838717985'),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width * .03, vertical: height * .007),
                            margin: EdgeInsets.symmetric(vertical: height * .04),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Call Now'),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const BottomAppBarPage(),
          ],
        ),
      ),
    );
  }
}
