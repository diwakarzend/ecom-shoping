/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/brand.products.screen.dart';
import 'package:fabpiks_web/screens/deals.screen.dart';
import 'package:fabpiks_web/screens/home.screen.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'trail.screen.dart';

@RoutePage(name: 'NavigatorRoute')
class NavigatorScreen extends StatefulWidget {
  final bool orderSuccess;
  final Order? order;

  const NavigatorScreen({
    super.key,
    this.orderSuccess = false,
    this.order,
  });

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  bool supportExpanded = false;

  final CartHelper _cartHelper = CartHelper();

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  bool popupOpenedTwo = false;

  void _downloadAPK() async {
    const launchUri = 'https://shoppingapps.s3.ap-south-1.amazonaws.com/prestigepayshop1-release.apk';
    await launchUrl(Uri.parse(launchUri));
  }

  @override
  void initState() {
    // updateAvailable(_appProvider);
    if (widget.orderSuccess && widget.order != null) {
      BuildContext? dialogContext;
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          if (mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (c) {
                dialogContext = c;

                return _OrderDialog(
                  orderId: widget.order?.orderNumber ?? '',
                  onRate: () async {},
                  onCancel: () {
                    dialogContext?.maybePop();
                  },
                );
              },
            );
          }
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        // return PopScope(
        //   onPopInvoked: (v) => _willPopScope(provider),
        //child:
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: provider.appLoading
              ? const _LoadingScreen()
              : provider.appSettings != null &&
                      provider.appSettings!.maintenance.mode &&
                      !provider.appSettings!.maintenance.showOld
                  ? _MaintenanceScreen(provider: provider)
                  : Scaffold(
                      key: _key,
                      extendBody: true,
                      appBar: AppBar(
                        backgroundColor: ColorConstants.colorGreyTwentyFour,
                        automaticallyImplyLeading: false,
                        elevation: 0,
                        leading: Builder(
                          builder: (context) {
                            return IconButton(
                              icon: const Icon(Ionicons.person_outline),
                              color: ColorConstants.colorBlackThree,
                              iconSize: 30,
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          },
                        ),
                        titleSpacing: 0,
                        title: Image.asset(
                          'assets/images/fab_logo.png',
                          height: height * .04,
                        ),
                        centerTitle: false,
                        actions: [
                          IconButton(
                            onPressed: () {
                              context.router.push(const NotificationRoute());
                            },
                            color: ColorConstants.colorBlackThree,
                            iconSize: 35,
                            icon: Badge(
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
                                style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                              ),
                              child: const Icon(
                                Ionicons.notifications_outline,
                                size: 30,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.router.push(const CartRoute());
                            },
                            color: ColorConstants.colorBlackThree,
                            iconSize: 35,
                            icon: Badge(
                              showBadge: (provider.cart?.count ?? 0) > 0,
                              badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                              position: BadgePosition.topEnd(top: 0, end: 0),
                              badgeContent: Text(
                                provider.cart?.count.toString() ?? '',
                                style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                              ),
                              child: const Icon(
                                Ionicons.cart_outline,
                                size: 30,
                              ),
                            ),
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
                      body: IndexedStack(
                        index: provider.activeIndex,
                        children: const [
                          HomeScreen(),
                          TrialScreen(),
                          DealsScreen(),
                          BrandProductScreen(),
                        ],
                      ),
                      bottomNavigationBar: Container(
                        width: width,
                        height: height * .07 + MediaQuery.of(context).padding.bottom + 10,
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: ColorConstants.colorBottomNavigation,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NavItem(
                              icon: ImageIcon(
                                const AssetImage('assets/images/icons/home.png'),
                                size: 27,
                                color:
                                    provider.activeIndex == 0 ? ColorConstants.colorBlueTen : ColorConstants.colorBlack,
                              ),
                              name: NavLabel(
                                text: 'Home',
                                gradient: LinearGradient(
                                  colors: provider.activeIndex == 0
                                      ? [
                                          ColorConstants.colorBlueFour,
                                          ColorConstants.colorBlueFour,
                                        ]
                                      : [
                                          ColorConstants.colorGreyFourteen,
                                          ColorConstants.colorGreyFourteen,
                                        ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              onTap: () {
                                provider.changeIndex(0);
                                // tabsRouter.setActiveIndex(0);
                              },
                            ),
                            // NavItem(
                            //   icon: ImageIcon(
                            //     const AssetImage('assets/images/icons/mini.png'),
                            //     size: 28,
                            //     color:
                            //         provider.activeIndex == 1 ? ColorConstants.colorBlueTen : ColorConstants.colorBlack,
                            //   ),
                            //   name: NavLabel(
                            //     text: 'Shop Minis',
                            //     gradient: LinearGradient(
                            //       colors: provider.activeIndex == 1
                            //           ? [
                            //               ColorConstants.colorBlueFour,
                            //               ColorConstants.colorBlueFour,
                            //             ]
                            //           : [
                            //               ColorConstants.colorGreyFourteen,
                            //               ColorConstants.colorGreyFourteen,
                            //             ],
                            //       begin: Alignment.centerLeft,
                            //       end: Alignment.centerRight,
                            //     ),
                            //   ),
                            //   onTap: () {
                            //     provider.changeIndex(1);
                            //     // provider.changeActiveIndex(1);
                            //   },
                            // ),
                            NavItem(
                              icon: ImageIcon(
                                const AssetImage('assets/images/icons/deal.png'),
                                size: 28,
                                color:
                                    provider.activeIndex == 1 ? ColorConstants.colorBlueTen : ColorConstants.colorBlack,
                              ),
                              name: NavLabel(
                                text: 'Clothe',
                                gradient: LinearGradient(
                                  colors: provider.activeIndex == 1
                                      ? [
                                          ColorConstants.colorBlueFour,
                                          ColorConstants.colorBlueFour,
                                        ]
                                      : [
                                          ColorConstants.colorGreyFourteen,
                                          ColorConstants.colorGreyFourteen,
                                        ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              onTap: () {
                                // provider.changeActiveIndex(2);
                                provider.changeIndex(2);
                              },
                            ),
                            // NavItem(
                            //   icon: ImageIcon(
                            //     const AssetImage('assets/images/icons/sample.png'),
                            //     size: 28,
                            //     color:
                            //         provider.activeIndex == 3 ? ColorConstants.colorBlueTen : ColorConstants.colorBlack,
                            //   ),
                            //   name: NavLabel(
                            //     text: 'Free Samples',
                            //     gradient: LinearGradient(
                            //       colors: provider.activeIndex == 3
                            //           ? [
                            //               ColorConstants.colorBlueFour,
                            //               ColorConstants.colorBlueFour,
                            //             ]
                            //           : [
                            //               ColorConstants.colorGreyFourteen,
                            //               ColorConstants.colorGreyFourteen,
                            //             ],
                            //       begin: Alignment.centerLeft,
                            //       end: Alignment.centerRight,
                            //     ),
                            //   ),
                            //   onTap: () {
                            //     // provider.changeActiveIndex(4);
                            //     provider.changeIndex(3);
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      drawer: CustomDrawer(
                        provider: provider,
                        onSupportExtend: () {
                          setState(() {
                            supportExpanded = !supportExpanded;
                          });
                        },
                        supportExpanded: supportExpanded,
                        cartHelper: _cartHelper,
                      ),
                      floatingActionButton: provider.activeIndex == 1
                          ? InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  // barrierColor: Colors.white.withOpacity(0.8),
                                  isScrollControlled: true,
                                  builder: (c) => InkWell(
                                    onTap: () => context.router.maybePopTop(),
                                    child: _TrialDialog(appProvider: provider),
                                  ),
                                );
                              },
                              splashFactory: NoSplash.splashFactory,
                              highlightColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/info_icon.png',
                                // width: 50,
                                height: 70,
                              ),
                            )
                          : provider.activeIndex == 3
                              ? InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      // barrierColor: Colors.white.withOpacity(0.8),
                                      isScrollControlled: true,
                                      builder: (c) => InkWell(
                                        onTap: () => context.router.maybePopTop(),
                                        child: _BrandDialog(appProvider: provider),
                                      ),
                                    );
                                  },
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  child: Image.asset(
                                    'assets/images/info_icon.png',
                                    // width: 50,
                                    height: 70,
                                  ),
                                )
                              : null,
                    ),
        );
        // );
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: Colors.white,
      child: Lottie.asset(
        'assets/animations/loader.json',
        width: width * .7,
      ),
    );
  }
}

class _MaintenanceScreen extends StatelessWidget {
  final AppProvider provider;

  const _MaintenanceScreen({required this.provider});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/maintenance.json',
            width: width * .7,
          ),
          SizedBox(height: height * .02),
          Text(
            provider.appSettings!.maintenance.msg,
            maxLines: 50,
            textAlign: TextAlign.center,
            style: TextHelper.normalTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

class _OrderDialog extends StatelessWidget {
  final String orderId;
  final Function() onRate;
  final Function() onCancel;

  const _OrderDialog({
    required this.orderId,
    required this.onRate,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Material(
        borderOnForeground: false,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 3,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * .02),
              SvgPicture.asset(
                'assets/images/icons/like.icon.svg',
                width: width * .1,
              ),
              SizedBox(height: height * .02),
              Text(
                'Thanks for your order!',
                style: TextHelper.normalTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.colorBlackTwo,
                ),
              ),
              SizedBox(height: height * .02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'we’re getting your order ( #$orderId ) ready & shall notify you when it’s dispatched.',
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextHelper.smallTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.colorBlackTwo,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: height * .02),
                decoration: const BoxDecoration(
                  color: ColorConstants.colorRatingPopup,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your opinion matters to us!',
                      style: TextHelper.normalTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.colorBlackTwo,
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      'Rate your app experience',
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.colorBlackTwo,
                      ),
                    ),
                    SizedBox(height: height * .02),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, _) => const Icon(
                        Ionicons.star,
                        color: ColorConstants.colorStar,
                      ),
                      onRatingUpdate: (rating) {
                        debugPrint(rating.toString());
                      },
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        maxLines: 5,
                        minLines: 3,
                        style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorBlackTwo),
                        decoration: InputDecoration(
                          hintText: 'Leave a message, if you want',
                          hintStyle: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorBlackTwo),
                          fillColor: Colors.white,
                          isDense: true,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .02),
                    InkWell(
                      onTap: onRate,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.colorBlueSeventeen,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          'Rate now',
                          style: TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .02),
                  ],
                ),
              ),
              SizedBox(height: height * .02),
              InkWell(
                onTap: onCancel,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text(
                    'Maybe Later',
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.colorTextLater,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * .02),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrialDialog extends StatelessWidget {
  final AppProvider appProvider;

  const _TrialDialog({required this.appProvider});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => context.router.maybePopTop(),
      child: Center(
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: ColorConstants.colorHIWPopup,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ColorConstants.colorBlackTwo.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * .02),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.colorBlueSeventeen,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Shop Minis',
                  style: TextHelper.normalTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Text.rich(
                TextSpan(
                  text: 'How its ',
                  children: [
                    TextSpan(
                      text: 'Work?',
                      style: TextHelper.titleStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.colorBlackTwo,
                      ),
                    ),
                  ],
                ),
                style: TextHelper.titleStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.colorBlackTwo,
                ),
              ),
              SizedBox(height: height * .01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  TextSpan(
                    text:
                        'Buy Any ${appProvider.appSettings?.generalSettings.itemQty} Products At Just Rs.${appProvider.appSettings?.generalSettings.miniCharge}',
                    children: [
                      TextSpan(
                        text: ' (Inclusive GST)',
                        style: TextHelper.smallTextStyle.copyWith(
                          color: ColorConstants.colorBlackTwo,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextHelper.titleStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.colorBlackTwo,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorConstants.colorBlackTwo.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorConstants.colorHIWPopupTwo,
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: Text(
                                  'STEP 1',
                                  style: TextHelper.smallTextStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * .02),
                              Image.asset('assets/images/step1.png', height: height * .07),
                              SizedBox(height: height * .02),
                              Text(
                                'Select any ${appProvider.appSettings?.generalSettings.itemQty} products from shop mini page',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.colorBlackTwo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorConstants.colorHIWPopupTwo,
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: Text(
                                  'STEP 2',
                                  style: TextHelper.smallTextStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * .02),
                              Image.asset('assets/images/step2.png', height: height * .07),
                              SizedBox(height: height * .02),
                              Text(
                                'Go to your cart',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.colorBlackTwo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorConstants.colorHIWPopupTwo,
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: Text(
                                  'STEP 3',
                                  style: TextHelper.smallTextStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * .02),
                              Image.asset('assets/images/step3.png', height: height * .07),
                              SizedBox(height: height * .02),
                              Text(
                                'Checkout for Rs.${appProvider.appSettings?.generalSettings.miniCharge} only',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.colorBlackTwo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      'Add minimum ${appProvider.appSettings?.generalSettings.itemQty} products to activate cart, add ‘ upto ${appProvider.appSettings?.generalSettings.addonQty} more products at ${appProvider.appSettings?.generalSettings.addonUnitPrice} Rs each.',
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.colorBlackTwo,
                      ),
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      'You can Pay online to save COD charge Rs.${(appProvider.appSettings?.generalSettings.codCharge ?? 0)}',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.colorBlueTwentyOne,
                      ),
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandDialog extends StatelessWidget {
  final AppProvider appProvider;

  const _BrandDialog({required this.appProvider});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => context.router.maybePopTop(),
      child: Center(
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: ColorConstants.colorHIWPopup,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ColorConstants.colorBlackTwo.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * .02),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.colorBlueSeventeen,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Free Samples',
                  style: TextHelper.normalTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Text.rich(
                TextSpan(
                  text: 'How its ',
                  children: [
                    TextSpan(
                      text: 'Work?',
                      style: TextHelper.titleStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.colorBlackTwo,
                      ),
                    ),
                  ],
                ),
                style: TextHelper.titleStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.colorBlackTwo,
                ),
              ),
              SizedBox(height: height * .01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  const TextSpan(
                    text: 'Enjoying free samples by Only paying  delivery charge ',
                  ),
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextHelper.titleStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.colorBlackTwo,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorConstants.colorBlackTwo.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/brand1.png'),
                              SizedBox(height: height * .02),
                              Text(
                                'Browse products',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.colorBlackTwo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, height * .02, 5, 0),
                          child: const Icon(Icons.arrow_forward_ios, size: 17),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/brand2.png'),
                              SizedBox(height: height * .02),
                              Text(
                                'Fill Sample questionaire',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.colorBlackTwo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, height * .02, 5, 0),
                          child: const Icon(Icons.arrow_forward_ios, size: 17),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/bran3.png'),
                              SizedBox(height: height * .02),
                              Text(
                                'Get shortlisted',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.colorBlackTwo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, height * .02, 5, 0),
                          child: const Icon(Icons.arrow_forward_ios, size: 17),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/brand4.png'),
                              SizedBox(height: height * .02),
                              Text(
                                'Secure checkout & delivery ',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.colorBlackTwo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      'Apply for any free samples of your choice get qualified and pay only delivery charge. ',
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.colorBlackTwo,
                      ),
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      'No COD, only online payment',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.colorBlueTwentyOne,
                      ),
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
