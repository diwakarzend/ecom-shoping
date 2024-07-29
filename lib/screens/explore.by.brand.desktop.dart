import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/models/brand.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/app.provider.dart';

class ExplorebyBrandDesktop extends StatefulWidget {
  const ExplorebyBrandDesktop({super.key});

  @override
  State<ExplorebyBrandDesktop> createState() => _ExplorebyBrandDesktopState();
}

class _ExplorebyBrandDesktopState extends State<ExplorebyBrandDesktop> {
  int selectedPage = 1;

  List<Brand> generateList(AppProvider provider, int page) {
    int count = 27;
    List<Brand> brands = provider.brands.toList();
    if (brands.length > (count * page)) {
      return brands.take((count * page)).toList();
    } else {
      return brands;
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          setState(() {
            selectedPage++;
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const TopAppBar(),
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: width * .14, vertical: height * .05),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 6,
                ),
                itemCount: generateList(provider, selectedPage).length,
                itemBuilder: (BuildContext context, int index) {
                  final Brand e = generateList(provider, selectedPage)[index];
                  return InkWell(
                    onTap: () {
                      context.router.push(BrandTrialRoute(brand: e));
                    },
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorConstants.colorBlack.withOpacity(0.4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: e.logo.isNotEmpty ? CustomNetworkImage(imageUrl: e.logo) : null,
                    ),
                  );
                },
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: width * .15,vertical: height * .16),
              //   child: GridView.count(
              //     crossAxisCount: 6,
              //     mainAxisSpacing: 5,
              //     crossAxisSpacing: 1,
              //     shrinkWrap: true,
              //     primary: false,
              //     childAspectRatio: 1.11,
              //     children: [
              //
              //
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands2.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand3.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands4.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands2.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand3.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands4.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand5.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand6.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands4.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand5.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand6.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand7.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand8.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand9.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand7.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand8.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand9.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands2.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand3.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands2.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand3.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands4.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand5.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand6.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands4.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand5.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand6.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand7.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand8.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand9.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand7.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand8.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand9.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands2.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand3.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand4.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands2.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand3.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand4.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand5.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand6.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brands4.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand5.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand6.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand7.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand8.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand9.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand7.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand8.png'),
              //       // ),
              //       // Container(
              //       //   margin: const EdgeInsets.all(6),
              //       //   width: width,
              //       //   alignment: Alignment.center,
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.transparent,
              //       //     border: Border.all(color: Colors.black),
              //       //     borderRadius: BorderRadius.circular(30),
              //       //   ),
              //       //   child: Image.asset('assets/images/brand9.png'),
              //       // ),
              //     ],
              //   ),
              // ),
              const BottomAppBarPage(),
            ],
          ),
        ),
      );
    });
  }
}
