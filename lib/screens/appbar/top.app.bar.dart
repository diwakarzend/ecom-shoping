import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/helpers/text.helper.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
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
              color: const Color(0xff0071DC),
              padding: EdgeInsets.symmetric(horizontal: width * .018),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        context.router.navigate(HomeRoute());
                      },
                      child: Image.asset(
                        'assets/images/logo_new.png',
                        width: width * .10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search everything at Swachh Life',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.orange),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                  ),
                  Row(
                    children: [
                      // if (provider.loginDetails != null)
                      //   InkWell(
                      //     onTap: () {
                      //       showSearch(context: context, delegate: DataSearch());
                      //     },
                      //     child: const Icon(
                      //       Icons.search,
                      //       color: Colors.black,
                      //       size: 28,
                      //     ),
                      //   ),
                      // const SizedBox(width: 15),
                      //
                      // // Notification Badge
                      // InkWell(
                      //   onTap: () {
                      //     context.router.navigate(const NotificationRoute());
                      //   },
                      //   child: Badge(
                      //     showBadge: provider.reports
                      //         .where((element) =>
                      //     element.product != null &&
                      //         element.product!.stock > 0 &&
                      //         element.productId != null &&
                      //         element.qualified &&
                      //         !element.rejected &&
                      //         provider.currentUser != null &&
                      //         !provider.currentUser!.orders.any(
                      //                 (e) => e.products
                      //                 .any((o) => o.id == element.product?.id)))
                      //         .isNotEmpty,
                      //     badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                      //     position: BadgePosition.topEnd(top: -5, end: 0),
                      //     badgeContent: Text(
                      //       provider.reports
                      //           .where((element) =>
                      //       element.product != null &&
                      //           element.product!.stock > 0 &&
                      //           element.productId != null &&
                      //           element.qualified &&
                      //           !element.rejected &&
                      //           provider.currentUser != null &&
                      //           !provider.currentUser!.orders.any((e) => e.products
                      //               .any((o) => o.id == element.product?.id)))
                      //           .length
                      //           .toString(),
                      //       style: TextHelper.extraSmallTextStyle
                      //           .copyWith(color: Colors.white, fontSize: 8.sp),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 20),

                      // Login / SignUp
                      if (provider.loginDetails == null)
                        InkWell(
                          onTap: () {
                            context.router.navigate(LoginRoute());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            child: Text(
                              'Login',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      InkWell(
                        onTap: () {
                          provider.changeLoginStatus(false, null, '', '', '');
                          context.router.navigate( SignupRoute(referCode: ''));
                        },
                        splashColor: Colors.blue.withOpacity(0.3),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          child: Text(
                            'Sign Up',
                            style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),

                      ElevatedButton.icon(
                        onPressed: _downloadAPK,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          backgroundColor: const Color(0xffF4A51C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: const Icon(Icons.android, color: Colors.white, size: 24),
                        label: const Text(
                          'Download APK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
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

  // Function to download the APK
  void _downloadAPK() async {
    const launchUri =
        'https://shoppingapps.s3.ap-south-1.amazonaws.com/-release.apk';
    if (await canLaunch(launchUri)) {
      await launch(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}
