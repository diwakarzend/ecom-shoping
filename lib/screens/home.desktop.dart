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
import 'package:flutter/material.dart';
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
  static String newBannerCategory = "63976a676aba4031c062e5b2";
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


  List<String> _banners = ['https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66d84c8421745.jpg',
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66d84c831a6d9.jpg'];


  @override
  void initState() {
    if (widget.orderSuccess && widget.order != null) {
      BuildContext? dialogContext;
      Future.delayed(
        const Duration(milliseconds: 500),
            () => showDialog(
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
        ),
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
            backgroundColor:ColorConstants.colorGreenFour,
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
                  CarouselSlider(
                    items: _banners
                    // items: provider.banners
                    //     .where((element) =>
                    // (element.type == StringConstants.homeBanner || element.type == newBannerCategory) &&
                    //     element.deviceType == StringConstants.deviceTypeD)
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
                  SizedBox(height: height * .01),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ...provider.banners
                      //     .where((element) => element.type == StringConstants.homeBanner && element.deviceType == StringConstants.deviceTypeD)
                      //     .toList()
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
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * .01),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Furniture  ',
                            textAlign: TextAlign.center,
                            style: TextHelper.titleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
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
                                fontWeight: FontWeight.w500,color: Colors.white
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,color: Colors.white,),
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
                            'A cool and comfortable graphic tee that expresses your personality. ',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .06),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: height * .03),
                            child: CarouselSlider(
                              // carouselController: _dealController,
                              items: [
                                if (dealIndex == 0)
                                  ...provider.dealProducts
                                      .take(provider.dealProducts.length > 10 ? 10 : provider.dealProducts.length)
                                      .map(
                                        (e) => DealItemDesktop(
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
                                      gridView: false, sub_category: '',
                                    ),
                                  )
                                else
                                  ...provider.dealProducts
                                      .where((element) =>
                                  element.category?.id == provider.dealCategories[(dealIndex - 1)].id)
                                      .take((provider.dealProducts
                                      .where((element) =>
                                  element.category?.id ==
                                      provider.dealCategories[(dealIndex - 1)].id)
                                      .length) >
                                      10
                                      ? 10
                                      : provider.dealProducts
                                      .where((element) =>
                                  element.category?.id == provider.dealCategories[(dealIndex - 1)].id)
                                      .length)
                                      .map(
                                        (e) => DealItemDesktop(
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
                                      gridView: false, sub_category: '',
                                    ),
                                  ),
                              ],
                              options: CarouselOptions(
                                // aspectRatio: 4.5,
                                aspectRatio: 3.1,
                                // viewportFraction: 0.15,
                                viewportFraction: 0.2,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                reverse: false,
                                disableCenter: true,
                                padEnds: false,
                                autoPlay: true,
                              ),
                            ),
                          ),
                        ),                      ],
                    ),
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
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: ColorConstants.colorBlackTwo, fontSize: 13.sp),
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







