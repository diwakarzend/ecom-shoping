// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// @RoutePage(name: 'ProductSurveyRoute')
class ProductSurveyMobile extends StatefulWidget {
  final String productId;

  // final Survey survey;
  // final Function(bool value, int totaEarning) submit;

  const ProductSurveyMobile({
    super.key,
    // required this.submit,
    required this.productId,
    // required this.survey,
  });

  @override
  State<ProductSurveyMobile> createState() => _ProductSurveyMobileState();
}

class _ProductSurveyMobileState extends State<ProductSurveyMobile> {
  List<SurveyAnswer> answers = [];

  final DioHelper _dioHelper = DioHelper();

  final ImagePicker picker = ImagePicker();

  Future<XFile?> getImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    return file;
  }

  Product? _product;

  initProduct(AppProvider provider) {
    _product = provider.sampleProducts.firstWhereOrNull((element) => element.id == widget.productId);
    if (_product != null && _product!.pSurvey != null) {
      for (var q in _product!.pSurvey!.questions) {
        answers.add(
          SurveyAnswer(
            id: q.id,
            qualified: false,
            validated: false,
            error: false,
            required: q.required,
          ),
        );
      }
    }
  }

  validateAnswers(AppProvider provider) {
    for (var a in answers) {
      if (a.required && a.answer == null) {
        a.validated = true;
        a.error = true;
      } else {
        a.validated = true;
        a.error = false;
      }
    }
    setState(() {});
  }

  calculatePoints() {
    int totalPoints = 0;
    for (var q in _product!.pSurvey!.questions) {
      totalPoints += q.reward;
    }
    return totalPoints;
  }

  saveSurvey(AppProvider provider) async {
    ScaffoldLoaderDialog.of(context).show();
    int totalPoints = 0;
    for (var q in _product!.pSurvey!.questions) {
      totalPoints += q.reward;
    }

    try {
      final response = await _dioHelper.post(
        'store-answer',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${provider.loginDetails?.token}',
            'Content-Type': 'application/json',
          },
        ),
        data: SurveyReport(
          id: '',
          surveyId: _product?.pSurvey?.id ?? '',
          productId: _product?.id,
          brandId: _product?.brandId,
          userId: provider.currentUser!.id,
          totalQuestions: _product?.pSurvey?.questions.length ?? 0,
          totalPoints: totalPoints,
          pointsEarned: totalPoints,
          qualified: false,
          questionAnswers: List<QuestionAndAnswer>.from(
            answers.map(
              (e) => QuestionAndAnswer(
                question: _product!.pSurvey!.questions.firstWhere((element) => element.id == e.id).survayQuestion,
                answer: e.answer.runtimeType == XFile ? e.answer.path : e.answer,
              ),
            ),
          ),
          rejected: false,
          answerFor: 'prequalified',
        ).toJson(),
      );
      if (response != null && response.data['status']) {
        provider.addCartItems(productID: _product!.id);
        Future.delayed(const Duration(seconds: 1)).then(
          (_) {
            context.router.maybePop().then(
              (_) {
                BuildContext? dialogContext;
                try {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (c) {
                      dialogContext = c;
                      return CustomDialog(
                        onTap: () {
                          dialogContext?.maybePop().then(
                                (value) => Future.delayed(const Duration(seconds: 0)).then(
                                  (value) => dialogContext?.router.popUntilRouteWithName(NavigatorRoute.name),
                                ),
                              );
                        },
                        onClose: () {
                          dialogContext?.maybePop().then(
                                (value) => Future.delayed(const Duration(seconds: 0)).then(
                                  (value) => dialogContext?.router.popUntilRouteWithName(NavigatorRoute.name),
                                ),
                              );
                        },
                        icon: 'assets/images/icons/done.png',
                        buttonName: 'Okay',
                        title: 'Yay!\nYou are qualified for the FREE SAMPLE!',
                        message: 'Proceed to cart and place your order',
                        haveButtons: true,
                      );
                    },
                  );
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            );
          },
        );
      } else {
        Future.delayed(const Duration(seconds: 1)).then(
          (_) {
            context.router.maybePop().then(
              (_) {
                BuildContext? dialogContext;
                try {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (c) {
                      dialogContext = c;
                      return CustomDialog(
                        onTap: () {
                          dialogContext?.maybePop();
                        },
                        onClose: () {
                          dialogContext?.maybePop();
                          Future.delayed(const Duration(seconds: 0)).then((value) => context.router.popUntilRouteWithName(NavigatorRoute.name));
                        },
                        icon: 'assets/images/icons/done.png',
                        buttonName: '',
                        title: '',
                        message:
                            'Thanks for your interest in the offer. We shall notify you if you are eligible. \nNote: Only qualified users will receive a notification.',
                        haveButtons: false,
                      );
                    },
                  );
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            );
          },
        );
      }
    } on DioException catch (_, e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        initProduct(provider);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            elevation: 0,
          ),
          body: _product != null && _product!.pSurvey != null
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * .02),
                      Text(
                        _product!.pSurvey!.description,
                        maxLines: 100000,
                        style: TextHelper.normalTextStyle,
                      ),
                      SizedBox(height: height * .03),
                      ..._product!.pSurvey!.questions.map(
                        (e) => SizedBox(
                          width: width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.survayQuestion,
                                maxLines: 5,
                                style: TextHelper.subTitleStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      answers.firstWhere((element) => element.id == e.id).validated && answers.firstWhere((element) => element.id == e.id).error
                                          ? ColorConstants.colorRedFour
                                          : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SurveyQuestionField(
                                question: e,
                                answer: answers.firstWhere((element) => element.id == e.id),
                                onDropDownChanged: (String? value) {
                                  answers.firstWhere((element) => element.id == e.id).answer = value;
                                  setState(() {});
                                },
                                onMultiChoiceChanged: (List<String> values) {
                                  answers.firstWhere((element) => element.id == e.id).answer = values;
                                  setState(() {});
                                },
                                onTextFieldChanged: (String? value) {
                                  answers.firstWhere((element) => element.id == e.id).answer = value;
                                  setState(() {});
                                },
                                onRatingChanged: (double value) {
                                  answers.firstWhere((element) => element.id == e.id).answer = value;
                                  setState(() {});
                                },
                                onImageTap: () async {
                                  final file = await getImage();
                                  if (file != null) {
                                    answers.firstWhere((element) => element.id == e.id).answer = file;
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * .15),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
          bottomNavigationBar: Container(
            width: width,
            height: height * .07 + MediaQuery.of(context).padding.bottom + 20,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                validateAnswers(provider);
                if (answers.where((element) => element.validated && element.error).isNotEmpty) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldSnackBar.of(context).show('Please answer required questions');
                } else {
                  saveSurvey(provider);
                }
              },
              child: Container(
                width: width,
                height: height * .07,
                margin: EdgeInsets.symmetric(horizontal: width * .1),
                decoration: BoxDecoration(
                  color: ColorConstants.colorBlueEighteen,
                  borderRadius: BorderRadius.circular(height * .07),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Submit',
                  style: TextHelper.titleStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
