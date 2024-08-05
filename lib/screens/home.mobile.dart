/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/vendy.screen.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// @RoutePage(name: 'HomeRoute')
class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  int trialIndex = 0, dealIndex = 0, sampleIndex = 0;

  final CartHelper _cartHelper = CartHelper();

  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //
  // VendyCity? selectedCity;
  // VendyCityAddress? selectedAddress;
  //
  // vendingAction(AppProvider provider, String result) async {
  //   if (provider.currentUser != null) {
  //     LatLng? initPos;
  //     bool serviceEnabled;
  //     LocationPermission permission;
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       log('Location permissions are disabled', name: 'location_log');
  //       if (!mounted) return;
  //       showDialog(
  //         context: context,
  //         builder: (c) => AlertDialog(
  //           title: const Text('Enable location service'),
  //           content: const Text('For a better experience, turn on device location, which uses Googles location service.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Geolocator.openLocationSettings();
  //                 c.router.pop();
  //               },
  //               child: const Text('Enable Location'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 c.router.pop();
  //               },
  //               child: const Text('No Thanks'),
  //             ),
  //           ],
  //         ),
  //       );
  //       return Future.error('Location services are disabled.');
  //     } else {
  //       permission = await Geolocator.checkPermission();
  //       if (permission == LocationPermission.denied) {
  //         permission = await Geolocator.requestPermission();
  //         if (permission == LocationPermission.denied) {
  //           log('Location permissions are denied');
  //           return Future.error('Location permissions are denied');
  //         }
  //       }
  //       if (permission == LocationPermission.deniedForever) {
  //         return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //       }
  //       Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.best,
  //       );
  //       initPos = LatLng(position.latitude, position.longitude);
  //       final url =
  //           '$result?latitude=${initPos.latitude}&longitude=${initPos.longitude}&device_id=$deviceId&phone_no=${provider.currentUser?.mobileNo}&email=${provider.currentUser?.email}&name=${provider.currentUser?.firstName}&age=${provider.currentUser?.age}&gender=${provider.currentUser?.gender}';
  //       log(url);
  //       _urlHelper.launchNonUrl(url: url).then(
  //         (_) {
  //           if (!mounted) return;
  //           Future.delayed(const Duration(milliseconds: 0)).then(
  //             (_) {
  //               context.router.popUntilRouteWithName(NavigatorRoute.name);
  //             },
  //           );
  //         },
  //       );
  //     }
  //   }
  // }
  //
  // String? deviceId;
  //
  // intPackage() async {
  //   deviceId = await UniqueIdentifier.serial;
  // }
  //
  final DioHelper _dioHelper = DioHelper();
  //
  // Future updateSource(AppProvider provider) async {
  //   await _dioHelper.post(
  //     'user/${provider.loginDetails?.uId}',
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     ),
  //     data: {
  //       'source': 'vendy',
  //     },
  //   );
  // }

  Future updateSource(AppProvider provider) async {
    await _dioHelper.post(
      'user/${provider.loginDetails?.uId}',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'source': 'vendy',
      },
    );
  }

  @override
  void initState() {
    // intPackage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * .03),
                  // SizedBox(
                  //   height: width * .3,
                  //   width: width,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     primary: false,
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: provider.categories.length + 1,
                  //     physics: const BouncingScrollPhysics(),
                  //     padding: const EdgeInsets.only(left: 20),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       if (index == 0) {
                  //         return InkWell(
                  //           onTap: () {
                  //             context.router.navigate(const CategoryRoute());
                  //           },
                  //           splashFactory: NoSplash.splashFactory,
                  //           highlightColor: Colors.transparent,
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               // Container(
                  //               //   margin: const EdgeInsets.symmetric(horizontal: 5),
                  //               //   width: width * .15,
                  //               //   height: width * .15,
                  //               //   decoration: BoxDecoration(
                  //               //     color: ColorConstants.colorBlueEighteen,
                  //               //     shape: BoxShape.circle,
                  //               //     boxShadow: [
                  //               //       BoxShadow(
                  //               //         color: Colors.black.withOpacity(0.1),
                  //               //         blurRadius: 15,
                  //               //         offset: const Offset(0, 4),
                  //               //       ),
                  //               //     ],
                  //               //   ),
                  //               //   alignment: Alignment.center,
                  //               //   child: const FittedBox(
                  //               //     child: Icon(
                  //               //       Ionicons.grid,
                  //               //       color: Colors.white,
                  //               //       size: 30,
                  //               //     ),
                  //               //   ),
                  //               // ),
                  //               // const SizedBox(height: 10),
                  //               // Text(
                  //               //   'View All',
                  //               //   style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w600, color: ColorConstants.colorGreyThree),
                  //               // ),
                  //             ],
                  //           ),
                  //         );
                  //       }
                  //       // return CategoryItems(
                  //       //   Key(provider.categories[index - 1].id),
                  //       //   onTap: () {
                  //       //     context.router.push(CategoryProductRoute(categoryId: provider.categories[index - 1].id));
                  //       //   },
                  //       //   category: provider.categories[index - 1],
                  //       // );
                  //     },
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: width,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff5d5d5d).withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: const Color(0xff5d5d5d).withOpacity(0.6),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              showSearch(context: context, delegate: DataSearch());
                            },
                            style: TextHelper.normalTextStyle,
                            decoration: InputDecoration(
                              hintText: 'What are you looking for?',
                              border: InputBorder.none,
                              isDense: true,
                              hintStyle: TextHelper.smallTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .02),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisSize: MainAxisSize.max,
                  //   children: [
                  //     Expanded(
                  //       flex: 6,
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  //             child: Row(
                  //               mainAxisSize: MainAxisSize.max,
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 Expanded(
                  //                   child: InkWell(
                  //                     onTap: () => context.router.navigate(const TrialRoute()),
                  //                     child: Container(
                  //                       padding: const EdgeInsets.only(top: 2,bottom: 2),
                  //                       width: double.infinity,
                  //                       height: height * .06,
                  //                       decoration: BoxDecoration(
                  //                         color: ColorConstants.miniColor,
                  //                         border: Border.all(color: ColorConstants.colorBorder),
                  //                         borderRadius: BorderRadius.circular(10),
                  //                         boxShadow: [
                  //                           BoxShadow(
                  //                             color: Colors.black.withOpacity(0.1),
                  //                             blurRadius: 15,
                  //                             offset: const Offset(0, 4),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       alignment: Alignment.center,
                  //                       child: Text(
                  //                         'Shop\nMinis',
                  //                         textAlign: TextAlign.center,
                  //                         style: TextHelper.smallTextStyle.copyWith(
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(width: 10),
                  //                 Expanded(
                  //                   child: InkWell(
                  //                     onTap: () => context.router.navigate(const DealsRoute()),
                  //                     child: Container(
                  //                       padding: const EdgeInsets.only(top: 2,bottom: 2),
                  //                       width: double.infinity,
                  //                       height: height * .06,
                  //                       decoration: BoxDecoration(
                  //                         color: ColorConstants.dealColor,
                  //                         border: Border.all(color: ColorConstants.colorBorder),
                  //                         borderRadius: BorderRadius.circular(10),
                  //                         boxShadow: [
                  //                           BoxShadow(
                  //                             color: Colors.black.withOpacity(0.1),
                  //                             blurRadius: 15,
                  //                             offset: const Offset(0, 4),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       alignment: Alignment.center,
                  //                       child: Text(
                  //                         'Shop\nDeals',
                  //                         textAlign: TextAlign.center,
                  //                         style: TextHelper.smallTextStyle.copyWith(
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(width: 10),
                  //                 Expanded(
                  //                   child: InkWell(
                  //                     onTap: () => context.router.navigate(const BrandProductsRoute()),
                  //                     child: Container(
                  //                       padding: const EdgeInsets.only(top: 2,bottom: 2),
                  //                       width: double.infinity,
                  //                       height: height * .06,
                  //                       decoration: BoxDecoration(
                  //                         color: ColorConstants.sampleColor,
                  //                         border: Border.all(color: ColorConstants.colorBorder),
                  //                         borderRadius: BorderRadius.circular(10),
                  //                         boxShadow: [
                  //                           BoxShadow(
                  //                             color: Colors.black.withOpacity(0.1),
                  //                             blurRadius: 15,
                  //                             offset: const Offset(0, 4),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       alignment: Alignment.center,
                  //                       child: Text(
                  //                         'Free\nSamples',
                  //                         textAlign: TextAlign.center,
                  //                         style: TextHelper.smallTextStyle.copyWith(
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           if (provider.banners.any((element) => element.type == StringConstants.vendyBanner))
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  //               child: CustomNetworkImage(
                  //                 imageUrl: provider.banners.firstWhere((element) => element.type == StringConstants.vendyBanner).banner,
                  //                 width: width,
                  //               ),
                  //             ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 2,
                  //       child: InkWell(
                  //         onTap: () {
                  //           showDialog(
                  //             context: context,
                  //             builder: (c) => VendyScreen(
                  //               vendyFunction: () async {
                  //                 if (provider.currentUser != null) {
                  //                   updateSource(provider);
                  //                   final statusCamera = await Permission.camera.status;
                  //                   final statusLocation = await Permission.location.status;
                  //                   if (statusCamera.isGranted && statusLocation.isGranted) {
                  //                   } else {}
                  //                 } else {
                  //                   ScaffoldSnackBar.of(context).show('Please login first');
                  //                   context.router.push(AuthRoute(logOut: false));
                  //                 }
                  //               },
                  //             ),
                  //           );
                  //         },
                  //         // onTap: () => context.router.push(const VendyRoute()),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: ColorConstants.vendyColor,
                  //             border: Border.all(color: ColorConstants.colorBorder),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //           margin: const EdgeInsets.only(right: 20),
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 'Vendy',
                  //                 style: TextHelper.smallTextStyle.copyWith(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 14.sp,
                  //                 ),
                  //               ),
                  //               const SizedBox(height: 5),
                  //               Image.asset(
                  //                 'assets/images/vendy_icon.png',
                  //                 height: height * .13,
                  //               ),
                  //               const SizedBox(height: 5),
                  //               Text(
                  //                 'Only at \nDelhi NCR',
                  //                 maxLines: 2,
                  //                 textAlign: TextAlign.center,
                  //                 style: TextHelper.extraSmallTextStyle.copyWith(
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Colors.red,
                  //                   fontSize: 12.sp,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  if (provider.banners
                      .where((element) => element.type == StringConstants.homeBanner && element.deviceType == StringConstants.deviceTypeM)
                      .isNotEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, height * .02, 20, 0),
                      child: CarouselSlider.builder(
                        itemCount: provider.banners
                            .where((element) => element.type == StringConstants.homeBanner && element.deviceType == StringConstants.deviceTypeM)
                            .length,
                        itemBuilder: (BuildContext context, int index, int i) {
                          return ClipRRect(
                            key: Key(provider.banners
                                .where((element) => element.type == StringConstants.homeBanner && element.deviceType == StringConstants.deviceTypeM)
                                .toList()[index]
                                .id),
                            borderRadius: BorderRadius.circular(10),
                            child: CustomNetworkImage(
                              imageUrl: provider.banners
                                  .where((element) => element.type == StringConstants.homeBanner && element.deviceType == StringConstants.deviceTypeM)
                                  .toList()[index]
                                  .banner,
                              width: width,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 7),
                          height: height * .45,
                          viewportFraction: 1,
                          padEnds: true,
                        ),
                      ),
                    ),
                  SizedBox(height: height * .02),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         'Shop Minis',
                  //         style: TextHelper.subTitleStyle.copyWith(
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //       InkWell(
                  //         onTap: () => context.router.navigate(const TrialRoute()),
                  //         child: Text(
                  //           'View All',
                  //           style: TextHelper.normalTextStyle.copyWith(
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: height * .01),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Text(
                  //     'Shop Mini\'s: Choose from our wide range of brands & categories, Try any ${provider.appSettings?.generalSettings.itemQty} mini products for only Rs ${provider.appSettings?.generalSettings.miniCharge} (all inclusive).',
                  //     maxLines: 10,
                  //     style: TextHelper.smallTextStyle.copyWith(
                  //       fontWeight: FontWeight.w600,
                  //       color: ColorConstants.colorGreySeven,fontSize: 15.sp,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: height * .02),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     const SizedBox(width: 20),
                  //     Expanded(
                  //       child: SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.max,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             NewCategoryItems(
                  //               key: const Key('t_all'),
                  //               onTap: () {
                  //                 setState(() {
                  //                   trialIndex = 0;
                  //                 });
                  //               },
                  //               active: trialIndex == 0,
                  //               name: 'All',
                  //             ),
                  //             ...provider.miniCategories
                  //                 .asMap()
                  //                 .map(
                  //                   (i, c) => MapEntry(
                  //                     i,
                  //                     NewCategoryItems(
                  //                       key: Key(c.id),
                  //                       onTap: () {
                  //                         setState(() {
                  //                           trialIndex = i + 1;
                  //                         });
                  //                       },
                  //                       active: (trialIndex == (i + 1)),
                  //                       name: c.name,
                  //                     ),
                  //                   ),
                  //                 )
                  //                 .values,
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 20),
                  //   ],
                  // ),
                  // SizedBox(height: height * .02),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: CarouselSlider(
                  //     items: [
                  //       if (trialIndex == 0)
                  //         ...provider.miniProducts.take(provider.miniProducts.length > 10 ? 10 : provider.miniProducts.length).map(
                  //               (e) => MiniItems(
                  //                 key: Key(e.id),
                  //                 product: e,
                  //                 onProductClick: () =>
                  //                     _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                  //                 onProductTry: () => _cartHelper.tryNow(
                  //                   provider: provider,
                  //                   context: context,
                  //                   productId: e.id,
                  //                 ),
                  //                 provider: provider,
                  //                 cartHelper: _cartHelper,
                  //                 gridView: false,
                  //               ),
                  //             )
                  //       else
                  //         ...provider.miniProducts
                  //             .where((element) => element.category?.id == provider.miniCategories[(trialIndex - 1)].id)
                  //             .take((provider.miniProducts.where((element) => element.category?.id == provider.miniCategories[(trialIndex - 1)].id).length) > 10
                  //                 ? 10
                  //                 : provider.miniProducts.where((element) => element.category?.id == provider.miniCategories[(trialIndex - 1)].id).length)
                  //             .map(
                  //               (e) => MiniItems(
                  //                 key: Key(e.id),
                  //                 product: e,
                  //                 onProductClick: () =>
                  //                     _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                  //                 onProductTry: () => _cartHelper.tryNow(
                  //                   provider: provider,
                  //                   context: context,
                  //                   productId: e.id,
                  //                 ),
                  //                 provider: provider,
                  //                 cartHelper: _cartHelper,
                  //                 gridView: false,
                  //               ),
                  //             ),
                  //     ],
                  //     options: CarouselOptions(
                  //       aspectRatio: 1.3,
                  //       viewportFraction: 0.47,
                  //       initialPage: 0,
                  //       enableInfiniteScroll: false,
                  //       reverse: false,
                  //       disableCenter: true,
                  //       padEnds: false,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: height * .02),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.dealCardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * .02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Deals ',
                                style: TextHelper.subTitleStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () => context.router.navigate(const DealsRoute()),
                                  child: Text(
                                    'View All',
                                    style: TextHelper.normalTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * .01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Deals : Special deals & combo offers with best discounts on top brands. Dare to compare pricing .',
                            maxLines: 10,
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.colorGreySeven,fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: height * .02),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    NewCategoryItems(
                                      key: const Key('d_all'),
                                      onTap: () {
                                        setState(() {
                                          dealIndex = 0;
                                        });
                                      },
                                      active: dealIndex == 0,
                                      name: 'All',
                                    ),
                                    ...provider.dealCategories
                                        .asMap()
                                        .map(
                                          (i, c) => MapEntry(
                                            i,
                                            NewCategoryItems(
                                              key: Key(c.id),
                                              onTap: () {
                                                setState(() {
                                                  dealIndex = i + 1;
                                                });
                                              },
                                              active: (dealIndex == (i + 1)),
                                              name: c.name,
                                            ),
                                          ),
                                        )
                                        .values,
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(height: height * .02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CarouselSlider(
                            items: [
                              if (dealIndex == 0)
                                ...provider.dealProducts.take(provider.dealProducts.length > 10 ? 10 : provider.dealProducts.length).map(
                                      (e) => DealItems(
                                        key: Key(e.id),
                                        product: e,
                                        onProductClick: () =>
                                            _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                                        onAddToCart: () => _cartHelper.addToCart(
                                          provider: provider,
                                          context: context,
                                          productId: e.id,
                                        ),
                                        provider: provider,
                                        cartHelper: _cartHelper,
                                        gridView: false,
                                      ),
                                    )
                              else
                                ...provider.dealProducts
                                    .where((element) => element.category?.id == provider.dealCategories[(dealIndex - 1)].id)
                                    .take((provider.dealProducts
                                                .where((element) => element.category?.id == provider.dealCategories[(dealIndex - 1)].id)
                                                .length) >
                                            10
                                        ? 10
                                        : provider.dealProducts.where((element) => element.category?.id == provider.dealCategories[(dealIndex - 1)].id).length)
                                    .map(
                                      (e) => DealItems(
                                        key: Key(e.id),
                                        product: e,
                                        onProductClick: () =>
                                            _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                                        onAddToCart: () => _cartHelper.addToCart(
                                          provider: provider,
                                          context: context,
                                          productId: e.id,
                                        ),
                                        provider: provider,
                                        cartHelper: _cartHelper,
                                        gridView: false,
                                      ),
                                    ),
                            ],
                            options: CarouselOptions(
                              aspectRatio: 1.3,
                              viewportFraction: 0.47,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              reverse: false,
                              disableCenter: true,
                              padEnds: false,
                            ),
                          ),
                        ),
                        SizedBox(height: height * .02),
                      ],
                    ),
                  ),
                  if (provider.banners.where((element) => element.type == StringConstants.homeBannerMiddle).isNotEmpty) SizedBox(height: height * .01),
                  if (provider.banners.where((element) => element.type == StringConstants.homeBannerMiddle).isNotEmpty)
                  //   Padding(
                  //     padding: EdgeInsets.fromLTRB(20, height * .02, 20, 0),
                  //     child: CarouselSlider(
                  //       items: [
                  //         ...provider.banners.where((element) => element.type == StringConstants.homeBannerMiddle).map(
                  //               (e) => ClipRRect(
                  //                 key: Key(e.id),
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 child: CustomNetworkImage(
                  //                   imageUrl: e.banner,
                  //                   fit: BoxFit.cover,
                  //                   width: width,
                  //                 ),
                  //               ),
                  //             ),
                  //       ],
                  //       options: CarouselOptions(
                  //         enableInfiniteScroll: false,
                  //         // autoPlay: true,
                  //         // autoPlayInterval: const Duration(seconds: 2),
                  //         height: height * .25,
                  //         viewportFraction: 1,
                  //         padEnds: true,
                  //       ),
                  //     ),
                  //   ),
                  // SizedBox(height: height * .02),
                    SizedBox(height: height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Free Samples',
                          style: TextHelper.subTitleStyle.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () => context.router.push(const BrandProductsRoute()),
                          child: Text(
                            'View All',
                            style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Free Samples: Explore exciting brands & products for free! Apply for our free sample offers & if you are a match, you only pay a small delivery free ( max Rs 40-80) to get the product home delivered.',
                      maxLines: 10,
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.colorGreySeven,fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NewCategoryItems(
                                key: const Key('s_all'),
                                onTap: () {
                                  setState(() {
                                    sampleIndex = 0;
                                  });
                                },
                                active: sampleIndex == 0,
                                name: 'All',
                              ),
                              ...provider.sampleCategories
                                  .asMap()
                                  .map(
                                    (i, c) => MapEntry(
                                      i,
                                      NewCategoryItems(
                                        key: Key(c.id),
                                        onTap: () {
                                          setState(() {
                                            sampleIndex = i + 1;
                                          });
                                        },
                                        active: (sampleIndex == (i + 1)),
                                        name: c.name,
                                      ),
                                    ),
                                  )
                                  .values,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CarouselSlider(
                      items: [
                        if (sampleIndex == 0)
                          ...provider.sampleProducts.take(provider.sampleProducts.length > 10 ? 10 : provider.sampleProducts.length).map(
                                (e) => SampleItems(
                                  key: Key(e.id),
                                  product: e,
                                  onProductClick: () =>
                                      _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                                  onTry: () => _cartHelper.applyToTry(
                                    provider: provider,
                                    context: context,
                                    productId: e.id,
                                    width: width,
                                    height: height,
                                  ),
                                  provider: provider,
                                  cartHelper: _cartHelper,
                                  gridView: false,
                                ),
                              )
                        else
                          ...provider.sampleProducts
                              .where((element) => element.category?.id == provider.sampleCategories[(sampleIndex - 1)].id)
                              .take((provider.sampleProducts
                                          .where((element) => element.category?.id == provider.sampleCategories[(sampleIndex - 1)].id)
                                          .length) >
                                      10
                                  ? 10
                                  : provider.sampleProducts.where((element) => element.category?.id == provider.sampleCategories[(sampleIndex - 1)].id).length)
                              .map(
                                (e) => SampleItems(
                                  key: Key(e.id),
                                  product: e,
                                  onProductClick: () =>
                                      _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                                  onTry: () => _cartHelper.applyToTry(
                                    provider: provider,
                                    context: context,
                                    productId: e.id,
                                    width: width,
                                    height: height,
                                  ),
                                  provider: provider,
                                  cartHelper: _cartHelper,
                                  gridView: false,
                                ),
                              ),
                      ],
                      options: CarouselOptions(
                        aspectRatio: 1.3,
                        viewportFraction: 0.47,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        disableCenter: true,
                        padEnds: false,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  // if (provider.brands.where((element) => element.sort == 1 || element.sort == 2 || element.sort == 3 || element.sort == 4).isNotEmpty)
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.max,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           'Explore By Brands',
                  //           style: TextHelper.subTitleStyle.copyWith(
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //         InkWell(
                  //           onTap: () => context.router.navigate(const ExploreByBrandsRoute()),
                  //           child: Text(
                  //             'View All',
                  //             style: TextHelper.normalTextStyle.copyWith(
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // SizedBox(height: height * .02),
                  // GridView.count(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   physics: const BouncingScrollPhysics(),
                  //   childAspectRatio: 1.5,
                  //   crossAxisSpacing: 20,
                  //   mainAxisSpacing: 20,
                  //   crossAxisCount: 3,
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   children: [
                  //     ...provider.brands
                  //         .where((element) =>
                  //             element.sort == 1 ||
                  //             element.sort == 2 ||
                  //             element.sort == 3 ||
                  //             element.sort == 4 ||
                  //             element.sort == 5 ||
                  //             element.sort == 6 ||
                  //             element.sort == 7 ||
                  //             element.sort == 8 ||
                  //             element.sort == 9)
                  //         .take(provider.brands
                  //                     .where((element) =>
                  //                         element.sort == 1 ||
                  //                         element.sort == 2 ||
                  //                         element.sort == 3 ||
                  //                         element.sort == 4 ||
                  //                         element.sort == 5 ||
                  //                         element.sort == 6 ||
                  //                         element.sort == 7 ||
                  //                         element.sort == 8 ||
                  //                         element.sort == 9)
                  //                     .length >
                  //                 9
                  //             ? 9
                  //             : provider.brands
                  //                 .where((element) =>
                  //                     element.sort == 1 ||
                  //                     element.sort == 2 ||
                  //                     element.sort == 3 ||
                  //                     element.sort == 4 ||
                  //                     element.sort == 5 ||
                  //                     element.sort == 6 ||
                  //                     element.sort == 7 ||
                  //                     element.sort == 8 ||
                  //                     element.sort == 9)
                  //                 .length)
                  //         .map(
                  //           (e) => InkWell(
                  //             onTap: () {
                  //               context.router.push(BrandTrialRoute(brand: e));
                  //             },
                  //             splashFactory: NoSplash.splashFactory,
                  //             highlightColor: Colors.transparent,
                  //             child: Container(
                  //               width: double.infinity,
                  //               clipBehavior: Clip.antiAlias,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 border: Border.all(
                  //                   color: ColorConstants.colorBlack.withOpacity(0.4),
                  //                   width: 2,
                  //                 ),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Colors.black.withOpacity(0.1),
                  //                     blurRadius: 15,
                  //                     offset: const Offset(0, 4),
                  //                   ),
                  //                 ],
                  //               ),
                  //               alignment: Alignment.center,
                  //               child: e.logo.isNotEmpty
                  //                   ? CustomNetworkImage(
                  //                       imageUrl: e.logo,
                  //                     )
                  //                   : null,
                  //             ),
                  //           ),
                  //         ),
                  //   ],
                  // ),
                  // if (provider.banners.where((element) => element.type == StringConstants.homeSmall).isNotEmpty) SizedBox(height: height * .01),
                  // if (provider.banners.where((element) => element.type == StringConstants.homeSmall).isNotEmpty)
                  //   Padding(
                  //     padding: EdgeInsets.fromLTRB(20, height * .02, 20, 0),
                  //     child: CarouselSlider(
                  //       items: [
                  //         ...provider.banners.where((element) => element.type == StringConstants.homeSmall).map(
                  //               (e) => ClipRRect(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 child: CustomNetworkImage(
                  //                   imageUrl: e.banner,
                  //                   width: width,
                  //                   fit: BoxFit.fill,
                  //                 ),
                  //               ),
                  //             ),
                  //       ],
                  //       options: CarouselOptions(
                  //         enableInfiniteScroll: false,
                  //         height: height * .12,
                  //         viewportFraction: 1,
                  //         padEnds: true,
                  //       ),
                  //     ),
                  //   ),
                  // SizedBox(height: height * .02),
                  // InkWell(
                  //   onTap: () => context.router.navigate(const DealsRoute()),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //     child: Image.asset(
                  //       'assets/images/home_small.png',
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: height * .1),
                  SizedBox(height: height * .02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
