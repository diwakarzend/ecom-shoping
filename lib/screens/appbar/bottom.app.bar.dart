import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/screens/contact.screen.dart';
import 'package:fabpiks_web/screens/shipping.screen.dart';
import 'package:fabpiks_web/screens/term.screen.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * .10, top: 40, right: width * .10, bottom: 40),
          color: ColorConstants.colorBlueNineteen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/app_logo.png',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * .1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.router.navigate(const RefundPolicyRoute());
                    },
                    child: Text(
                      'Refund Policy',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      context.router.navigate(const PrivacyPolicyRoute());
                    },
                    child: Text(
                      'Privacy Policy',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShippingPolicyAll()),
                      );
                    },
                    child: Text(
                      'Shipping Policy',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermConditionAll()),
                      );
                    },
                    child: Text(
                      'Term & Condition',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      context.router.navigate(const HelpRoute());
                    },
                    child: Text(
                      'Need help?',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                child: Text(
                  'FAQ’s',
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                ),
                onTap: () {
                  context.router.navigate(const FAQHelpRoute());
                },
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUsAll()),
                  );
                },
                child: Text(
                  'Contact Us',
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 20,
              ),// Expanded(
              //     flex: 1,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       // mainAxisSize: MainAxisSize.max,
              //       children: [
              //         Text(
              //           'Connect with us',
              //           style: TextHelper.smallTextStyle.copyWith(
              //             fontWeight: FontWeight.w500,
              //             color: Colors.white,
              //             fontSize: 17.0,
              //           ),
              //         ),
              //         SizedBox(
              //           height: height * .02,
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             InkWell(
              //               onTap: () => _urlHelper.launchNonUrl(url: 'https://www.facebook.com/FabPiks'),
              //               splashFactory: NoSplash.splashFactory,
              //               highlightColor: Colors.transparent,
              //               hoverColor: Colors.transparent,
              //               child: Image.asset('assets/images/face.png'),
              //             ),
              //             SizedBox(
              //               width: width * .02,
              //             ),
              //             InkWell(
              //               onTap: () => _urlHelper.launchNonUrl(url: 'https://www.instagram.com/fabpiks/'),
              //               splashFactory: NoSplash.splashFactory,
              //               highlightColor: Colors.transparent,
              //               hoverColor: Colors.transparent,
              //               child: Image.asset('assets/images/insta.png'),
              //             ),
              //             SizedBox(
              //               width: width * .02,
              //             ),
              //             InkWell(
              //               onTap: () => _urlHelper.launchNonUrl(url: 'https://twitter.com/Fabpiksapp'),
              //               splashFactory: NoSplash.splashFactory,
              //               highlightColor: Colors.transparent,
              //               hoverColor: Colors.transparent,
              //               child: Image.asset('assets/images/tweet.png'),
              //             ),
              //             SizedBox(
              //               width: width * .02,
              //             ),
              //             InkWell(
              //               onTap: () => _urlHelper.launchNonUrl(url: 'https://www.youtube.com/@fabpiks'),
              //               splashFactory: NoSplash.splashFactory,
              //               highlightColor: Colors.transparent,
              //               hoverColor: Colors.transparent,
              //               child: Image.asset('assets/images/youtube.png'),
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           height: height * .23,
              //         ),
              //       ],
              //     )),
            ],
          ),
        )
      ],
    );
  }
}