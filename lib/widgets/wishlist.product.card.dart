import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/deal.wish.desktop.item.dart';
import 'package:fabpiks_web/widgets/deal.wish.item.dart';
import 'package:fabpiks_web/widgets/sample.wish.item.dart';
import 'package:fabpiks_web/widgets/sample.wish.item.desktop.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WishlistProductCard extends StatelessWidget {
  final WishlistItem product;

  final CartHelper _cartHelper = CartHelper();

  WishlistProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    switch (product.productType) {
      case StringConstants.trialProduct:
        return Consumer<AppProvider>(
          builder: (context, provider, _) {
            return Device.width > 1024
                ? MiniWishItemDesktop(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, productId: product.productId, productType: product.productType, provider: provider);
                    },
                    onProductTry: () {
                      _cartHelper.tryNow(provider: provider, context: context, productId: product.productId);
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  )
                : MiniWishItems(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, productId: product.productId, productType: product.productType, provider: provider);
                    },
                    onProductTry: () {
                      _cartHelper.tryNow(provider: provider, context: context, productId: product.productId);
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
                ? SampleWishItemDesktop(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, productId: product.productId, productType: product.productType, provider: provider);
                    },
                    onTry: () {
                      _cartHelper.applyToTry(
                        provider: provider,
                        context: context,
                        productId: product.productId,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      );
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  )
                : SampleWishItems(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, productId: product.productId, productType: product.productType, provider: provider);
                    },
                    onTry: () {
                      _cartHelper.applyToTry(
                        provider: provider,
                        context: context,
                        productId: product.productId,
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
                ? DealWishItemDesktop(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, productId: product.productId, productType: product.productType, provider: provider);
                    },
                    onAddToCart: () {
                      _cartHelper.addToCart(provider: provider, context: context, productId: product.productId);
                    },
                    provider: provider,
                    cartHelper: _cartHelper,
                    gridView: true,
                  )
                : DealWishItems(
                    product: product,
                    onProductClick: () {
                      _cartHelper.productClick(context: context, productId: product.productId, productType: product.productType, provider: provider);
                    },
                    onAddToCart: () {
                      _cartHelper.addToCart(provider: provider, context: context, productId: product.productId);
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
