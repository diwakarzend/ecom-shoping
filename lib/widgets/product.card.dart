/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  final CartHelper _cartHelper = CartHelper();

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    switch (product.productType) {
      case StringConstants.trialProduct:
        return Consumer<AppProvider>(
          builder: (context, provider, _) {
            return Device.width > 1024
                ? MiniItemDesktop(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, provider: provider, productType: product.productType, productId: product.id);
                    },
                    onProductTry: () {
                      _cartHelper.tryNow(provider: provider, context: context, productId: product.id);
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  )
                : MiniItems(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, provider: provider, productType: product.productType, productId: product.id);
                    },
                    onProductTry: () {
                      _cartHelper.tryNow(provider: provider, context: context, productId: product.id);
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  );
          },
        );
      case StringConstants.brandStoreProduct:
        return Consumer<AppProvider>(
          builder: (context, provider, _) {
            return Device.width > 1024
                ? SampleItemDesktop(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, provider: provider, productType: product.productType, productId: product.id);
                    },
                    onTry: () {
                      _cartHelper.applyToTry(
                        provider: provider,
                        context: context,
                        productId: product.id,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      );
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  )
                : SampleItems(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, provider: provider, productType: product.productType, productId: product.id);
                    },
                    onTry: () {
                      _cartHelper.applyToTry(
                        provider: provider,
                        context: context,
                        productId: product.id,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      );
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  );
          },
        );
      default:
        return Consumer<AppProvider>(
          builder: (context, provider, _) {
            return Device.width > 1024
                ? DealItemDesktop(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, provider: provider, productType: product.productType, productId: product.id);
                    },
                    onAddToCart: () {
                      _cartHelper.addToCart(provider: provider, context: context, productId: product.id);
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  )
                : DealItems(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, provider: provider, productType: product.productType, productId: product.id);
                    },
                    onAddToCart: () {
                      _cartHelper.addToCart(provider: provider, context: context, productId: product.id);
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  );
          },
        );
    }
  }
}
