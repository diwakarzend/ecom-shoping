import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/screens/screens.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../providers/providers.dart';
import 'appbar/bottom.app.bar.dart';

@RoutePage(name: 'ShoppingTabOneDesktop')
class ShoppingTabOneDesktop extends StatefulWidget {
  const ShoppingTabOneDesktop({super.key});

  @override
  State<ShoppingTabOneDesktop> createState() => _ShoppingTabOneDesktopState();
}

class _ShoppingTabOneDesktopState extends State<ShoppingTabOneDesktop> {
  final CartHelper _cartHelper = CartHelper();

  bool supportExpanded = false;
  // final CarouselController _miniController = CarouselController();
  // final CarouselController _dealController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
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
          body: (provider.cart?.count ?? 0) <= 0
              ? Container(
                  width: width,
                  height: height,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TopAppBar(),
                        SizedBox(height: height * .03),
                        Align(
                          child: Image.asset(
                            'assets/images/shooping_cart.png',
                            height: height * .3,
                          ),
                        ),
                        Text(
                          'Your Cart is empty!',
                          style:
                              TextHelper.smallTextStyle.copyWith(color: Colors.black.withOpacity(0.6), fontSize: 13.sp),
                        ),
                        SizedBox(height: height * .02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'This feels too light! Go on, add all your favourites.',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextHelper.extraSmallTextStyle,
                          ),
                        ),
                        SizedBox(height: height * .05),
                        InkWell(
                          onTap: () {
                            context.router.popUntilRouteWithName(HomeRoute.name);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.colorBlueEighteen,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            child: Text(
                              'Try Now',
                              style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: height * .06),
                        const BottomAppBarPage(),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopAppBar(),
                        SizedBox(height: height * .06),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .12),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Items in your cart',
                                style: TextHelper.smallTextStyle.copyWith(
                                  color: ColorConstants.colorBlack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * .02),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .12),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              if (provider.cart != null)
                                ...provider.cart!.records.map(
                                  (e) {
                                    switch (e.productType) {
                                      case StringConstants.trialProduct:
                                        return _TrialItem(
                                          key: Key(e.id),
                                          cartItem: e,
                                          provider: provider,
                                          onDelete: () {
                                            showDialog(
                                              context: context,
                                              builder: (c) => DeleteCartItem(
                                                product: e,
                                                remove: () {
                                                  context.router.maybePop();
                                                  provider.deleteCartItem(e.id);
                                                },
                                                move: () {
                                                  context.router.maybePop();
                                                  provider.moveCartItem(e.productId);
                                                },
                                              ),
                                            );
                                          },
                                          onClick: () {
                                            _cartHelper.productClick(
                                                context: context,
                                                provider: provider,
                                                productType: e.productType,
                                                productId: e.productId);
                                          },
                                        );
                                      case StringConstants.brandStoreProduct:
                                        return _SelectItems(
                                          cartItem: e,
                                          provider: provider,
                                          onDelete: () {
                                            showDialog(
                                              context: context,
                                              builder: (c) => DeleteCartItem(
                                                product: e,
                                                remove: () {
                                                  context.router.maybePop();
                                                  provider.deleteCartItem(e.id);
                                                },
                                                move: () {
                                                  context.router.maybePop();
                                                  provider.moveCartItem(e.productId);
                                                },
                                              ),
                                            );
                                          },
                                          onClick: () {
                                            _cartHelper.productClick(
                                                context: context,
                                                provider: provider,
                                                productType: e.productType,
                                                productId: e.productId);
                                          },
                                        );
                                      // case rewardStoreProduct:
                                      //   return _RewardItems(
                                      //     cartItem: e,
                                      //     provider: provider,
                                      //     onDelete: () {
                                      //       showModalBottomSheet(
                                      //         context: context,
                                      //         shape: const RoundedRectangleBorder(
                                      //           borderRadius: BorderRadius.vertical(
                                      //             top: Radius.circular(20),
                                      //           ),
                                      //         ),
                                      //         builder: (c) => DeleteCartItem(
                                      //           product: e,
                                      //           remove: () {
                                      //             context.router.maybePop();
                                      //             provider.deleteCartItem(e);
                                      //           },
                                      //           move: () {
                                      //             context.router.maybePop();
                                      //             provider.moveCartItem(e);
                                      //           },
                                      //         ),
                                      //       );
                                      //     },
                                      //     onClick: () {
                                      //       _cartHelper.productClick(context: context, product: e.toProduct());
                                      //     },
                                      //   );
                                      case StringConstants.noTrailProduct:
                                        return _NoTrialItem(
                                          cartItem: e,
                                          provider: provider,
                                          onDelete: () {
                                            provider.deleteCartItem(e.id);
                                          },
                                        );
                                      case StringConstants.hotDealProduct:
                                        return _HotItems(
                                          cartItem: e,
                                          provider: provider,
                                          onDelete: () {
                                            showDialog(
                                              context: context,
                                              builder: (c) => DeleteCartItem(
                                                product: e,
                                                remove: () {
                                                  context.router.maybePop();
                                                  provider.deleteCartItem(e.id);
                                                },
                                                move: () {
                                                  context.router.maybePop();
                                                  provider.moveCartItem(e.productId);
                                                },
                                              ),
                                            );
                                          },
                                          onClick: () {
                                            _cartHelper.productClick(
                                                context: context,
                                                provider: provider,
                                                productType: e.productType,
                                                productId: e.productId);
                                          },
                                        );
                                      case StringConstants.surprisedProduct:
                                        return _SurpriseTrialItem(
                                          cartItem: e,
                                          provider: provider,
                                        );
                                      default:
                                        return const SizedBox.shrink();
                                    }
                                  },
                                ),
                            ],
                          ),
                        ),
                        if (provider.cart != null &&
                            provider.cart!.records
                                    .where((element) => element.productType == StringConstants.trialProduct)
                                    .length >=
                                provider.appSettings!.generalSettings.itemQty)
                          if (provider.noTrailProducts.isNotEmpty &&
                              provider.cart!.records
                                      .where((element) => element.productType == StringConstants.noTrailProduct)
                                      .length <
                                  (provider.appSettings?.generalSettings.samplesLimit ?? 2))
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              margin: EdgeInsets.symmetric(horizontal: width * .12),
                              child: Text(
                                'Bonus Trial Offers',
                                style: TextHelper.normalTextStyle
                                    .copyWith(color: ColorConstants.colorBlack, fontWeight: FontWeight.w700),
                              ),
                            ),
                        if (provider.cart != null &&
                            provider.cart!.records
                                    .where((element) => element.productType == StringConstants.trialProduct)
                                    .length >=
                                provider.appSettings!.generalSettings.itemQty)
                          if (provider.noTrailProducts.isNotEmpty &&
                              provider.cart!.records
                                      .where((element) => element.productType == StringConstants.noTrailProduct)
                                      .length <
                                  (provider.appSettings?.generalSettings.samplesLimit ?? 2))
                            SizedBox(height: height * .01),
                        if (provider.cart != null &&
                            provider.cart!.records
                                    .where((element) => element.productType == StringConstants.trialProduct)
                                    .length >=
                                provider.appSettings!.generalSettings.itemQty)
                          if (provider.noTrailProducts.isNotEmpty &&
                              provider.cart!.records
                                      .where((element) => element.productType == StringConstants.noTrailProduct)
                                      .length <
                                  (provider.appSettings?.generalSettings.samplesLimit ?? 2))
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width * .12),
                              padding: EdgeInsets.only(bottom: height * .02),
                              child: Text(
                                'Exclusively for you! Choose upto 2 items, 100% FREE',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle
                                    .copyWith(color: ColorConstants.colorGreySeven, fontWeight: FontWeight.w600),
                              ),
                            ),
                        if (provider.cart != null &&
                            provider.cart!.records
                                    .where((element) => element.productType == StringConstants.trialProduct)
                                    .length >=
                                provider.appSettings!.generalSettings.itemQty)
                          if (provider.noTrailProducts.isNotEmpty &&
                              provider.cart!.records
                                      .where((element) => element.productType == StringConstants.noTrailProduct)
                                      .length <
                                  (provider.appSettings?.generalSettings.samplesLimit ?? 2))
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width * .12),
                              // padding: EdgeInsets.only(bottom: height * .01),
                              child: CarouselSlider(
                                items: provider.noTrailProducts
                                    .map(
                                      (e) => _BonusItems(product: e, provider: provider),
                                    )
                                    .toList(),
                                options: CarouselOptions(
                                  // aspectRatio: 1.3,
                                  // viewportFraction: 0.47,
                                  // initialPage: 0,
                                  // enableInfiniteScroll: false,
                                  // reverse: false,
                                  // disableCenter: true,
                                  // padEnds: false,
                                  aspectRatio: 3.4,
                                  viewportFraction: .2,
                                  // viewportFraction: 0.15,
                                  initialPage: 0,
                                  enableInfiniteScroll: false,
                                  reverse: false,
                                  disableCenter: true,
                                  padEnds: false,
                                  autoPlay: true,
                                ),
                              ),
                            ),
                        SizedBox(height: height * .04),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .12),
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => context.router.push(const CouponRoute()),
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            child: Container(
                              width: width * .3,
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorBlueEighteen,
                                borderRadius: BorderRadius.circular(height * .06),
                                border: Border.all(
                                  color: ColorConstants.colorBlueEighteen,
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                leading: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Align(
                                    child: Icon(
                                      Icons.local_offer_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  'Coupons & Offers',
                                  style: TextHelper.normalTextStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * .02),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .12),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Details',
                                style:
                                    TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * .015),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .12),
                          alignment: Alignment.center,
                          child: const Divider(
                            color: ColorConstants.colorGreyTwo,
                          ),
                        ),
                        SizedBox(height: height * .02),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.trialProduct)
                                .isNotEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * .12),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Shop Mini - Service Fee (${provider.cart?.charges.miniItemQuantity} ${(provider.cart?.charges.miniItemQuantity ?? 0) > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.serviceCharge.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp),
                                ),
                              ],
                            ),
                          ),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.trialProduct)
                                .isNotEmpty &&
                            provider.cart!.records
                                    .where((element) => element.productType == StringConstants.trialProduct)
                                    .length >
                                provider.appSettings!.generalSettings.itemQty)
                          SizedBox(height: height * .02),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.trialProduct)
                                .isNotEmpty &&
                            provider.cart!.records
                                    .where((element) => element.productType == StringConstants.trialProduct)
                                    .length >
                                provider.appSettings!.generalSettings.itemQty)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * .12),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Shop Mini - Addon Product Fee (${provider.cart?.charges.addonQuantity} ${(provider.cart?.charges.addonQuantity ?? 0) > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.addonUnitPrice.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.brandStoreProduct)
                                .isNotEmpty)
                          SizedBox(height: height * .02),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.brandStoreProduct)
                                .isNotEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * .12),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Free Sample - Service Fee (${provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).length} ${provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).length > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.bounsServiceCharge.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.hotDealProduct)
                                .isNotEmpty)
                          SizedBox(height: height * .02),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.hotDealProduct)
                                .isNotEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * .12),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Products (${_cartHelper.hotDealCount(provider)} ${_cartHelper.hotDealCount(provider) > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.hotDealsCharge.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.noTrailProduct)
                                .isNotEmpty)
                          SizedBox(height: height * .02),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .where((element) => element.productType == StringConstants.noTrailProduct)
                                .isNotEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * .12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bonus Trials(${provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length} ${provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  'FREE',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: height * .02),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .12),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'SubTotal',
                                style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
                              ),
                              Text(
                                '\u{20B9}${provider.cart?.charges.subTotalWithoutDiscount.toStringAsFixed(2)}',
                                style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        if (provider.coupon != null) SizedBox(height: height * .02),
                        if (provider.coupon != null)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * .12),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    provider.removeCoupon();
                                  },
                                  child: Tooltip(
                                    message: 'Remove Coupon',
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Coupon Applied',
                                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                        ),
                                        const Icon(
                                          Icons.close,
                                          size: 17,
                                          color: ColorConstants.colorRed,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.discount.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: height * .02),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .12),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total',
                                style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
                              ),
                              Text(
                                '\u{20B9}${provider.cart?.charges.grandTotal.toStringAsFixed(2)}',
                                style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * .05),
                        if (provider.cart != null &&
                            provider.cart!.records
                                .any((element) => element.productType == StringConstants.trialProduct))
                          if (provider.cart!.records
                                  .where((element) => element.productType == StringConstants.trialProduct)
                                  .length >=
                              provider.appSettings!.generalSettings.itemQty)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width * .12),
                              alignment: Alignment.center,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () => context.router.push(const ShoppingTabTwoDesktop()),
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    width: width * .3,
                                    height: height * .06,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorBlueEighteen,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Check out',
                                      style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width * .12),
                              alignment: Alignment.center,
                              child: Align(
                                child: Text(
                                  'Add more ${provider.appSettings!.generalSettings.itemQty - provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length} for checkout',
                                  style: TextHelper.smallTextStyle.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                        else
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width * .12),
                            alignment: Alignment.center,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () => context.router.push(const ShoppingTabTwoDesktop()),
                                splashFactory: NoSplash.splashFactory,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  width: width * .4,
                                  height: height * .06,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.colorPrimary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Check out',
                                    style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: height * .02),
                        Container(
                          margin: EdgeInsets.only(right: width * .18),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Note : All Prices Are Inclusive of GST',
                            maxLines: 2,
                            textAlign: TextAlign.right,
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: height * .1),
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

