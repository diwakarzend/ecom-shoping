/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreenMobile extends StatefulWidget {
  const ProfileScreenMobile({super.key});

  @override
  State<ProfileScreenMobile> createState() => _ProfileScreenMobileState();
}

class _ProfileScreenMobileState extends State<ProfileScreenMobile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectedGender;

  // XFile? image;
  late AppProvider _appProvider;

  final DioHelper _dioHelper = DioHelper();

  // final ImagePicker picker = kIsWeb ? ImagePickerWeb() : ImagePicker();

  // getProfileImage() async {
  //   final file = await picker.pickImage(source: ImageSource.gallery);
  //   if (file != null) {
  //     image = file;
  //   }
  //   setState(() {});
  // }

  // Future saveDetails(AppProvider provider) async {
  //   ScaffoldLoaderDialog.of(context).show();
  //   final response = await _dioHelper.post(
  //     'user/${provider.loginDetails?.uId}',
  //     options: Options(
  //       headers: {
  //         'Content-Type': image != null ? 'multipart/form-data' : 'application/json',
  //       },
  //     ),
  //     data: image != null
  //         ? FormData.fromMap(
  //             {
  //               'first_name': firstNameController.text,
  //               'last_name': lastNameController.text,
  //               'email': emailController.text,
  //               'image': await MultipartFile.fromFile(
  //                 image!.path,
  //               ),
  //               'gender': selectedGender,
  //             },
  //           )
  //         : {
  //             'first_name': firstNameController.text,
  //             'last_name': lastNameController.text,
  //             'email': emailController.text,
  //             'gender': selectedGender,
  //           },
  //   );
  //   if (response != null && response.data['status']) {
  //     if (image != null && provider.currentUser?.image == null) profileComplete(provider);
  //     if (!mounted) return;
  //     ScaffoldLoaderDialog.of(context).hide();
  //     provider.initWithLogin();
  //     // initValues();
  //     if (!mounted) return;
  //     ScaffoldSnackBar.of(context).show('Profile Update Complete');
  //   } else {
  //     if (!mounted) return;
  //     ScaffoldLoaderDialog.of(context).hide();
  //     if (!mounted) return;
  //     ScaffoldSnackBar.of(context).show('something went wrong');
  //   }
  // }

  profileComplete(AppProvider provider) async {
    final response = await _dioHelper.post(
      'reward',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'reward_point': 100,
        'type': 'credit',
        'reward_by': 'Profile Complete',
      },
    );
    if (response != null && response.data['status']) {
      provider.initWithLogin();
      initValues();
      BuildContext? dialogContextTwo;
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          dialogContextTwo = c;
          return CustomDialog(
            onTap: () {
              dialogContextTwo?.popRoute();
              context.router.push(const CartRoute());
            },
            icon: 'assets/images/icons/done.png',
            buttonName: '',
            haveButtons: false,
            title: '',
            message: 'Profile successfully updated, 100 fabpoints added to your account.',
          );
        },
      );
    }
  }

  Future deleteAccount(AppProvider provider) async {
    final response = await _dioHelper.post(
      'remove-user-record/${provider.loginDetails?.uId ?? ''}',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response != null && response.data['status']) {
      provider.changeLoginStatus(false, null, '', '', '');
      if (!mounted) return;
      context.router.replace(AuthRoute(logOut: true));
    }
  }

  initValues() {
    if (_appProvider.currentUser != null) {
      phoneController.text = _appProvider.currentUser!.mobileNo.toString();
      if (_appProvider.currentUser?.firstName != null) firstNameController.text = _appProvider.currentUser!.firstName;
      if (_appProvider.currentUser?.lastName != null) lastNameController.text = _appProvider.currentUser!.lastName;
      if (_appProvider.currentUser?.email != null) emailController.text = _appProvider.currentUser!.email;
      if (_appProvider.currentUser?.gender != null) selectedGender = _appProvider.currentUser!.gender;
    }
  }

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: const Text('My Account'),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * .05),
                  Align(
                    child: InkWell(
                      // onTap: () => getProfileImage(),
                      child: Container(
                        width: width * .2,
                        height: width * .2,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: provider.currentUser != null && provider.currentUser!.image != null
                            ? Container(
                                width: double.infinity,
                                height: double.infinity,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CustomNetworkImage(
                                  imageUrl: provider.currentUser?.image ?? '',
                                  width: width * .2,
                                  height: width * .2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            // : image != null
                            //     ? Container(
                            //         width: double.infinity,
                            //         height: double.infinity,
                            //         decoration: BoxDecoration(
                            //           shape: BoxShape.circle,
                            //           image: DecorationImage(
                            //             image: FileImage(File(image!.path)),
                            //             fit: BoxFit.cover,
                            //           ),
                            //         ),
                            //       )
                            : Icon(
                                Icons.camera_alt_outlined,
                                color: ColorConstants.colorGreyEleven.withOpacity(0.6),
                                size: 40,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    'Edit',
                    style: TextHelper.titleStyle.copyWith(color: ColorConstants.colorGreyEleven),
                  ),
                  SizedBox(height: height * .05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: TextHelper.normalTextStyle,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle: TextHelper.normalTextStyle,
                        labelText: 'First Name',
                        labelStyle: TextHelper.normalTextStyle,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: TextHelper.normalTextStyle,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        hintStyle: TextHelper.normalTextStyle,
                        labelText: 'Last Name',
                        labelStyle: TextHelper.normalTextStyle,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: TextHelper.normalTextStyle,
                      decoration: InputDecoration(
                        hintText: 'Email Id',
                        hintStyle: TextHelper.normalTextStyle,
                        labelText: 'Email Id',
                        labelStyle: TextHelper.normalTextStyle,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                      style: TextHelper.normalTextStyle,
                      decoration: InputDecoration(
                        prefixText: '+91 ',
                        prefixStyle: TextHelper.normalTextStyle,
                        hintText: 'Phone Number',
                        hintStyle: TextHelper.normalTextStyle,
                        labelText: 'Phone Number',
                        labelStyle: TextHelper.normalTextStyle,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Gender',
                        style: TextHelper.subTitleStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'male',
                              groupValue: selectedGender,
                              activeColor: ColorConstants.colorPrimaryTwo,
                              onChanged: (v) {
                                setState(() {
                                  selectedGender = v;
                                });
                              },
                            ),
                            Text(
                              'Male',
                              style: TextHelper.normalTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'female',
                              groupValue: selectedGender,
                              activeColor: ColorConstants.colorPrimaryTwo,
                              onChanged: (v) {
                                setState(() {
                                  selectedGender = v;
                                });
                              },
                            ),
                            Text(
                              'Female',
                              style: TextHelper.normalTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .03),
                  if (provider.currentUser != null)
                    ...provider.currentUser!.shipping.map(
                      (e) => Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    e.shippingName,
                                    style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                            SizedBox(height: height * .01),
                            Text(
                              e.shippingAddress,
                              style: TextHelper.normalTextStyle,
                            ),
                            Text(
                              '${e.shippingCity}, ${e.shippingState} ${e.shippingPincode}',
                              style: TextHelper.normalTextStyle,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.router.push(EditAddressRoute(shipping: e));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: ColorConstants.colorPrimaryTwo,
                                    textStyle: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Text('Change/Edit'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.router.push(AddAddressRoute(fromCart: false));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: ColorConstants.colorPrimaryTwo,
                                    textStyle: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Text('Add New Address'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (provider.currentUser != null && provider.currentUser!.shipping.isEmpty)
                    TextButton(
                      onPressed: () {
                        context.router.push(AddAddressRoute(fromCart: false));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: ColorConstants.colorPrimary,
                      ),
                      child: const Text('Add New Address'),
                    ),
                  SizedBox(height: height * .02),
                  Container(
                    width: width,
                    height: height * .07 + MediaQuery.of(context).padding.bottom + 20,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (c) {
                            return _Dialog(
                              onTap: () {
                                deleteAccount(provider);
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        width: width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: height * .06,
                        decoration: BoxDecoration(
                          color: ColorConstants.colorRed,
                          borderRadius: BorderRadius.circular(height * .07),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Delete Account',
                          style: TextHelper.titleStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .2),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              width: width,
              height: height * .07 + MediaQuery.of(context).padding.bottom + 20,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  // saveDetails(provider);
                },
                child: Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: height * .06,
                  decoration: BoxDecoration(
                    color: const Color(0xff5432DB),
                    borderRadius: BorderRadius.circular(height * .07),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Save Info',
                    style: TextHelper.titleStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Dialog extends StatelessWidget {
  final Function() onTap;

  const _Dialog({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: width,
            constraints: BoxConstraints(
              minHeight: height * .25,
              maxHeight: height * .7,
            ),
            // height: height * .4,
            margin: EdgeInsets.symmetric(horizontal: width * .05, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: width * .05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * .1),
                Text.rich(
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'Are you sure you want to delete your account?',
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.colorBlack,
                      height: 1.3,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(height: height * .05 - 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.router.pop();
                          onTap();
                        },
                        child: Container(
                          width: width * .5,
                          height: height * .045,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorBrown,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Yes',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: Container(
                          width: width * .5,
                          height: height * .045,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorBrown,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'No',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              transform: Matrix4.translationValues(0, -width * .125, 0),
              width: width * .3,
              height: width * .3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.colorGreenSeven.withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorGreenSeven.withOpacity(0.2),
                ),
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.colorGreenSeven.withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.colorGreenSeven.withOpacity(1),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/icons/puzzle.png',
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 0,
            child: GestureDetector(
              onTap: () {
                context.router.pop();
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorOffWhite,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.clear_rounded,
                  color: ColorConstants.colorBlack,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
