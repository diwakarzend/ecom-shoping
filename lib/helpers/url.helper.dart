/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static late UrlHelper? _urlHelper;

  factory UrlHelper() {
    if (_urlHelper == null) {
      _urlHelper = UrlHelper.internal();
      return _urlHelper!;
    } else {
      return _urlHelper!;
    }
  }

  Future<void> launchNonUrl({required String url}) async {
    try {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
        ),
      );
    } catch (e) {
      debugPrint('name: url${e.toString()}');
    }
  }

  UrlHelper.internal();
}