class _HotItems extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;
  final Function() onDelete;
  final Function() onClick;

  const _HotItems({
    required this.cartItem,
    required this.provider,
    required this.onDelete,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => onClick(),
            child: CustomNetworkImage(
              imageUrl: cartItem.image,
              width: width * .1,
              height: width * .1,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Deals store)',
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '${StringConstants.rupeeSign}${cartItem.mrp}',
                      style: TextHelper.extraSmallTextStyle
                          .copyWith(fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough),
                    ),
                    Container(
                      width: 5,
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      color: ColorConstants.colorBlack,
                    ),
                    Text(
                      '${StringConstants.rupeeSign}${cartItem.salePrice}',
                      style: TextHelper.extraSmallTextStyle.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => provider.removeCartItems(cartItem.productId),
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.colorRedFive,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '-',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    Text(
                      provider.cart != null && provider.cart!.records.any((element) => element.id == cartItem.id)
                          ? provider.cart!.records
                              .firstWhere((element) => element.id == cartItem.id)
                              .quantity
                              .toString()
                          : '0',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w400),
                    ),
                    InkWell(
                      onTap: () => provider.addCartItems(productID: cartItem.productId),
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.colorGreenFour,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '+',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onDelete,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/trash_can.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(ColorConstants.colorBlack.withOpacity(0.5), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectItems extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;
  final Function() onDelete;
  final Function() onClick;

  const _SelectItems({
    required this.cartItem,
    required this.provider,
    required this.onDelete,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => onClick(),
            child: CustomNetworkImage(
              imageUrl: cartItem.image,
              width: width * .1,
              height: width * .1,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Free Sample)',
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: cartItem.salePrice > 0 ? ColorConstants.colorBlack : ColorConstants.colorGreenTwo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onDelete,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/trash_can.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(ColorConstants.colorBlack.withOpacity(0.5), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoTrialItem extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;
  final Function() onDelete;

  const _NoTrialItem({
    required this.cartItem,
    required this.provider,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomNetworkImage(
            imageUrl: cartItem.image,
            width: width * .1,
            height: width * .1,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Bonus store)',
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'FREE',
                      style: TextHelper.smallTextStyle
                          .copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreenTwo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onDelete,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/trash_can.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(ColorConstants.colorBlack.withOpacity(0.5), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrialItem extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;
  final Function() onDelete;
  final Function() onClick;

  const _TrialItem({
    super.key,
    required this.cartItem,
    required this.provider,
    required this.onDelete,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => onClick(),
            child: CustomNetworkImage(
              imageUrl: cartItem.image,
              width: width * .1,
              height: width * .1,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Shop Mini)',
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp),
                ),
                // const SizedBox(height: 5),
                // Row(
                //   children: [
                //     Text(
                //       '${cartItem.trialPoint} points used',
                //       style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.transparent, fontSize: 13.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onDelete,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/trash_can.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(ColorConstants.colorBlack.withOpacity(0.5), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BonusItems extends StatelessWidget {
  final Product product;
  final AppProvider provider;

  const _BonusItems({required this.product, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: ColorConstants.colorPinkTwo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomNetworkImage(
                    imageUrl: product.image,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.brand?.name ?? '',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      product.name,
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.colorBlackFour,
                        fontSize: 12.sp,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Worth Rs.${product.mrp}',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                    // const SizedBox(height: 3),
                    // Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Text(
                    //         'Rating ${product.review}',
                    //         style: TextHelper.extraSmallTextStyle.copyWith(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 8.sp,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Checkbox(
          visualDensity: VisualDensity.comfortable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          value: provider.cart != null &&
              provider.cart!.records
                  .any((element) => element.productType == StringConstants.noTrailProduct && element.id == product.id),
          onChanged: (v) {
            if (v != null && v) {
              // if (provider.currentUser != null &&
              //     provider.currentUser!.orders
              //             .where((element) =>
              //                 element.status.toLowerCase() != 'cancelled' &&
              //                 element.products.any((p) => p.id == e.id))
              //             .length <
              //         e.maximumQty) {
              if (provider.cart != null &&
                  provider.cart!.records
                          .where((element) => element.productType == StringConstants.noTrailProduct)
                          .length <
                      (provider.appSettings?.generalSettings.samplesLimit ?? 2)) {
                provider.addCartItems(productID: product.id);
              } else {
                ScaffoldSnackBar.of(context).show(
                    'Oops you are eligible for ${(provider.appSettings?.generalSettings.samplesLimit ?? 2)} Bonus trials');
              }
              // } else {
              //   showSnackBar(
              //       context: context,
              //       content: 'Sorry! You have already availed this product.');
              // }
            } else {
              if (provider.cart != null && provider.cart!.records.any((element) => element.id == product.id)) {
                provider.deleteCartItem(product.id);
              }
            }
          },
        ),
      ],
    );
  }
}

class _SurpriseTrialItem extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;

  const _SurpriseTrialItem({
    required this.cartItem,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomNetworkImage(
            imageUrl: cartItem.image,
            width: width * .1,
            height: width * .1,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Surprised Product)',
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'FREE',
                      style: TextHelper.smallTextStyle
                          .copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreenTwo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
