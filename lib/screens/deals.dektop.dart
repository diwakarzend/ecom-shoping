import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

import '../routes/router.gr.dart';

class DealsScreendesktop extends StatefulWidget {
  final bool fromCart;

  const DealsScreendesktop({super.key, this.fromCart = false});

  @override
  State<DealsScreendesktop> createState() => _DealsScreendesktopState();
}

class _DealsScreendesktopState extends State<DealsScreendesktop> {
  int trialIndex = 0;

  List<String> _banners = [
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66b5bf26e88c9.jpg',
    'https://d3r50zdh245qd1.cloudfront.net/storage/photos/63976a676aba4031c062e5b2/Banners/66b5bf26e89c1.jpg'
  ];

  final CartHelper _cartHelper = CartHelper();
  int selectedPage = 1;
  bool gridview = true;
  Brand? selectedBrand;
  Category? selectedCategory;

  bool supportExpanded = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          selectedPage++;
        });
      }
    });
    super.initState();
  }

  Future<void> addFirebaseAnalyticsHotProducts(AppProvider provider) async {
    await FirebaseAnalytics.instance.logViewItemList(
      itemListId: 'hot deal store',
      itemListName: 'Hot Deal Products',
      items: List<AnalyticsEventItem>.from(provider.dealProducts.map((x) => x.toGAP())),
    );
  }

  List<Product> generateList(AppProvider provider, int page) {
    int count = 60;
    List<Product> products = provider.dealProducts;

    if (selectedBrand != null) {
      products = products.where((p) => p.brandId == selectedBrand!.id).toList();
    }
    if (trialIndex > 0) {
      products = products.where((p) => p.category?.id == provider.dealCategories[trialIndex - 1].id).toList();
    }

    return products.length > (count * page) ? products.take(count * page).toList() : products;
  }

  List<Product> filteredProducts(AppProvider provider, int page) {
    return generateList(provider, page)
        .where((product) => product.sub_category == "66b5d3474030aca39c0f1162")
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        addFirebaseAnalyticsHotProducts(provider);
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            primary: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopAppBar(),
                if (provider.banners
                    .where((element) => element.type == StringConstants.referBanner && element.deviceType == StringConstants.deviceTypeD)
                    .isNotEmpty)
                  CarouselSlider(
                    items: _banners
                        .map(
                          (e) => ClipRRect(
                        child: CustomNetworkImage(
                          imageUrl: e,
                          width: width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        .toList(),
                    options: CarouselOptions(
                      disableCenter: true,
                      viewportFraction: 1,
                      height: height * .8,
                      autoPlay: true,
                    ),
                  ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.symmetric(vertical: height * .05),
                    scrollDirection: Axis.vertical,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: filteredProducts(provider, selectedPage).length,
                    itemBuilder: (BuildContext context, int index) {
                      final Product product = filteredProducts(provider, selectedPage)[index];
                      return DealItemDesktop(
                        key: Key(product.id),
                        product: product,
                        onProductClick: () => _cartHelper.productClick(
                          context: context,
                          productId: product.id,
                          productType: product.productType,
                          provider: provider,
                        ),
                        onAddToCart: () => _cartHelper.addToCart(
                          provider: provider,
                          context: context,
                          productId: product.id,
                        ),
                        provider: provider,
                        cartHelper: _cartHelper,
                        gridView: true,
                        sub_category: '',
                        category: '',
                      );
                    },
                  ),
                ),
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
