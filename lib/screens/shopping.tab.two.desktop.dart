/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar/bottom.app.bar.dart';

@RoutePage(name: 'ShoppingTabTwoDesktop')
class ShoppingTabTwoDesktop extends StatefulWidget {
  const ShoppingTabTwoDesktop({
    super.key,
  });

  @override
  State<ShoppingTabTwoDesktop> createState() => _ShoppingTabTwoDesktopState();
}

class _ShoppingTabTwoDesktopState extends State<ShoppingTabTwoDesktop> {
  bool paymentExpanded = true;
  Shipping? selectedAddress;

  late AppProvider _appProvider;

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    if (_appProvider.currentUser != null && _appProvider.currentUser!.shipping.length == 1) {
      Future.delayed(const Duration(seconds: 0)).then((value) => selectedAddress = _appProvider.currentUser!.shipping.first);
    }
    super.initState();
  }

  bool supportExpanded = false;

  final CartHelper _cartHelper = CartHelper();

  @override
  Widget build(BuildContext context) {
    _appProvider = Provider.of<AppProvider>(context, listen: true);
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
          body: Container(
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
                  if (provider.currentUser != null)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * .12),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ...provider.currentUser!.shipping.map(
                            (e) => Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          e.shippingName,
                                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Radio<Shipping>(
                                        value: e,
                                        toggleable: true,
                                        visualDensity: VisualDensity.adaptivePlatformDensity,
                                        groupValue: selectedAddress,
                                        onChanged: (v) {
                                          setState(() {
                                            selectedAddress = v;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * .01),
                                  Text(
                                    e.shippingAddress,
                                    maxLines: 5,
                                    style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '${e.shippingCity}, ${e.shippingState} ${e.shippingPincode}',
                                    maxLines: 5,
                                    style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          context.router.push(EditAddressRoute(shipping: e));
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: ColorConstants.colorPrimaryTwo,
                                          textStyle: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Text(
                                          'Change/Edit',
                                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.router.push(AddAddressRoute(fromCart: true));
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: ColorConstants.colorPrimaryTwo,
                                          textStyle: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Text(
                                          'Add New Address',
                                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (provider.currentUser != null && provider.currentUser!.shipping.isEmpty)
                    Align(
                      alignment: Alignment.topCenter,
                      child: TextButton(
                        style: TextButton.styleFrom(foregroundColor: ColorConstants.colorPrimary),
                        onPressed: () {
                          context.router.push(AddAddressRoute(fromCart: true));
                        },
                        child: Text(
                          'Add New Address ${provider.currentUser?.shipping.length}',
                          style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: height * .02),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        if (selectedAddress != null) {
                          context.router.push(
                            ShoppingTabThreeDesktop(
                              addressId: selectedAddress!.id,
                            ),
                          );
                        } else {
                          ScaffoldSnackBar.of(context).show('Please select shipping address');
                        }
                      },
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: width * .2,
                        height: height * .06,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: ColorConstants.colorBlueEighteen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Continue',
                          style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                        ),
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
