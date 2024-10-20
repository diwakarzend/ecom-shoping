import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SampleWishItems extends StatelessWidget {
  final WishlistItem product;
  final AppProvider provider;
  final CartHelper cartHelper;
  final Function() onProductClick;
  final Function() onTry;
  final bool gridView;

  const SampleWishItems({
    super.key,
    required this.product,
    required this.onProductClick,
    required this.onTry,
    required this.provider,
    required this.cartHelper,
    required this.gridView,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onProductClick(),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.only(right: gridView ? 0 : 10),
            decoration: BoxDecoration(
              color: ColorConstants.colorSample,
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
                      fit: BoxFit.cover,
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
                        product.brand.name,
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        product.name,
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorBlackFour,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Worth Rs.${product.mrp}',
                        style: TextHelper.extraSmallTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: cartHelper.ratingCalculationWishlist(provider, product) > 0
                                    ? ColorConstants.colorStar
                                    : ColorConstants.colorBlackTwo.withOpacity(0.3),
                                size: 25,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                cartHelper.ratingCalculationWishlist(provider, product).toStringAsFixed(1),
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => onTry(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorBlueEighteen,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                'Try +',
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 15,
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
    );
  }
}
