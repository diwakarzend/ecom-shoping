import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants.dart';

class HomeScreenDesktop extends StatefulWidget {
  final bool orderSuccess;
  final Order? order;

  const HomeScreenDesktop({super.key, this.orderSuccess = false, this.order});

  @override
  State<HomeScreenDesktop> createState() => _HomeScreenDesktopState();
}

class _HomeScreenDesktopState extends State<HomeScreenDesktop> {
  bool supportExpanded = false;

  int trialIndex = 0, dealIndex = 0, sampleIndex = 0;

  // final CarouselController _miniController = CarouselController();
  // final CarouselController _dealController = CarouselController();
  // final CarouselController _sampleController = CarouselController();

  final DioHelper _dioHelper = DioHelper();

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

  final CartHelper _cartHelper = CartHelper();

  int bannerIndex = 0;

  final List<String> _banners = [
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66b31b913c766.jpg',
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/deal banner/654b2f9234e42.jpg'
  ];

  @override
  void initState() {
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
                  onRate: () async {
                    dialogContext?.maybePop();
                    // if (await inAppReview.isAvailable()) {
                    //   inAppReview.openStoreListing(appStoreId: '6447238261');
                    // }
                  },
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            drawer: CustomDrawerDesktop(
              provider: provider,
              onSupportExtend: () {
                setState(() {
                  supportExpanded = !supportExpanded;
                });
              },
              supportExpanded: supportExpanded,
              cartHelper: _cartHelper,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const TopAppBar(),
                  // SizedBox(height: height * .01),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: width * .12),
                  //   alignment: Alignment.center,
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(
                  //       children: [
                  //         InkWell(
                  //           onTap: () => context.router.navigate(const CategoryRoute()),
                  //           splashFactory: NoSplash.splashFactory,
                  //           highlightColor: Colors.transparent,
                  //           hoverColor: Colors.transparent,
                  //           child: Container(
                  //             margin: const EdgeInsets.all(15),
                  //             child: Column(
                  //               children: [
                  //                 Container(
                  //                   width: width * .05,
                  //                   height: width * .05,
                  //                   decoration: const BoxDecoration(
                  //                     color: Color(0xff4b90f0),
                  //                     shape: BoxShape.circle,
                  //                   ),
                  //                   child: Icon(
                  //                     Icons.grid_view_rounded,
                  //                     size: height * .05,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: height * .03,
                  //                 ),
                  //                 Text(
                  //                   'View All',
                  //                   style: TextHelper.smallTextStyle.copyWith(
                  //                     fontWeight: FontWeight.w500,
                  //                     fontSize: 12.sp,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         ...provider.categories.map(
                  //           (e) => InkWell(
                  //             onTap: () => context.router.push(CategoryProductRoute(categoryId: e.id)),
                  //             splashFactory: NoSplash.splashFactory,
                  //             highlightColor: Colors.transparent,
                  //             hoverColor: Colors.transparent,
                  //             child: Container(
                  //               margin: const EdgeInsets.all(15),
                  //               child: Column(
                  //                 children: [
                  //                   Container(
                  //                     decoration: const BoxDecoration(
                  //                       shape: BoxShape.circle,
                  //                     ),
                  //                     child: CustomNetworkImage(
                  //                       imageUrl: e.icon ?? '',
                  //                       width: width * .05,
                  //                       height: width * .05,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     height: height * .03,
                  //                   ),
                  //                   Text(
                  //                     e.name,
                  //                     style: TextHelper.normalTextStyle.copyWith(
                  //                       fontWeight: FontWeight.w500,
                  //                       fontSize: 12.sp,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: height * .01),
                  CarouselSlider(
                    items: _banners
                        .map(
                          (e) => CustomNetworkImage(
                            imageUrl: e,
                            width: width,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      disableCenter: true,
                      viewportFraction: 1,
                      height: height * .8,
                      autoPlay: true,
                      onPageChanged: (i, _) => setState(() => bannerIndex = i),
                    ),
                  ),
                  // ),
                  SizedBox(height: height * .01),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ..._banners
                          .asMap()
                          .map(
                            (i, v) => MapEntry(
                              i,
                              Container(
                                width: 10,
                                height: 10,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: bannerIndex == i ? ColorConstants.colorBlack : Colors.transparent,
                                  border: Border.all(
                                    color: ColorConstants.colorBlack,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .values,
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: height * .03),
                      width: width,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => context.router.navigate(const TrialRoute()),
                              child: Container(
                                width: double.infinity,
                                height: height * .08,
                                decoration: BoxDecoration(
                                  color: ColorConstants.miniColor,
                                  border: Border.all(color: ColorConstants.colorBorder),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 15,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Shop Mini's",
                                  textAlign: TextAlign.center,
                                  style: TextHelper.smallTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * .05),
                          Expanded(
                            child: InkWell(
                              onTap: () => context.router.navigate(const DealsRoute()),
                              child: Container(
                                width: double.infinity,
                                height: height * .08,
                                decoration: BoxDecoration(
                                  color: ColorConstants.dealColor,
                                  border: Border.all(color: ColorConstants.colorBorder),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 15,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Shop Deals',
                                  textAlign: TextAlign.center,
                                  style: TextHelper.smallTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * .05),
                          Expanded(
                            child: InkWell(
                              onTap: () => context.router.navigate(const BrandProductsRoute()),
                              child: Container(
                                width: double.infinity,
                                height: height * .08,
                                decoration: BoxDecoration(
                                  color: ColorConstants.sampleColor,
                                  border: Border.all(color: ColorConstants.colorBorder),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 15,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Free Samples',
                                  textAlign: TextAlign.center,
                                  style: TextHelper.smallTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // FB5Container(
                  //   child:
                  // SizedBox(height: height * .002),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: width * .12),
                  //   alignment: Alignment.center,
                  //   child: Container(
                  //     height: height * .075,
                  //     margin: EdgeInsets.only(bottom: height * .03),
                  //     decoration: BoxDecoration(
                  //       color: const Color(0xffe5e6e6),
                  //       borderRadius: BorderRadius.circular(50),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Expanded(
                  //           flex: 6,
                  //           child: TextFormField(
                  //             onTap: () {
                  //               FocusScope.of(context).unfocus();
                  //               showSearch(context: context, delegate: DataSearch());
                  //             },
                  //             decoration: InputDecoration(
                  //               hintText: 'Search',
                  //               hintStyle: const TextStyle(
                  //                 fontSize: 18.0,
                  //                 color: Colors.grey,
                  //               ),
                  //               border: InputBorder.none,
                  //               contentPadding: EdgeInsets.only(left: width * .02),
                  //             ),
                  //           ),
                  //         ),
                  //         const Icon(
                  //           Icons.search,
                  //           color: Colors.grey,
                  //           size: 30,
                  //         ),
                  //         SizedBox(
                  //           width: width * .01,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: height * .01,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Shop Mini's",
                            textAlign: TextAlign.center,
                            style: TextHelper.titleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              // fontSize: 25.0,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            splashFactory: NoSplash.splashFactory,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              context.router.push(const TrialRoute());
                            },
                            child: Text(
                              'View All ',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * .03),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Shop Deals(small banner) Slider\nHow it Works? +2 Promo Banners',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NewCategoryItems(
                                  key: const Key('t_all'),
                                  onTap: () {
                                    setState(() {
                                      trialIndex = 0;
                                    });
                                  },
                                  active: trialIndex == 0,
                                  name: 'All',
                                ),
                                ...provider.miniCategories
                                    .asMap()
                                    .map(
                                      (i, c) => MapEntry(
                                        i,
                                        NewCategoryItems(
                                          key: Key(c.id),
                                          onTap: () {
                                            setState(() {
                                              trialIndex = i + 1;
                                            });
                                          },
                                          active: (trialIndex == (i + 1)),
                                          name: c.name,
                                        ),
                                      ),
                                    )
                                    .values,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 1),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * .01),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Deals & Combos',
                            textAlign: TextAlign.center,
                            style: TextHelper.titleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              // fontSize: 25.0,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            splashFactory: NoSplash.splashFactory,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              context.router.push(const DealsRoute());
                            },
                            child: Text(
                              'View All ',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: height * .008, bottom: height * .03),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Deals & Combo\'s: Special deals & combo offers\nwith best discounts on top brands. Dare to compare pricing .',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .01),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  NewCategoryItems(
                                    key: const Key('t_all'),
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
                    ),
                  ),
                  // FB5Container(
                  //   child:
                  const SizedBox(
                    height: 15,
                  ),
                  if (provider.banners.any((element) => element.type == StringConstants.homeBannerMiddle))
                    CarouselSlider(
                      items: provider.banners
                          .where((element) => element.type == StringConstants.homeBannerMiddle)
                          .map(
                            (e) => CustomNetworkImage(
                              imageUrl: e.banner,
                              width: width,
                              fit: BoxFit.cover,
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        disableCenter: true,
                        viewportFraction: 1,
                        height: height * .5,
                        autoPlay: true,
                      ),
                    ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: height * .01,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Free Samples',
                            textAlign: TextAlign.center,
                            style: TextHelper.titleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              // fontSize: 25.0,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            splashFactory: NoSplash.splashFactory,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              context.router.push(const BrandProductsRoute());
                            },
                            child: Text(
                              'View All ',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: height * .008, bottom: height * .03, right: width * .25),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Free Samples: Explore exciting brands & products for free! Apply for our free sample offers & if you are a match, you only pay a small delivery free (max Rs 40-80) to get the product home delivered.',
                              textAlign: TextAlign.justify,
                              maxLines: 6,
                              style: TextHelper.normalTextStyle.copyWith(
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .01),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Padding(
                      // padding: EdgeInsets.only(bottom: height * .01),
                      padding: EdgeInsets.only(bottom: height * .01, top: height * .02),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Explore By Brands',
                            textAlign: TextAlign.center,
                            style: TextHelper.titleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              // fontSize: 25.0,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            splashFactory: NoSplash.splashFactory,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              context.router.navigate(const ExploreByBrandsRoute());
                            },
                            child: Text(
                              'View All ',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: GridView.count(
                      crossAxisCount: 6,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      primary: false,
                      childAspectRatio: 1.11,
                      padding: EdgeInsets.symmetric(vertical: height * .02),
                      children: [
                        ...provider.brands.take(provider.brands.length > 18 ? 18 : provider.brands.length).map(
                              (e) => InkWell(
                                onTap: () {
                                  context.router.push(BrandTrialRoute(brand: e));
                                },
                                splashFactory: NoSplash.splashFactory,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: ColorConstants.colorBlack.withOpacity(0.4),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 15,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: e.logo.isNotEmpty
                                      ? CustomNetworkImage(
                                          imageUrl: e.logo,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                  // FB5Container(
                  //   child:
                  Padding(
                    padding: EdgeInsets.only(top: height * .04, bottom: height * .03),
                    child: CarouselSlider(
                      items: [
                        ...provider.banners.where((element) => element.type == StringConstants.homeSmall).map(
                              (e) => CustomNetworkImage(
                                imageUrl: e.banner,
                                width: width,
                                fit: BoxFit.fill,
                              ),
                            ),
                      ],
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: height * .4,
                        viewportFraction: 1,
                        padEnds: true,
                      ),
                    ),
                  ),
                  Text(
                    'UPto 80% OFF',
                    style: TextHelper.normalTextStyle
                        .copyWith(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.sp),
                  ),
                  InkWell(
                    onTap: () => context.router.navigate(const DealsRoute()),
                    child: Container(
                      alignment: Alignment.center,
                      width: width,
                      height: height * .076,
                      margin: EdgeInsets.symmetric(horizontal: width * .33, vertical: height * .01),
                      decoration: BoxDecoration(
                        color: const Color(0xff3e87ff),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'SHOP NOW',
                        style: TextHelper.normalTextStyle.copyWith(color: Colors.white, fontSize: 17.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .04),
                  const BottomAppBarPage(),
                ],
              ),
            ),
          ),
        );
      },
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
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
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
            width: width * .3,
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
                  style: TextHelper.smallTextStyle
                      .copyWith(fontWeight: FontWeight.bold, color: ColorConstants.colorBlackTwo, fontSize: 13.sp),
                ),
                SizedBox(height: height * .02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'we’re getting your order ( #$orderId ) ready & shall notify you when it’s dispatched.',
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextHelper.extraSmallTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: ColorConstants.colorBlackTwo,
                    ),
                  ),
                ),
                SizedBox(height: height * .02),

                // Container(
                //   width: width,
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: height * .02),
                //   decoration: const BoxDecoration(
                //     color: ColorConstants.colorRatingPopup,
                //   ),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Your opinion matters to us!',
                //         style: TextHelper.normalTextStyle.copyWith(
                //           fontWeight: FontWeight.w600,
                //           color: ColorConstants.colorBlackTwo,
                //         ),
                //       ),
                //       SizedBox(height: height * .02),
                //       Text(
                //         'Rate your app experience',
                //         maxLines: 5,
                //         textAlign: TextAlign.center,
                //         style: TextHelper.smallTextStyle.copyWith(
                //           fontWeight: FontWeight.w500,
                //           color: ColorConstants.colorBlackTwo,
                //         ),
                //       ),
                //       SizedBox(height: height * .02),
                //       // RatingBar.builder(
                //       //   initialRating: 0,
                //       //   minRating: 1,
                //       //   direction: Axis.horizontal,
                //       //   allowHalfRating: true,
                //       //   itemCount: 5,
                //       //   itemSize: 30,
                //       //   itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                //       //   itemBuilder: (context, _) => const Icon(
                //       //     Ionicons.star,
                //       //     color: ColorConstants.colorStar,
                //       //   ),
                //       //   onRatingUpdate: (rating) {
                //       //     debugPrint(rating.toString());
                //       //   },
                //       // ),
                //       // SizedBox(height: height * .02),
                //       // Padding(
                //       //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //       //   child: TextField(
                //       //     maxLines: 5,
                //       //     minLines: 3,
                //       //     style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorBlackTwo),
                //       //     decoration: InputDecoration(
                //       //       hintText: 'Leave a message, if you want',
                //       //       hintStyle: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorBlackTwo),
                //       //       fillColor: Colors.white,
                //       //       isDense: true,
                //       //       filled: true,
                //       //       border: OutlineInputBorder(
                //       //         borderRadius: BorderRadius.circular(5),
                //       //         borderSide: BorderSide.none,
                //       //       ),
                //       //     ),
                //       //   ),
                //       // ),
                //       // SizedBox(height: height * .02),
                //       // InkWell(
                //       //   onTap: onRate,
                //       //   child: Container(
                //       //     decoration: BoxDecoration(
                //       //       color: ColorConstants.colorBlueSeventeen,
                //       //       borderRadius: BorderRadius.circular(5),
                //       //     ),
                //       //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                //       //     child: Text(
                //       //       'Rate now',
                //       //       style: TextHelper.normalTextStyle.copyWith(
                //       //         fontWeight: FontWeight.w500,
                //       //         color: Colors.white,
                //       //       ),
                //       //     ),
                //       //   ),
                //       // ),
                //       // SizedBox(height: height * .02),
                //     ],
                //   ),
                // ),
                // SizedBox(height: height * .02),
                // InkWell(
                //   onTap: onCancel,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.transparent,
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                //     child: Text(
                //       'Maybe Later',
                //       style: TextHelper.normalTextStyle.copyWith(
                //         fontWeight: FontWeight.w500,
                //         color: ColorConstants.colorTextLater,
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: height * .02),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                context.router.maybePop();
              },
              child: Container(
                width: 40,
                height: 40,
                transform: Matrix4.translationValues(5, -8, 0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorOffWhite,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.clear_rounded,
                  color: ColorConstants.colorBlack,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
