/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'configure.non.web.dart' if (dart.library.html) 'configure.web.dart';
import 'constants.dart';
import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FirebaseDynamicLinks.instance.getInitialLink();

  // init local database with no sql
  await Hive.initFlutter();

  // registering local database adapters
  Hive.registerAdapter(LoginDetailsAdapter());

  // opening local database pipeline
  if (StringConstants.loginBoxOldKey != StringConstants.loginBoxKey) {
    await Hive.deleteBoxFromDisk(StringConstants.loginBoxOldKey);
    await Hive.openBox<LoginDetails>(StringConstants.loginBoxKey);
    DioHelper();
    CartHelper();
  } else {
    await Hive.openBox<LoginDetails>(StringConstants.loginBoxKey);
    DioHelper();
    CartHelper();
  }
  await Hive.openBox(StringConstants.guestBoxKey);

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (_) {
      configureApp();
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppProvider>(
              create: (_) => AppProvider(),
            ),
          ],
          child: const Fabpiks(),
        ),
      );
    },
  );
}

class Fabpiks extends StatefulWidget {
  const Fabpiks({super.key});

  @override
  State<Fabpiks> createState() => _FabpiksState();
}

class _FabpiksState extends State<Fabpiks> {
  late AppRouter _appRouter;

  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    _appRouter = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarContrastEnforced: true,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp.router(
            onGenerateTitle: (context) => 'Agile',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              visualDensity:
                  (kIsWeb && Device.width < 104) ? VisualDensity.adaptivePlatformDensity : VisualDensity.compact,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: ColorConstants.colorGreyTwo.withOpacity(0.8),
                ),
                titleTextStyle: TextHelper.titleStyle.copyWith(color: Colors.black),
              ),
              scaffoldBackgroundColor: Colors.white,
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              fontFamily: 'Montserrat',
            ),
            supportedLocales: const [
              Locale('en', ''),
            ],
            routerDelegate: AutoRouterDelegate(
              _appRouter,
            ),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
