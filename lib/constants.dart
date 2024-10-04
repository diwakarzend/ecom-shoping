/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:flutter/material.dart';

class StringConstants {
  static const String guestBoxKey = 'guestBox';
  static const String loginBoxOldKey = 'login';
  static const String loginBoxKey = 'login';

  static const String apiUrl = 'https://www.chillwaveelectronics.in/api/v2/';
  static const String baseUrl = 'https://www.chillwaveelectronics.in/';
  static const String paytmChecksumApi = 'https://paytm.theserv.in/api/checksum';
  static const String paytmMID = 'CSeflW97347912891806';
  static const String pincodeApi = 'https://api.postalpincode.in/pincode/';

  static const String deviceTypeM = 'mobile';
  static const String deviceTypeD = 'desktop';
  static const String deviceTypeT = 'tab';

  static const String couponFlat = 'flat';
  static const String couponPercentage = 'percentage';

  static const String trialProduct = 'trial_store';
  static const String hotDealProduct = 'hot_deals';
  static const String brandStoreProduct = 'brand_store';

// const String rewardStoreProduct = 'rewards_store';
  static const String noTrailProduct = 'no_trial_product';
  static const String surprisedProduct = 'surprised_product';

  static const String homeBanner = 'home';
  static const String homeBannerMiddle = 'middle_home';
  static const String homeBannerBottom = 'bottom_home';
  static const String brandBanner = 'brand';
  static const String surveyBanner = 'survay';
  static const String referBanner = 'refer';
  static const String trialBanner = 'trial';
  static const String homeSmall = 'home_small';
  static const String trialSmall = 'trial_small';
  static const String brandSmall = 'brand_small';
  static const String vendyBanner = 'vendy_banner';

  static const String singleChoiceQuestion = 'single_choise';
  static const String multiChoiceQuestion = 'multi_choise';
  static const String ratingQuestion = 'rating';
  static const String subjectiveQuestion = 'subjective_question';
  static const String uploadImageQuestion = 'upload_image';
  static const String yesNowQuestion = 'yes_no';

  static const String oneSignalId = '980720fb-823b-451d-8083-06c320b4c74d';

  static const String rupeeSign = '\u{20B9}';
}

class ColorConstants {
  static const Color colorGrey = Color(0xff646464);
  static const Color colorGreyTwo = Color(0xff707070);
  static const Color colorGreyThree = Color(0xff5d5d5d);

  // static const Color colorGreyFour = Color(0xff595959);
  static const Color colorGreyFive = Color(0xffACACAC);
  static const Color colorGreySix = Color(0xff686868);
  static const Color colorGreySeven = Color(0xff666666);
  static const Color colorGreyEight = Color(0xff5E5E5E);
  static const Color colorGreyNine = Color(0xffE4E4E4);

  // static const Color colorGreyTen = Color(0xffE1E1E1);
  static const Color colorGreyEleven = Color(0xff7E7E7E);

  // static const Color colorGreyTwelve = Color(0xff6A6A6A);
  // static const Color colorGreyThirteen = Color(0xff5F5F5F);
  static const Color colorGreyFourteen = Color(0xff828282);

  // static const Color colorGreyFifteen = Color(0xffFFE8E8);
  static const Color colorGreySixteen = Color(0xffF3F0F0);
  static const Color colorGreySeventeen = Color(0xff727171);
  static const Color colorGreyEightTeen = Color(0xffA4A4A4);

  // static const Color colorGreyNineTeen = Color(0xff343434);
  static const Color colorGreyTwenty = Color(0xff808080);
  static const Color colorGreyTwentyOne = Color(0xff474747);
  static const Color colorGreyTwentyTwo = Color(0xff4C4C4C);
  static const Color colorGreyTwentyThree = Color(0xff4F4F4F);
  static const Color colorGreyTwentyFour = Color(0xffE5E6E6);
  static const Color colorPrimary = Color(0xff5432DB);
  static const Color colorPrimaryTwo = Color(0xff504DE4);
  static const Color colorRed = Color(0xffBA406C);
  static const Color colorRedTwo = Color(0xffF14338);

  // static const Color colorRedThree = Color(0xffFF6A6A);
  static const Color colorRedFour = Color(0xffFF3B3B);
  static const Color colorRedFive = Color(0xffFF4545);

  // static const Color colorRedSix = Color(0xffC40B0B);
  // static const Color colorRedSeven = Color(0xff710303);
  // static const Color colorRedEight = Color(0xffF88B8B);
  static const Color colorRedNine = Color(0xffff0e15);

  // static const Color colorRedTen = Color(0xffDA2329);
  static const Color colorOffWhite = Color(0xffEFEFEF);

  // static const Color colorOffWhiteTwo = Color(0xfff2f2f2);
  static const Color colorStar = Color(0xffFFBE2C);

  // static const Color colorStarTwo = Color(0xffffd700);
  // static const Color colorYellow = Color(0xffFFE787);
  // static const Color colorYellowOne = Color(0xffB28F00);
  // static const Color colorYellowTwo = Color(0xffEFAD44);
  static const Color colorYellowThree = Color(0xffF8A223);

  // static const Color colorYellowFour = Color(0xffF9A223);
  // static const Color colorCream = Color(0xffFFFAF2);
  static const Color colorGreen = Color(0xff3C780D);
  static const Color colorGreenTwo = Color(0xff4BAE4F);
  static const Color colorGreenThree = Color(0xff548400);
  static const Color colorGreenFour = Color(0xff13D086);

