/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:provider/provider.dart';

@RoutePage(name: 'RatingRoute')
class RatingScreen extends StatefulWidget {
  final Product product;

  const RatingScreen({super.key, required this.product});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Product Reviews'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: provider.feedbacks.where((element) => element.productId == widget.product.id && element.review.isNotEmpty).length,
          itemBuilder: (BuildContext context, int index) {
            final Feedback e = provider.feedbacks.where((element) => element.productId == widget.product.id && element.review.isNotEmpty).toList()[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.colorSample,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name ?? (e.user?.firstName ?? ''),
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.colorBlackTwo,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      e.review,
                      maxLines: 100,
                      style: TextHelper.normalTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.colorGreyTwenty,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
