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
                  const Spacer(),
                  if (provider.loginDetails == null)
                    PopupMenuButton(
                      icon: Icon(Icons.account_circle, color: Colors.black, size: 28),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'signin',
                          child: Text('Sign in'),
                        ),
                        PopupMenuItem(
                          value: 'signup',
                          child: Text('Sign up'),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'signin') {
                          context.router.navigate(LoginRoute());
                        } else if (value == 'signup') {
                          provider.changeLoginStatus(false, null, '', '', '');
                          context.router.navigate(SignupRoute(referCode: ''));
                        }
                      },
                    ),
                  if (provider.loginDetails != null)
                    Text(
                      'Hello,  ${provider.currentUser?.firstName}',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: ColorConstants.colorBlack,
                      ),
                    ),
                  if (provider.loginDetails != null) SizedBox(width: width * .01),
                  if (provider.loginDetails != null)
                    const Icon(
                      Icons.waving_hand,
                      color: Color(0xfffd9846),
                    ),
                  if (provider.loginDetails != null) SizedBox(width: width * .01),
                  if (provider.loginDetails != null)
                    InkWell(
                      onTap: () {
                        showSearch(context: context, delegate: DataSearch());
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  if (provider.loginDetails != null) SizedBox(width: width * .01),
                  TextButton(
                    onPressed: _downloadAPK,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'Download APP',
                          style: TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
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
  const launchUri = 'https://shoppingapps.s3.ap-south-1.amazonaws.com/agilegames1-release.apk';
  await launchUrl(Uri.parse(launchUri));
}