  // static const Color colorGreenFive = Color(0xff4E7222);
  static const Color colorGreenSix = Color(0xffd5e6e3);
  static const Color colorGreenSeven = Color(0xff2f6e1c);

  // static const Color colorBlueOne = Color(0xff15325A);
  // static const Color colorBlueTwo = Color(0xff2A6FF9);
  // static const Color colorBlueThree = Color(0xff6619CE);
  static const Color colorBlueFour = Color(0xff3F52EB);
  static const Color colorBlueFive = Color(0xff6146E2);

  // static const Color colorBlueSix = Color(0xff243D7D);
  // static const Color colorBlueSeven = Color(0xff16163f);
  static const Color colorBlueEight = Color(0xff1D1C4F);

  // static const Color colorBlueNine = Color(0xff1E1D4F);
  static const Color colorBlueTen = Color(0xff1F1D50);

  // static const Color colorBlueEleven = Color(0xff156ce7);
  static const Color colorBlueTwelve = Color(0xff030D4E);

  // static const Color colorBlueThirteen = Color(0xff2E3192);
  // static const Color colorBlueFourteen = Color(0xff0A0B13);
  static const Color colorBlueFifteen = Color(0xff4924D0);

  // static const Color colorBlueSixteen = Color(0xff3e5193);
  static const Color colorBlueSeventeen = Color(0xff30456B);
  static const Color colorBlueEighteen = Color(0xff4B90F0);
  static const Color colorBlueNineteen = Color(0xffB3CDF2);
  static const Color colorBlueTwenty = Color(0xff04114D);
  static const Color colorBlueTwentyOne = Color(0xff2B3990);
  static const Color colorBlueTwentyTwo = Color(0xff283C5E);
  static const Color colorBlueTwentyThree = Color(0xff1E3659);

  // static const Color colorPink = Color(0xffFFD3EE);
  static const Color colorPinkTwo = Color(0xffF1E3DA);

  // static const Color colorExclusiveCard = Color(0xffD4E7E5);
  static const Color colorBlack = Color(0xff101010);
  static const Color colorBlackTwo = Color(0xff414042);
  static const Color colorBlackThree = Color(0xff231F20);
  static const Color colorBlackFour = Color(0xff58595B);

  // static const Color colorViolet = Color(0xff650D65);
  static const Color colorBrown = Color(0xff785133);

  // static const Color colorDeals = Color(0xffb6d7e3);
  // static const Color colorNew = Color(0xffC5E2D7);
  static const Color colorDealsBorder = Color(0xff6b96ec);
  static const Color colorLogin = Color(0xffE5743D);
  static const Color colorBottomNavigation = Color(0xffF5F0EE);
  static const Color colorAlertBG = Color(0xffFCFAFA);
  static const Color colorMini = Color(0xffDAE789);
  static const Color colorDeal = Color(0xffF5F0EE);
  static const Color colorSample = Color(0xffE0EDD8);
  static const Color colorRatingPopup = Color(0xffE9EDF7);
  static const Color colorTextLater = Color(0xff885035);
  static const Color colorHIWPopup = Color(0xffF4FFF9);
  static const Color colorHIWPopupTwo = Color(0xffF1743D);
  static const Color vendyColor = Color(0xffE1F9F8);
  static const Color miniColor = Color(0xffD3E9FA);
  static const Color dealColor = Color(0xffF8E0E6);
  static const Color sampleColor = Color(0xffEED7C3);
  static const Color colorBorder = Color(0xffEB881D);
  static const Color dealCardColor = Color(0xffF7D7CB);
  static const Color authNewColor = Color(0xffEC421D);
}

class ScaffoldSnackBar {
  ScaffoldSnackBar(this._context);

  factory ScaffoldSnackBar.of(BuildContext context) {
    return ScaffoldSnackBar(context);
  }

  final BuildContext _context;

  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
  }
}

class ScaffoldBanner {
  ScaffoldBanner(this._context);

  factory ScaffoldBanner.of(BuildContext context) {
    return ScaffoldBanner(context);
  }

  final BuildContext _context;

  void show(String message) {
    final controller = ScaffoldMessenger.of(_context)
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          backgroundColor: ColorConstants.colorPrimary,
          content: Text(
            message,
            maxLines: 2,
            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () => ScaffoldMessenger.of(_context)..hideCurrentMaterialBanner(),
              icon: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    Future.delayed(const Duration(seconds: 3)).then((_) => controller.clearMaterialBanners());
  }
}

class ScaffoldLoaderDialog {
  ScaffoldLoaderDialog(this._context);

  factory ScaffoldLoaderDialog.of(BuildContext context) {
    return ScaffoldLoaderDialog(context);
  }

  final BuildContext _context;

  void show() {
    showDialog(
      context: _context,
      builder: (BuildContext c) {
        return const Center(
          child: CircularProgressIndicator(
            color: ColorConstants.colorPrimary,
          ),
        );
      },
    );
  }

  void hide() {
    _context.router.maybePop();
  }
}

class ConvertToNum {
  static value(data) {
    if (data is String) {
      return num.parse(data);
    } else if (data is int) {
      return num.parse(data.toString());
    } else if (data is double) {
      return num.parse(data.toString());
    } else {
      return 0;
    }
  }
}
