/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  final Function() onTap;
  final Category category;

  const CategoryItems(
    Key key, {
    required this.onTap,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * .15,
            height: width * .15,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: category.icon != null
                ? CustomNetworkImage(
                    imageUrl: category.icon ?? '',
                    width: width * .15,
                    height: width * .15,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          const SizedBox(height: 10),
          Text(
            category.name,
            style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w600, color: ColorConstants.colorGreyThree),
          ),
        ],
      ),
    );
  }
}
