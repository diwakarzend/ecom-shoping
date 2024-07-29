import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DealWishItemDesktop extends StatelessWidget {
  final bool gridView;
  final AppProvider provider;
  final CartHelper cartHelper;
  final WishlistItem product;
  final Function() onProductClick;
  final Function() onAddToCart;

  const DealWishItemDesktop({
    super.key,
    required this.product,
    required this.onProductClick,
    required this.onAddToCart,
    required this.provider,
    required this.cartHelper,
    required this.gridView,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onProductClick(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(right: gridView ? 0 : 10),
        decoration: BoxDecoration(
          color: ColorConstants.colorDeal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CustomNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: IconButton(
                      iconSize: 25,
                      onPressed: () async {
                        cartHelper.addToWishList(provider: provider, context: context, productId: product.productId);
                      },
                      icon: provider.wishlist != null && provider.wishlist!.records.any((element) => element.productId == product.productId)
                          ? const Icon(
                              Ionicons.heart,
                              color: Colors.red,
                            )
                          : Icon(
                              Ionicons.heart_outline,
                              color: ColorConstants.colorBlackTwo.withOpacity(0.5),
                            ),
                    ),
                  ),
                ],
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
                    product.brand.name,
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    style: TextHelper.normalTextStyle.copyWith(
                      fontSize: 12.sp,
                      color: ColorConstants.colorBlackFour,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        'Worth',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Rs.${product.mrp}',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12.sp,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Rs.${product.salePrice}',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () => onAddToCart(),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstants.colorBlueEighteen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      alignment: Alignment.center,
                      child: Text(
                        'Add to Cart',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
