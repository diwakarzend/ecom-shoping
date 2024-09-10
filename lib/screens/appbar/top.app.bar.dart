import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
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
                  ElevatedButton(
                    onPressed: _downloadAPK,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                      // Text color
                      side: WidgetStateProperty.all(const BorderSide(color: Colors.blue, width: 2.0)), // Border
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
  const launchUri = 'https://shoppingapps.s3.ap-south-1.amazonaws.com/agilegames1-release.apk';
  await launchUrl(Uri.parse(launchUri));
}
