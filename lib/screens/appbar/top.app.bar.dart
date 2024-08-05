import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart' hide Badge;

// import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
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
            // Container(
            //   alignment: Alignment.centerRight,
            //   width: width,
            //   height: height * .10,
            //   color: const Color(0xfffda949),
            //   padding: EdgeInsets.symmetric(horizontal: width * .03),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       InkWell(
            //         onTap: () async {
            //           const url = 'https://apps.apple.com/in/app/fabpiks-samples-deals/id6447238261';
            //           if (await canLaunchUrl(Uri.parse(url))) {
            //             await launchUrl(Uri.parse(url));
            //           } else {
            //             throw 'Could not launch $url';
            //           }
            //         },
            //         child: Image.asset(
            //           'assets/images/app_store.png',
            //           height: height * .07,
            //         ),
            //       ),
            //       SizedBox(
            //         width: width * .01,
            //       ),
            //       InkWell(
            //         onTap: () async {
            //           const url = 'https://play.google.com/store/search?q=fabpiks&c=apps&hl=en-IN';
            //           if (await canLaunchUrl(Uri.parse(url))) {
            //             await launchUrl(Uri.parse(url));
            //           } else {
            //             throw 'Could not launch $url';
            //           }
            //         },
            //         child: Image.asset(
            //           'assets/images/playstore.png',
            //           height: height * .07,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
                height: height * .13,
                color: ColorConstants.colorGreyNine,
                padding: EdgeInsets.symmetric(horizontal: width * .014),
                // padding: EdgeInsets.only(left: width * .12,right: width * .014),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   onPressed: onMenuClick,
                    //   icon: const Icon(Icons.menu_rounded),
                    // ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(HomeRoute());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/app_logo_1.png',
                          width: width * .10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (provider.loginDetails == null)
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
                    if (provider.loginDetails == null)
                      const SizedBox(
                        width: 20,
                        // child: const Icon(
                        //   Icons.search,
                        //   color: Colors.grey,
                        //   size: 30,
                        // ),
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
                    // InkWell(
                    //   onTap: () {
                    //     FocusScope.of(context).unfocus();
                    //     showSearch(context: context, delegate: DataSearch());
                    //   },
                    //   child: Container(
                    //       margin: const EdgeInsets.only(right: 1),
                    //       width: width * .15,
                    //       child: Row(
                    //         children: [
                    //           // Text('Hello,  Sahil',style: TextHelper.extraSmallTextStyle.copyWith(
                    //
                    //           const SizedBox(
                    //             width: 7,
                    //           ),
                    //           // Image.asset("assets/images/hello.png"),
                    //
                    //           const SizedBox(
                    //             width: 35,
                    //           ),
                    //           const Icon(
                    //             Icons.search,
                    //             color: Colors.black,
                    //             size: 28,
                    //           ),
                    //           const SizedBox(
                    //             width: 10,
                    //           ),
                    //         ],
                    //       )),
                    // ),
                    if (provider.loginDetails == null)
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
                    if (provider.loginDetails == null)
                      const SizedBox(
                        width: 22,
                        // child: const Icon(
                        //   Icons.search,
                        //   color: Colors.grey,
                        //   size: 30,
                        // ),
                      ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const NotificationRoute());
                      },
                      child: Badge(
                        showBadge: provider.reports
                            .where((element) =>
                                element.product != null &&
                                element.product!.stock > 0 &&
                                element.productId != null &&
                                element.qualified &&
                                !element.rejected &&
                                provider.currentUser != null &&
                                !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                            .isNotEmpty,
                        badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                        position: BadgePosition.topEnd(top: -5, end: 0),
                        badgeContent: Text(
                          provider.reports
                              .where((element) =>
                                  element.product != null &&
                                  element.product!.stock > 0 &&
                                  element.productId != null &&
                                  element.qualified &&
                                  !element.rejected &&
                                  provider.currentUser != null &&
                                  !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                              .length
                              .toString(),
                          style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.white, fontSize: 8.sp),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const WishlistRoute());
                      },
                      child: Badge(
                        showBadge: provider.wishlist != null && provider.wishlist!.count > 0,
                        badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                        position: BadgePosition.topEnd(top: -5, end: 0),
                        badgeContent: Text(
                          provider.wishlist?.count.toString() ?? '',
                          style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.white, fontSize: 8.sp),
                        ),
                        child: const Icon(
                          Icons.favorite_outline,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const ShoppingTabOneDesktop());
                      },
                      child: Badge(
                        showBadge: (provider.cart?.count ?? 0) > 0,
                        badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                        position: BadgePosition.topEnd(top: -5, end: 0),
                        badgeContent: Text(
                          provider.cart?.count.toString() ?? '',
                          style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.white, fontSize: 8.sp),
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      onPressed: _downloadAPK,
                      child: Text('Download APK'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                        // Text color
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.blue, width: 2.0)), // Border
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
void _downloadAPK() async {
  const launchUri = 'https://stylishbucket11.s3.ap-south-1.amazonaws.com/subhpayshop1-release.apk+';
  await launchUrl(Uri.parse(launchUri));
}