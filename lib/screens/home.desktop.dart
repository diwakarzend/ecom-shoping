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
import 'package:url_launcher/url_launcher.dart';

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

  List<String> _banners = [
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66f118422b852.png',
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66d84c831a6d9.jpg'
  ];

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
                  Container(
                    color: Colors.black,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Download the app now!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'For the better experience download our app.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: _downloadAPK,
                          icon: Icon(
                            Icons.android,
                            size: 24,
                          ),
                          label: Text('Download APK'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const TopAppBar(),
                  // CarouselSlider(
                  //   items: _banners
                  //   // items: provider.banners
                  //   //     .where((element) =>
                  //   // (element.type == StringConstants.homeBanner || element.type == newBannerCategory) &&
                  //   //     element.deviceType == StringConstants.deviceTypeD)
                  //       .map(
                  //         (e) => CustomNetworkImage(
                  //       imageUrl: e,
                  //       width: width,
                  //       height: double.infinity,
                  //       fit: BoxFit.cover,
                  //     ),
                  //   )
                  //       .toList(),
                  //   options: CarouselOptions(
                  //     disableCenter: true,
                  //     viewportFraction: 1,
                  //     height: height * .8,
                  //     autoPlay: true,
                  //     onPageChanged: (i, _) => setState(() => bannerIndex = i),
                  //   ),
                  // )
                  Image.asset('assets/images/banner2.png'),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            context.router.push(const DealsRoute());
                          },
                          child: Image.asset(
                            'assets/images/chair.png',
                            // height: 200,
                            // width: 200,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .05, vertical: 17),
                          itemCount: provider.dealProducts.take(6).length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.5,
                          ),
                          itemBuilder: (context, index) {
                            final e =
                                provider.dealProducts.take(6).toList()[index];
                            return DealItemDesktop(
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
                              gridView: true,
                              sub_category: '',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: InkWell(
                        onTap: _downloadAPK,
                        child: Image.asset('assets/images/bottom1.png')),
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
                  style: TextHelper.smallTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.colorBlackTwo,
                      fontSize: 13.sp),
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

void _downloadAPK() async {
  const launchUri =
      'https://shoppingapps.s3.ap-south-1.amazonaws.com/artimbe-release.apk';
  await launchUrl(Uri.parse(launchUri));
}
