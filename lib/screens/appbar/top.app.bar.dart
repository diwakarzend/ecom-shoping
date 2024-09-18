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
              height: height * .17,
              color: ColorConstants.colorYellowThree,
              padding: EdgeInsets.symmetric(horizontal: width * .018),
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
                    InkWell(
                      onTap: () {
                        context.router.navigate(const ProfileRoute());
                      },
                      child: Text(
                        'Profile',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: Text(
                      'FAQ’s',
                      style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
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
                      style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
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
                          fontWeight: FontWeight.w500,color: Colors.white
                        ),
                      ),
                    ),
                  if (provider.loginDetails == null)
                    const SizedBox(
                      width: 20,
                    ),
                  if (provider.loginDetails != null)
                    Text(
                      'Hello,  ${provider.currentUser?.firstName}',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                          color: Colors.white
                      ),
                    ),
                  if (provider.loginDetails != null) SizedBox(width: width * .01),
                  if (provider.loginDetails != null)
                    const Icon(
                      Icons.waving_hand,
                      color: Color(0xff000000),
                    ),
                  if (provider.loginDetails != null) SizedBox(width: width * .01),
                  if (provider.loginDetails != null)
                    InkWell(
                      onTap: () {
                        showSearch(context: context, delegate: DataSearch());
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  if (provider.loginDetails != null) SizedBox(width: width * .01),
                  if (provider.loginDetails == null)
                    InkWell(
                      onTap: () {
                        context.router.navigate(LoginRoute());
                      },
                      child: Text(
                        'Sign in',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                    ),
                  if (provider.loginDetails == null)
                    const SizedBox(
                      width: 22,
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
                              !provider.currentUser!.orders
                                  .any((e) => e.products.any((o) => o.id == element.product?.id)))
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
                                !provider.currentUser!.orders
                                    .any((e) => e.products.any((o) => o.id == element.product?.id)))
                            .length
                            .toString(),
                        style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.white, fontSize: 8.sp),
                      ),
                      // child: const Icon(
                      //   Icons.notifications_outlined,
                      //   size: 28,
                      // ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     context.router.navigate(const WishlistRoute());
                  //   },
                  //   child: Badge(
                  //     showBadge: provider.wishlist != null && provider.wishlist!.count > 0,
                  //     badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                  //     position: BadgePosition.topEnd(top: -5, end: 0),
                  //     badgeContent: Text(
                  //       provider.wishlist?.count.toString() ?? '',
                  //       style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.white, fontSize: 8.sp),
                  //     ),
                  //     child: const Icon(
                  //       Icons.favorite_outline,
                  //       size: 28,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 15,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     context.router.navigate(const ShoppingTabOneDesktop());
                  //   },
                  //   child: Badge(
                  //     showBadge: (provider.cart?.count ?? 0) > 0,
                  //     badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                  //     position: BadgePosition.topEnd(top: -5, end: 0),
                  //     badgeContent: Text(
                  //       provider.cart?.count.toString() ?? '',
                  //       style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.white, fontSize: 8.sp),
                  //     ),
                  //     child: const Icon(
                  //       Icons.shopping_cart_outlined,
                  //       size: 28,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: _downloadAPK,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                      // Text color
                    ),
                    child: const Text('Download APK'),
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
  const launchUri = 'https://shoppingapps.s3.ap-south-1.amazonaws.com/prestigepayshop1-release.apk';
  await launchUrl(Uri.parse(launchUri));
}
