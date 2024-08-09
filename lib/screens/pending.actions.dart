import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/models.dart';

@RoutePage(name: 'PendingActionsRoute')
class PendingActions extends StatefulWidget {
  const PendingActions({super.key});

  @override
  State<PendingActions> createState() => _PendingActionsState();
}

class _PendingActionsState extends State<PendingActions> {
  bool approvalExpanded = false, feedbackExpanded = false, offersExpanded = false;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh(AppProvider provider) async {
    provider.initWithLogin();
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            title: const Text(
              'Pending Actions',
            ),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: () => _onRefresh(provider),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * .03),
                  InkWell(
                    onTap: () {
                      setState(() {
                        approvalExpanded = !approvalExpanded;
                      });
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
                              !provider.currentUser!.orders
                                  .any((e) => e.products.any((o) => o.id == element.product?.id)))
                          .isNotEmpty,
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
                        style: TextHelper.subTitleStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      badgeStyle: const BadgeStyle(
                        padding: EdgeInsets.all(10),
                      ),
                      position: BadgePosition.topEnd(
                        top: -20,
                        end: 20,
                      ),
                      child: Container(
                        width: width,
                        height: height * .06,
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: ColorConstants.colorGreyNine,
                          borderRadius: BorderRadius.circular(height * .07),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Select Approvals',
                              style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                            ),
                            Icon(
                              approvalExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                              color: ColorConstants.colorBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (approvalExpanded &&
                      provider.reports
                          .where((element) => element.productId != null && element.qualified && !element.rejected)
                          .isEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'No approvals showing \nPull Down To Refresh',
                        textAlign: TextAlign.center,
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  if (approvalExpanded)
                    ...provider.reports
                        .where((element) =>
                            element.product != null &&
                            element.product!.stock > 0 &&
                            element.productId != null &&
                            element.qualified &&
                            !element.rejected &&
                            provider.currentUser != null &&
                            !provider.currentUser!.orders
                                .any((e) => e.products.any((o) => o.id == element.product?.id)))
                        .map(
                      (e) {
                        return Container(
                          width: width,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorGreenSix,
                            borderRadius: BorderRadius.circular(height * .04),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(4, 0),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomNetworkImage(
                                imageUrl: e.product?.image ?? '',
                                width: width * .14,
                                height: width * .14,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      maxLines: 3,
                                      TextSpan(
                                        text: e.product?.brand != null ? e.product?.brand!.name : '',
                                        style: TextHelper.extraSmallTextStyle.copyWith(
                                            color: ColorConstants.colorGreyThree, fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: ' ${e.product?.name ?? ''}',
                                            style: TextHelper.extraSmallTextStyle.copyWith(
                                                fontWeight: FontWeight.w500, color: ColorConstants.colorGreyThree),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      (e.product?.serviceCharge ?? 0) > 0
                                          ? 'Service Fee ${StringConstants.rupeeSign}${e.product?.serviceCharge ?? ''}'
                                          : 'Free',
                                      style: TextHelper.extraSmallTextStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (provider.currentUser != null &&
                                  provider.currentUser!.orders
                                      .where((element) => element.products.any((o) => o.id == e.product?.id))
                                      .isEmpty)
                                Container(
                                  width: 2,
                                  height: height * .04,
                                  // color: colorBlack,
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                ),
                              if (provider.currentUser != null &&
                                  provider.currentUser!.orders
                                      .where((element) => element.products.any((o) => o.id == e.product?.id))
                                      .isEmpty)
                                InkWell(
                                  onTap: () {
                                    if (e.product != null &&
                                        provider.cart != null &&
                                        !provider.cart!.records.any((element) => element.id == e.product?.id)) {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        builder: (c) => _Dialog(
                                          height: height,
                                          width: width,
                                          product: e.product!,
                                          onCheckout: () {
                                            provider.addCartItems(productID: e.productId ?? '');
                                            context.router.maybePop();
                                            context.router.push(const CartRoute());
                                          },
                                          onContinue: () {
                                            provider.addCartItems(productID: e.productId ?? '');
                                            context.router.popUntilRouteWithName(NavigatorRoute.name);
                                          },
                                        ),
                                      );
                                    } else {
                                      ScaffoldSnackBar.of(context).show('Already added to cart');
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Approved',
                                        style: TextHelper.smallTextStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstants.colorGreen,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.colorRedNine,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'Confirm to Receive',
                                          style: TextHelper.extraSmallTextStyle.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Confirm to Receive',
                                    style: TextHelper.extraSmallTextStyle.copyWith(
                                      color: Colors.transparent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        feedbackExpanded = !feedbackExpanded;
                      });
                    },
                    child: Container(
                      width: width,
                      height: height * .06,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: ColorConstants.colorGreyNine,
                        borderRadius: BorderRadius.circular(height * .07),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Feedback',
                            style: TextHelper.subTitleStyle.copyWith(
                              color: ColorConstants.colorBlack,
                            ),
                          ),
                          Icon(
                            feedbackExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                            color: ColorConstants.colorBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       offersExpanded = !offersExpanded;
                  //     });
                  //   },
                  //   child: Container(
                  //     width: width,
                  //     height: height * .06,
                  //     margin: const EdgeInsets.only(bottom: 20),
                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //     decoration: BoxDecoration(
                  //       color: colorGreyNine,
                  //       borderRadius: BorderRadius.circular(height * .07),
                  //     ),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.max,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           'Exclusive Offers!',
                  //           style: TextHelper.subTitleStyle.copyWith(
                  //             color: colorBlack,
                  //           ),
                  //         ),
                  //         Icon(
                  //           offersExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  //           color: colorBlack,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Dialog extends StatelessWidget {
  final double height;
  final double width;
  final Product product;
  final Function() onCheckout;
  final Function() onContinue;

  const _Dialog(
      {required this.height,
      required this.width,
      required this.product,
      required this.onCheckout,
      required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: width,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
                bottom: Radius.circular(10),
              ),
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: width,
                      padding: EdgeInsets.only(top: height * .02, bottom: height * .05, left: 20, right: 20),
                      margin: EdgeInsets.only(bottom: height * .09),
                      decoration: const BoxDecoration(
                        color: ColorConstants.colorPrimary,
                      ),
                      child: Text(
                        'Congratulations on your successful match!',
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: TextHelper.smallTextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        transform: Matrix4.translationValues(width * .38 - 20, 0, 0),
                        width: width * .24,
                        height: height * .12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.center,
                        child: CustomNetworkImage(
                          imageUrl: product.image,
                          width: width * .24,
                          height: height * .12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .02),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Your trial for ${product.name} has been approved. We look forward to your feedback and brand experience.',
                      maxLines: 1000,
                      textAlign: TextAlign.center,
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                if (product.serviceCharge > 0) SizedBox(height: height * .03),
                if (product.serviceCharge > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      TextSpan(
                        text: 'Note: ',
                        style: TextHelper.smallTextStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'An amount of ${StringConstants.rupeeSign}${product.serviceCharge} shall be payable towards service/delivery fee.',
                            style: TextHelper.smallTextStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: height * .03),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Please confirm your dispatch by clicking on the checkout button.',
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: onCheckout,
                  child: Container(
                    width: width * .35,
                    height: height * .055,
                    decoration: BoxDecoration(
                      color: ColorConstants.colorPrimary,
                      borderRadius: BorderRadius.circular(height * .06),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Checkout',
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: onContinue,
                  child: Container(
                    width: width * .5,
                    height: height * .055,
                    decoration: BoxDecoration(
                      color: ColorConstants.colorPrimary,
                      borderRadius: BorderRadius.circular(height * .06),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Continue Shopping',
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () => context.router.maybePop(),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xffEDEBEB),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.close_rounded,
                  color: Color(0xff606060),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
