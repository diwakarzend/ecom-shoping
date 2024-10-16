import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: width * .10, top: 40, right: width * .10, bottom: 40),
          color: const Color(0xff000000),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo_new.png',
                      width: width * .12,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get the latest deals and more.",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Email address",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              onPressed: () {
                                context.router.navigate(SignupRoute(referCode: ''));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 10.0),
                                child: Text("Sign Up",
                                  style: TextStyle(
                                      color: Colors.white),),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          "© 2024 Swachh Life Private Limited.\nAll Rights Reserved.",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * .1,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      child: Text(
                        'FAQ’s',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onTap: () {
                        context.router.navigate(const FAQHelpRoute());
                      },
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const RefundPolicyRoute());
                      },
                      child: Text(
                        'Refund Policy',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const PrivacyPolicyRoute());
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const HelpRoute());
                      },
                      child: Text(
                        'Need help?',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const ProfileRoute());
                      },
                      child: Text(
                        'Profile',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
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
              // SizedBox(
              //   width: width * .1,
              // ),
              Expanded(
                flex: 1,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Us",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Swachh Life Private Limited\nUnit No. 1012, Pearls Omaxe Tower,\nNetaji Subhash Place, Delhi-110034",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Email: royal.swachhlifeprivatelimited@gmail.com",
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "Phone: 8859115770",
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "GSTIN: 08CVHPAB746H1ZC",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
