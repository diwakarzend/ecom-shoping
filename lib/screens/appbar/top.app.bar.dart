import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/contact.screen.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/router.gr.dart';
import '../../widgets/data.search.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Column(
          children: [
            Container(
              height: height * .13,
              color: ColorConstants.colorBlueNineteen,
              padding: EdgeInsets.symmetric(horizontal: width * .014),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.router.navigate(HomeRoute());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        width: width * .10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 160,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context.router.navigate(const ProfileRoute());
                          },
                          child: Text(
                            'Profile',
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          child: Text(
                            'FAQ’s',
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.black),
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
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            context.router.navigate(LoginRoute());
                          },
                          child: Text(
                            'Sign in',
                            style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            provider.changeLoginStatus(false, null, '', '', '');
                            context.router.navigate(SignupRoute(referCode: ''));
                          },
                          child: Text(
                            'Sign up',
                            style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: _downloadAPK,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Download APK',
                          style: TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

void _downloadAPK() async {
  const launchUri = 'https://shoppingapps.s3.ap-south-1.amazonaws.com/amanapay1-release.apk';
  await launchUrl(Uri.parse(launchUri));
}
