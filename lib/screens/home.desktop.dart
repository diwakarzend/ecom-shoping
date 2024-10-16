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
import 'package:flutter_svg/flutter_svg.dart';
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
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66dbf2e85ed75.jpg',
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66dbf2e85eccc.jpg'
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
                  Image.asset('assets/images/top_img.png',
                      width: double.infinity),
                  SizedBox(height: height * .03),
                  Text(
                    'Explore Popular Categories',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 400,
                    padding: EdgeInsets.all(16),
                    child: GridView.count(
                      crossAxisCount: 5,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CategoryCard(
                          image: Image.asset('assets/images/img1.png'),
                          title: 'New & Trending',
                        ),
                        CategoryCard(
                          image: Image.asset('assets/images/img2.png'),
                          title: 'Electronics',
                        ),
                        CategoryCard(
                          image: Image.asset('assets/images/img3.png'),
                          title: 'Health & Beauty',
                        ),
                        CategoryCard(
                          image: Image.asset('assets/images/img4.png'),
                          title: 'Deals',
                        ),
                        CategoryCard(
                          image: Image.asset('assets/images/img5.png'),
                          title: 'Fashion',
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: height * .01),
                  Text(
                    'Limited Time Deals',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  Container(
                    height: 400,
                    padding: EdgeInsets.all(16),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CategoryCard(
                          image: Image.asset('assets/images/img6.png'),
                          title: '',
                        ),
                        CategoryCard(
                          image: Image.asset('assets/images/‫img7.png'),
                          title: '',
                        ),
                        CategoryCard(
                          image: Image.asset('assets/images/img8.png'),
                          title: '',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    'Flash Deals \n Up to 65% off',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 12,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * .03),
                            child: CarouselSlider(
                              // carouselController: _dealController,
                              items: [
                                if (dealIndex == 0)
                                  ...provider.dealProducts
                                      .take(provider.dealProducts.length > 10
                                          ? 10
                                          : provider.dealProducts.length)
                                      .map(
                                        (e) => DealItemDesktop(
                                          key: Key(e.id),
                                          product: e,
                                          onProductClick: () =>
                                              _cartHelper.productClick(
                                                  context: context,
                                                  productId: e.id,
                                                  productType: e.productType,
                                                  provider: provider),
                                          onAddToCart: () =>
                                              _cartHelper.addToCart(
                                            provider: provider,
                                            context: context,
                                            productId: e.id,
                                          ),
                                          provider: provider,
                                          cartHelper: _cartHelper,
                                          gridView: false,
                                          sub_category: '',
                                        ),
                                      )
                                else
                                  ...provider.dealProducts
                                      .where((element) =>
                                          element.category?.id ==
                                          provider
                                              .dealCategories[(dealIndex - 1)]
                                              .id)
                                      .take((provider.dealProducts
                                                  .where((element) =>
                                                      element.category?.id ==
                                                      provider
                                                          .dealCategories[
                                                              (dealIndex - 1)]
                                                          .id)
                                                  .length) >
                                              10
                                          ? 10
                                          : provider.dealProducts
                                              .where((element) =>
                                                  element.category?.id ==
                                                  provider
                                                      .dealCategories[
                                                          (dealIndex - 1)]
                                                      .id)
                                              .length)
                                      .map(
                                        (e) => DealItemDesktop(
                                          key: Key(e.id),
                                          product: e,
                                          onProductClick: () =>
                                              _cartHelper.productClick(
                                                  context: context,
                                                  productId: e.id,
                                                  productType: e.productType,
                                                  provider: provider),
                                          onAddToCart: () =>
                                              _cartHelper.addToCart(
                                            provider: provider,
                                            context: context,
                                            productId: e.id,
                                          ),
                                          provider: provider,
                                          cartHelper: _cartHelper,
                                          gridView: false,
                                          sub_category: '',
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: InkWell(
                        onTap: _downloadAPK,
                        child: Image.asset('assets/images/download.png')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * .05),
                    child: Row(children: [
                      Expanded(
                        flex: 6,
                        child: Image.asset('assets/images/image16.png',
                            width: double.infinity),
                      ),
                      Expanded(
                        flex: 5,
                        child: Image.asset('assets/images/image17.png',
                        width: double.infinity,),
                      )
                    ]),
                  ),                  SizedBox(height: height * .02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Image.asset('assets/images/image14.png'),
                  ),
                  SizedBox(height: height * .02),
                  // Expanded(
                  //   flex: 6,
                  //   child: Image.asset(
                  //     'assets/images/image16.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // SizedBox(width: 8.0),
                  // Expanded(
                  //   flex: 3,
                  //   child: Column(
                  //     children: [
                  //       Expanded(
                  //         child: Image.asset(
                  //           'assets/images/image17.png',
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(width: 8.0),
                  // Expanded(
                  //   flex: 3,
                  //   child: Image.asset(
                  //     'assets/images/image19.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Image.asset('assets/images/image9.png',
                                width: double.infinity)),
                        SizedBox(width: width * .01),
                        Expanded(
                            child: Image.asset(
                          'assets/images/image_9.png',
                          width: double.infinity,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    "Don't miss Out on exclusive deals on Furniture",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 12,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * .03),
                            child: CarouselSlider(
                              // carouselController: _dealController,
                              items: [
                                if (dealIndex == 0)
                                  ...provider.dealProducts
                                      .take(provider.dealProducts.length > 10
                                          ? 10
                                          : provider.dealProducts.length)
                                      .map(
                                        (e) => DealItemDesktop(
                                          key: Key(e.id),
                                          product: e,
                                          onProductClick: () =>
                                              _cartHelper.productClick(
                                                  context: context,
                                                  productId: e.id,
                                                  productType: e.productType,
                                                  provider: provider),
                                          onAddToCart: () =>
                                              _cartHelper.addToCart(
                                            provider: provider,
                                            context: context,
                                            productId: e.id,
                                          ),
                                          provider: provider,
                                          cartHelper: _cartHelper,
                                          gridView: false,
                                          sub_category: '',
                                        ),
                                      )
                                else
                                  ...provider.dealProducts
                                      .where((element) =>
                                          element.category?.id ==
                                          provider
                                              .dealCategories[(dealIndex - 1)]
                                              .id)
                                      .take((provider.dealProducts
                                                  .where((element) =>
                                                      element.category?.id ==
                                                      provider
                                                          .dealCategories[
                                                              (dealIndex - 1)]
                                                          .id)
                                                  .length) >
                                              10
                                          ? 10
                                          : provider.dealProducts
                                              .where((element) =>
                                                  element.category?.id ==
                                                  provider
                                                      .dealCategories[
                                                          (dealIndex - 1)]
                                                      .id)
                                              .length)
                                      .map(
                                        (e) => DealItemDesktop(
                                          key: Key(e.id),
                                          product: e,
                                          onProductClick: () =>
                                              _cartHelper.productClick(
                                                  context: context,
                                                  productId: e.id,
                                                  productType: e.productType,
                                                  provider: provider),
                                          onAddToCart: () =>
                                              _cartHelper.addToCart(
                                            provider: provider,
                                            context: context,
                                            productId: e.id,
                                          ),
                                          provider: provider,
                                          cartHelper: _cartHelper,
                                          gridView: false,
                                          sub_category: '',
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    "Exclusive deals on Cosmetics Products",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  Container(
                    height: 400,
                    padding: EdgeInsets.all(16),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CategoryCard(
                          image: Image.asset('assets/images/img10.png'),
                          title: '',
                        ),
                        CategoryCard(
                          image: Image.asset('assets/images/img11.png'),
                          title: '',
                        ),
                        CategoryCard(
                          image: Image.asset('assets/images/img12.png'),
                          title: '',
                        ),
                      ],
                    ),
                  ),
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
                            'assets/images/OIP.jpeg',
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: InkWell(
                        onTap: _downloadAPK,
                        child: Image.asset('assets/images/download.png')),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.only(left: width * .05),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 7,
                  //         child: InkWell(
                  //           onTap: _downloadAPK,
                  //           child: Image.asset('assets/images/downloadapk.png', width: double.infinity),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 5,
                  //         child: CarouselSlider(
                  //           items: provider.dealProducts
                  //               .take(5)
                  //               .map(
                  //                 (e) => DealItemDesktop(
                  //               key: Key(e.id),
                  //               product: e,
                  //               onProductClick: () =>
                  //                   _cartHelper.productClick(
                  //                       context: context,
                  //                       productId: e.id,
                  //                       productType: e.productType,
                  //                       provider: provider),
                  //               onAddToCart: () => _cartHelper.addToCart(
                  //                 provider: provider,
                  //                 context: context,
                  //                 productId: e.id,
                  //               ),
                  //               provider: provider,
                  //               cartHelper: _cartHelper,
                  //               gridView: false,
                  //               sub_category: '',
                  //             ),
                  //           )
                  //               .toList(),
                  //           options: CarouselOptions(
                  //             aspectRatio: 1.5,
                  //             viewportFraction: 0.40,
                  //             initialPage: 0,
                  //             enableInfiniteScroll: false,
                  //             autoPlay: true,
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),nbnnb
                  SizedBox(height: height * .01),
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

class CategoryCard extends StatelessWidget {
  final Image image;
  final String title;

  const CategoryCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: image),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
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
                SvgPicture.asset('assets/images/icons/like.icon.svg',
                    width: width * .1),
                SizedBox(height: height * .02),
                Text(
                  'Thanks for your order!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.colorBlackTwo,
                      fontSize: 13.sp),
                ),
                SizedBox(height: height * .02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'We’re getting your order ( #$orderId ) ready & shall notify you when it’s dispatched.',
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
                SizedBox(height: height * .03),
                const Divider(),
                SizedBox(
                  height: height * .01,
                ),
                SizedBox(
                  width: width * .25,
                  height: height * .04,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConstants.colorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: onRate,
                    child: Text(
                      'RATE ORDER',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                SizedBox(
                  width: width * .25,
                  height: height * .04,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConstants.colorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: onCancel,
                    child: Text(
                      'CANCEL ORDER',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _downloadAPK() async {
  const launchUri =
      'https://shoppingapps.s3.ap-south-1.amazonaws.com/swacchLife1-release.apk';
  await launchUrl(Uri.parse(launchUri));
}
