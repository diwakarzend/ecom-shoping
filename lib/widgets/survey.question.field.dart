/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:io';

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SurveyQuestionField extends StatelessWidget {
  final SurveyQuestion question;
  final SurveyAnswer answer;
  final Function(String? value) onDropDownChanged;
  final Function(List<String> values) onMultiChoiceChanged;
  final Function(String? value) onTextFieldChanged;
  final Function(double value) onRatingChanged;
  final Function() onImageTap;

  const SurveyQuestionField({
    super.key,
    required this.question,
    required this.answer,
    required this.onDropDownChanged,
    required this.onMultiChoiceChanged,
    required this.onTextFieldChanged,
    required this.onRatingChanged,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (question.survayType == StringConstants.singleChoiceQuestion) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: const Text(
              'Select You Answer',
            ),
            style: (Device.width >= 1024)
                ? TextHelper.smallTextStyle.copyWith(
                    color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
                  )
                : TextHelper.normalTextStyle.copyWith(
                    color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
                  ),
            underline: const SizedBox.shrink(),
            value: answer.answer,
            items: question.data?.option
                .asMap()
                .map(
                  (i, o) => MapEntry(
                    i,
                    DropdownMenuItem<String>(
                      value: o,
                      child: Text(
                        o,
                        style: (Device.width >= 1024)
                            ? TextHelper.smallTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.4),
                              )
                            : TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.4),
                              ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
            onChanged: onDropDownChanged,
          ),
        ),
      );
    } else if (question.survayType == StringConstants.multiChoiceQuestion) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(bottom: 20),
        child: MultiSelectDialogField(
          items: [
            ...question.data!.option.map(
              (e) => MultiSelectItem<String>(e, e),
            ),
          ],
          title: Text('Select  an option', style: (Device.width >= 1024) ? TextHelper.smallTextStyle : TextHelper.normalTextStyle),
          selectedColor: Colors.blue,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          buttonText: Text(
            'Select  an option',
            style: (Device.width >= 1024)
                ? TextHelper.smallTextStyle.copyWith(color: Colors.blue[800])
                : TextHelper.normalTextStyle.copyWith(color: Colors.blue[800]),
            // style: TextStyle(
            //   color: Colors.blue[800],
            //   fontSize: 16,
            // ),
          ),
          onConfirm: onMultiChoiceChanged,
        ),
      );
    } else if (question.survayType == StringConstants.ratingQuestion) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: RatingBar.builder(
          initialRating: 0,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30,
          itemPadding: EdgeInsets.zero,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: ColorConstants.colorStar,
          ),
          onRatingUpdate: onRatingChanged,
        ),
      );
    } else if (question.survayType == StringConstants.subjectiveQuestion) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 20),
        child: TextField(
          style: (Device.width >= 1024)
              ? TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreenTwo)
              : TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreenTwo),
          onChanged: onTextFieldChanged,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: 'Type your answer',
            hintStyle: (Device.width >= 1024)
                ? TextHelper.smallTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo.withOpacity(0.6),
                  )
                : TextHelper.normalTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo.withOpacity(0.6),
                  ),
            border: InputBorder.none,
          ),
        ),
      );
    } else if (question.survayType == StringConstants.uploadImageQuestion) {
      return Container(
        width: width,
        height: height * .25,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        child: InkWell(
          onTap: onImageTap,
          child: answer.answer != null
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    image: DecorationImage(
                      image: FileImage(File(answer.answer.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_rounded,
                      color: ColorConstants.colorGreyTwo.withOpacity(0.6),
                      size: 50,
                    ),
                    Text(
                      'Tap To Upload Image',
                      style: (Device.width >= 1024)
                          ? TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.colorGreenTwo.withOpacity(0.6),
                            )
                          : TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.colorGreenTwo.withOpacity(0.6),
                            ),
                    ),
                  ],
                ),
        ),
      );
    } else {
      return Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: const Text(
              'Select You Answer',
            ),
            style: (Device.width >= 1024)
                ? TextHelper.smallTextStyle.copyWith(
                    color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
                  )
                : TextHelper.normalTextStyle.copyWith(
                    color: answer.validated && answer.error ? ColorConstants.colorRedFour : ColorConstants.colorGreyTwo,
                  ),
            underline: const SizedBox.shrink(),
            value: answer.answer,
            items: [
              DropdownMenuItem<String>(
                value: 'yes',
                child: Text(
                  'Yes',
                  style: (Device.width >= 1024)
                      ? TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorBlack.withOpacity(0.4),
                        )
                      : TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorBlack.withOpacity(0.4),
                        ),
                ),
              ),
              DropdownMenuItem<String>(
                value: 'no',
                child: Text(
                  'No',
                  style: (Device.width >= 1024)
                      ? TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorBlack.withOpacity(0.4),
                        )
                      : TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorBlack.withOpacity(0.4),
                        ),
                ),
              ),
            ],
            onChanged: onDropDownChanged,
          ),
        ),
      );
    }
  }
}
