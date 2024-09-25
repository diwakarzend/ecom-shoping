import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
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
              color: Color(0xffffdccb),
              padding: EdgeInsets.symmetric(horizontal: width * .018),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      width: width * .10,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     if (provider.loginDetails == null)
                  //
                  //   ],
                  // ),
                  Row(
                    children: [
                      if (provider.loginDetails != null)
                        InkWell(
                          onTap: () {
                            showSearch(
                                context: context, delegate: DataSearch());
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          context.router.navigate(HomeRoute());
                        },
                        child: Text(
                          'Home',
                          style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          context.router.navigate(const ProfileRoute());
                        },
                        child: Text(
                          'Profile',
                          style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          context.router.navigate(const FAQHelpRoute());
                        },
                        child: Text(
                          'Faq’s',
                          style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUsAll()),
                          );
                        },
                        child: Text(
                          'Contact Us',
                          style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
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
                                  !provider.currentUser!.orders.any((e) => e
                                      .products
                                      .any((o) => o.id == element.product?.id)))
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
                                    !provider.currentUser!.orders.any((e) =>
                                        e.products.any((o) =>
                                            o.id == element.product?.id)))
                                .length
                                .toString(),
                            style: TextHelper.extraSmallTextStyle
                                .copyWith(color: Colors.white, fontSize: 8.sp),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                          onTap: () {
                            context.router.navigate(LoginRoute());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffEE2128),
                              border: Border.all(color: Color(0xffEE2128)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            child: Text(
                              'Login',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const SizedBox(width: 20),
                      InkWell(
                          onTap: () {
                            provider.changeLoginStatus(false, null, '', '', '');
                            context.router.navigate(SignupRoute(referCode: ''));
                          },
                          splashColor: Colors.blue.withOpacity(0.3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffEE2128),
                              border: Border.all(color: Color(0xffEE2128)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            child: Text(
                              'Sign Up',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const SizedBox(width: 15),
                    ],
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
