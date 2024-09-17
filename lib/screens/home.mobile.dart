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
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
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
  //                 c.router.maybePop();
  //               },
  //               child: const Text('Enable Location'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 c.router.maybePop();
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

  List<String> _banners = ['https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66e95ab270c35.jpg',
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66e95ab2ee4f2.jpg'];



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
                  if (provider.banners
                      .where((element) =>
                          element.type == StringConstants.homeBanner &&
                          element.deviceType == StringConstants.deviceTypeM)
                      .isNotEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, height * .02, 20, 0),
                      child: CarouselSlider.builder(
                        itemCount: _banners
                            // .where((element) => element.type == StringConstants.homeBanner && element.deviceType == StringConstants.deviceTypeM)
                            .length,
                        itemBuilder: (BuildContext context, int index, int i) {
                          return ClipRRect(
                            key: Key(provider.banners
                                .where((element) =>
                                    element.type == StringConstants.homeBanner &&
                                    element.deviceType == StringConstants.deviceTypeM)
                                .toList()[index]
                                .id),
                            borderRadius: BorderRadius.circular(10),
                            child: CustomNetworkImage(
                              imageUrl: provider.banners
                                  .where((element) =>
                                      element.type == StringConstants.homeBanner &&
                                      element.deviceType == StringConstants.deviceTypeM)
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
                                'Fashion',
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
                            'Fashion: Style is a way to say who you are without having to speak',
                            maxLines: 10,
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.colorGreySeven,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: height * .02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CarouselSlider(
                            items: [
                              if (dealIndex == 0)
                                ...provider.dealProducts
                                    .take(provider.dealProducts.length > 10 ? 10 : provider.dealProducts.length)
                                    .map(
                                      (e) => DealItems(
                                        key: Key(e.id),
                                        product: e,
                                        onProductClick: () => _cartHelper.productClick(
                                            context: context,
                                            productId: e.id,
                                            productType: e.productType,
                                            provider: provider),
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
                                    .where((element) =>
                                        element.category?.id == provider.dealCategories[(dealIndex - 1)].id)
                                    .take((provider.dealProducts
                                                .where((element) =>
                                                    element.category?.id == provider.dealCategories[(dealIndex - 1)].id)
                                                .length) >
                                            10
                                        ? 10
                                        : provider.dealProducts
                                            .where((element) =>
                                                element.category?.id == provider.dealCategories[(dealIndex - 1)].id)
                                            .length)
                                    .map(
                                      (e) => DealItems(
                                        key: Key(e.id),
                                        product: e,
                                        onProductClick: () => _cartHelper.productClick(
                                            context: context,
                                            productId: e.id,
                                            productType: e.productType,
                                            provider: provider),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
