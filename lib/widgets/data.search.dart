/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    List<Product> products = [];
    products.addAll(provider.miniProducts);
    products.addAll(provider.dealProducts);
    products.addAll(provider.sampleProducts);
    // products.addAll(provider.rewardProducts);
    final suggestionList = products
        .where((p) =>
            p.name.toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
            p.brand != null && p.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
            p.tags.any((element) => element.toLowerCase().contains(query.toLowerCase())))
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (Device.width >= 1024) ? MediaQuery.of(context).size.width * .12 : 20, vertical: 20),
      child: GridView.count(
        crossAxisCount: (Device.width >= 1024) ? 5 : 2,
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: (Device.width >= 1024) ? 0.6 : 0.55,
        children: [
          if (query.isNotEmpty) ...suggestionList.map((e) => ProductCard(product: e)),
        ],
      ),
    );
  }
}
