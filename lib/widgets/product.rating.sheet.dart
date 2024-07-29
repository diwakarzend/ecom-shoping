/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';

class ProductRatingSheet extends StatefulWidget {
  final OrderItem product;
  final Function(double rating, String review) onSubmit;

  const ProductRatingSheet({
    super.key,
    required this.product,
    required this.onSubmit,
  });

  @override
  State<ProductRatingSheet> createState() => _ProductRatingSheetState();
}

class _ProductRatingSheetState extends State<ProductRatingSheet> {
  TextEditingController controller = TextEditingController();
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: Container(
              height: 5,
              width: width * .15,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: height * .02),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomNetworkImage(
                imageUrl: widget.product.image,
                width: width * .2,
                height: width * .2,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  widget.product.name,
                  style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          SizedBox(height: height * .01),
          Divider(
            color: ColorConstants.colorGrey.withOpacity(0.5),
          ),
          SizedBox(height: height * .01),
          const Text('How would you rate this product?'),
          SizedBox(height: height * .01),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 25,
            itemPadding: EdgeInsets.zero,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: ColorConstants.colorStar,
            ),
            onRatingUpdate: (r) {
              rating = r;
              setState(() {});
            },
          ),
          SizedBox(height: height * .01),
          const Text('Review (optional)'),
          SizedBox(height: height * .01),
          Container(
            width: width,
            height: height * .06,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorConstants.colorGrey.withOpacity(0.5)),
            ),
            child: TextField(
              controller: controller,
              expands: true,
              style: TextHelper.smallTextStyle,
              maxLines: null,
              minLines: null,
              decoration: InputDecoration(
                hintText: 'Write something...',
                border: InputBorder.none,
                isDense: true,
                hintStyle: TextHelper.smallTextStyle,
              ),
            ),
          ),
          SizedBox(height: height * .02),
          InkWell(
            onTap: () {
              if (rating > 0) {
                context.popRoute();
                widget.onSubmit(rating, controller.text);
              }
            },
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Container(
              width: width,
              height: height * .05,
              decoration: BoxDecoration(
                color: ColorConstants.colorPrimary,
                borderRadius: BorderRadius.circular(height * .05),
              ),
              alignment: Alignment.center,
              child: Text(
                'Submit',
                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: height * .02),
        ],
      ),
    );
  }
}
