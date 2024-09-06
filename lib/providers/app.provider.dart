// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
//
import 'package:flutter/material.dart' hide Feedback, Banner;
import 'package:hive/hive.dart';

class AppProvider extends ChangeNotifier {
  final DioHelper _dioHelper = DioHelper();
  Box loginBox = Hive.box<LoginDetails>(StringConstants.loginBoxKey);
  final guestBox = Hive.box(StringConstants.guestBoxKey);

  bool guestLogin = false;

  int activeIndex = 0;

  // static final facebookAppEvents = FacebookAppEvents();
  LoginDetails? loginDetails;
  User? currentUser;
  List<Product> miniProducts = [];
  List<Product> surprisedProducts = [];
  List<Product> dealProducts = [];
  List<Product> noTrailProducts = [];
  List<Product> sampleProducts = [];

  List<Category> categories = [];
  List<Category> miniCategories = [];
  List<Category> dealCategories = [];
  List<Category> sampleCategories = [];

  List<Brand> brands = [];
  List<Banner> banners = [];
  List<Coupon> coupons = [];
  List<Feedback> feedbacks = [];
  List<SurvayTopic> topics = [];
  List<Survey> surveys = [];
  List<SurveyReport> reports = [];
  List<FAQ> faqs = [];
  Settings? appSettings;
  Coupon? coupon;
  bool appLoading = true;
  List<String> apis = [];
  bool updatedSkipped = false;
  Vendy? vendy;
  Cart? cart;
  Wishlist? wishlist;

  AppProvider() {
    loginDetails = loginBox.get('login');
    guestLogin = guestBox.get('guestLogin', defaultValue: false);
    if (loginDetails != null) {
      initWithLogin();
    } else {
      initWithoutLogin();
    }
    notifyListeners();
  }

  changeIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }

  skipUpdate() {
    updatedSkipped = true;
    notifyListeners();
  }

  applyCoupon(Coupon c) {
    coupon = c;
    notifyListeners();
  }

  removeCoupon() {
    coupon = null;
    notifyListeners();
  }

  void loginAsGuest(bool status) {
    if (status) {
      guestLogin = true;
      guestBox.put('guestLogin', true);
    } else {
      guestLogin = false;
      guestBox.delete('guestLogin');
    }
    notifyListeners();
  }

  void changeLoginStatus(bool status, User? user, String token, String uid, String role) {
    loginDetails = LoginDetails(
      isLoggedIn: status,
      role: role,
      token: token,
      uId: uid,
    );
    currentUser = user;
    if (!status) {
      loginAsGuest(false);
      resetAll();
    } else {
      loginAsGuest(false);
      loginBox.put('login', loginDetails);
      _dioHelper.updateToken(
        LoginDetails(
          isLoggedIn: status,
          role: role,
          token: token,
          uId: uid,
        ),
      );
      initWithLogin();
    }
    notifyListeners();
  }

  Future fetchCart() async {
    final Response? response = await _dioHelper.get('cart');
    if (response != null && response.data['status']) {
      Cart temp = Cart.fromJson(response.data);
      cart = temp;
      notifyListeners();
      return 'fetchCart';
    }
  }

  Future addCartItem(String id, int qty) async {
    final Response? response = await _dioHelper.post(
      'cart',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'product_id': id,
        'qty': qty,
      },
    );
    if (response != null && response.data['status']) {
      Cart temp = Cart.fromJson(response.data);
      cart = temp;
      notifyListeners();
      return 'addCartItem';
    }
  }

  Future fetchWishlist() async {
    final Response? response = await _dioHelper.get('wishlist');
    if (response != null && response.data['status']) {
      Wishlist temp = Wishlist.fromJson(response.data);
      wishlist = temp;
      notifyListeners();
      return 'fetchCart';
    }
  }

  Future addWishlistItem(String id) async {
    final Response? response = await _dioHelper.post(
      'wishlist',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'product_id': id,
      },
    );
    if (response != null && response.data['status']) {
      Wishlist temp = Wishlist.fromJson(response.data);
      wishlist = temp;
      notifyListeners();
      return 'addCartItem';
    }
  }

  Future updateCartItem(String id, int qty) async {
    final Response? response = await _dioHelper.put(
      'cart/$id',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'qty': qty,
      },
    );
    if (response != null && response.data['status']) {
      Cart temp = Cart.fromJson(response.data);
      cart = temp;
      notifyListeners();
      return 'addCartItem';
    }
  }

  Future deleteCartItems(String id) async {
    final Response? response = await _dioHelper.delete(
      'cart/$id',
    );
    if (response != null && response.data['status']) {
      Cart temp = Cart.fromJson(response.data);
      cart = temp;
      notifyListeners();
      return 'addCartItem';
    }
  }

  void addCartItems({required String productID, Function(String message)? callBack}) async {
    if (cart != null && cart!.records.any((element) => element.productId == productID)) {
      CartItem product = cart!.records.where((element) => element.productId == productID).first;
      if (product.quantity < 10) {
        int qty = product.quantity;
        updateCartItem(product.id, ++qty);
      } else {
        if (callBack != null) {
          callBack('Max qty added');
        }
      }
    } else {
      addCartItem(productID, 1);
    }
    // await FirebaseAnalytics.instance.logAddToCart(
    //   currency: 'INR',
    //   value: product.productType == trialProduct || product.productType == brandStoreProduct ? 0 : product.salePrice.toDouble(),
    //   items: [product.toGAP()],
    // );
    // await facebookAppEvents.logAddToCart(
    //   id: product.id,
    //   type: 'product',
    //   currency: 'INR',
    //   price: product.productType == trialProduct || product.productType == brandStoreProduct ? 0 : product.salePrice.toDouble(),
    // );
    notifyListeners();
  }

  void removeCartItems(String productId) async {
    if (cart != null && cart!.records.any((element) => element.productId == productId)) {
      if (cart!.records.where((element) => element.productId == productId).first.quantity > 1) {
        CartItem product = cart!.records.where((element) => element.productId == productId).first;
        int qty = product.quantity;
        updateCartItem(product.id, --qty);
      } else {
        String id = cart!.records.where((element) => element.productId == productId).first.id;
        deleteCartItems(id);
      }
    }
    // await FirebaseAnalytics.instance.logRemoveFromCart(
    //   currency: 'INR',
    //   value: product.productType == trialProduct || product.productType == brandStoreProduct ? 0 : product.salePrice.toDouble(),
    //   items: [product.toGAP()],
    // );
    notifyListeners();
    // watchCart(cartHelper);
  }

  void deleteCartItem(String cartId) async {
    if (cart != null && cart!.records.any((element) => (element.id == cartId) || (element.productId == cartId))) {
      deleteCartItems(cartId);
    }
    notifyListeners();
  }

  void moveCartItem(String productId) async {
    if (cart != null && cart!.records.any((element) => element.productId == productId)) {
      deleteCartItems(productId);
    }
    if (wishlist != null && !wishlist!.records.any((element) => element.productId == productId)) {
      // await FirebaseAnalytics.instance.logAddToWishlist(
      //   currency: 'INR',
      //   value: product.productType == trialProduct || product.productType == brandStoreProduct ? 0 : product.salePrice.toDouble(),
      //   items: [product.toGAP()],
      // );
      // await facebookAppEvents.logAddToWishlist(
      //   id: product.id,
      //   type: 'product',
      //   currency: 'INR',
      //   price: product.productType == trialProduct || product.productType == brandStoreProduct ? 0 : product.salePrice.toDouble(),
      // );
      addToWishList(productId);
    }
    notifyListeners();
    // watchCart(cartHelper);
  }

  // void cartReset() {
  //   cartItems.clear();
  //   cartBox.clear();
  //   coupon = null;
  //   notifyListeners();
  // }

  void addToWishList(String productId) async {
    addWishlistItem(productId);
    // await FirebaseAnalytics.instance.logAddToWishlist(
    //   currency: 'INR',
    //   value: product.productType == trialProduct || product.productType == brandStoreProduct ? 0 : product.salePrice.toDouble(),
    //   items: [product.toGAP()],
    // );
    // await facebookAppEvents.logAddToWishlist(
    //   id: product.id,
    //   type: 'product',
    //   currency: 'INR',
    //   price: product.productType == trialProduct || product.productType == brandStoreProduct ? 0 : product.salePrice.toDouble(),
    // );
    notifyListeners();
  }

  Future<void> initWithoutLogin() async {
    apis.clear();
    apis.addAll([
      'getProducts',
      'getCategories',
      'getAllCategories',
      'getBrands',
      'getFeedbacks',
      'getSurvayTopics',
      'getSurvay',
      'getGeneralSettings',
      'getFaq',
      'getBanners',
      'getVendy',
    ]);
    await Future.forEach(
      apis,
          (element) async {
        switch (element) {
          case 'getProducts':
            getProducts();
            break;
          case 'getCategories':
            getCategories();
            break;
          case 'getAllCategories':
            getAllCategories();
            break;
          case 'getBrands':
            getBrands();
            break;
          case 'getFeedbacks':
            getFeedbacks();
            break;
          case 'getGeneralSettings':
            getGeneralSettings();
            break;
          case 'getFaq':
            getFaq();
            break;
          case 'getBanners':
            getBanners();
            break;
          case 'getVendy':
            getVendy();
            break;
        }
      },
    ).whenComplete(
          () {
        Future.delayed(const Duration(milliseconds: 1000)).then(
              (_) {
            appLoading = false;
            notifyListeners();
            return true;
          },
        );
      },
    );
  }

  Future<void> initWithLogin() async {
    apis.clear();
    apis.addAll([
      'getCurrentUser',
      'getProducts',
      'getCategories',
      'getAllCategories',
      'getBrands',
      'getCoupons',
      'getFeedbacks',
      'getSurvayTopics',
      'getSurvay',
      'getSurvayReports',
      'getGeneralSettings',
      'getFaq',
      'getBanners',
      'getVendy',
      'fetchCart',
      'fetchWishlist',
    ]);
    await Future.forEach(
      apis,
          (element) async {
        switch (element) {
          case 'getCurrentUser':
            getCurrentUser();
            break;
          case 'getProducts':
            getProducts();
            break;
          case 'getCategories':
            getCategories();
            break;
          case 'getAllCategories':
            getAllCategories();
            break;
          case 'getBrands':
            getBrands();
            break;
          case 'getCoupons':
            getCoupons();
            break;
          case 'getFeedbacks':
            getFeedbacks();
            break;
          case 'getSurvayReports':
            getSurvayReports();
            break;
          case 'getGeneralSettings':
            getGeneralSettings();
            break;
          case 'getFaq':
            getFaq();
            break;
          case 'getBanners':
            getBanners();
            break;
          case 'getVendy':
            getVendy();
            break;
          case 'fetchCart':
            fetchCart();
            break;
          case 'fetchWishlist':
            fetchWishlist();
            break;
        }
      },
    ).whenComplete(
          () {
        Future.delayed(const Duration(milliseconds: 1000)).then(
              (_) {
            appLoading = false;
            notifyListeners();
            return true;
          },
        );
      },
    );
  }

  void resetAll() async {
    await loginBox.clear();
    loginDetails = null;
    currentUser = null;
    vendy = null;
    surprisedProducts.clear();
    miniProducts.clear();
    dealProducts.clear();
    sampleProducts.clear();
    categories.clear();
    cart = null;
    wishlist = null;
    brands.clear();
    banners.clear();
    coupons.clear();
    feedbacks.clear();
    topics.clear();
    surveys.clear();
    reports.clear();
    faqs.clear();
    appSettings = null;
    coupon = null;
    notifyListeners();
    initWithoutLogin();
  }

  Future getCurrentUser() async {
    final Response? response = await _dioHelper.get('new-user/${loginDetails?.uId}');
    if (response != null && response.data['status']) {
      User temp = User.fromJson(response.data['record']);
      currentUser = temp;
      notifyListeners();
      return 'getCurrentUser';
    }
  }

  Future getProducts() async {
    final Response? response = await _dioHelper.get('product');
    if (response != null && response.data['status']) {
      surprisedProducts.clear();
      miniProducts.clear();
      dealProducts.clear();
      sampleProducts.clear();
      noTrailProducts.clear();
      for (var p in response.data['records']['allRecord']) {
        try {
          Product temp = Product.fromJson(p);
          switch (temp.productType) {
            case StringConstants.trialProduct:
              miniProducts.add(temp);
              break;
            case StringConstants.hotDealProduct:
              dealProducts.add(temp);
              break;
            case StringConstants.brandStoreProduct:
              sampleProducts.add(temp);
              break;
            case StringConstants.noTrailProduct:
              noTrailProducts.add(temp);
              break;
            case StringConstants.surprisedProduct:
              surprisedProducts.add(temp);
              break;
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
      notifyListeners();
      return 'getProducts';
    }
  }
  Future getCategories() async {
    final Response? response = await _dioHelper.get('category-tag');
    if (response != null && response.data['status']) {
      miniCategories.clear();
      dealCategories.clear();
      sampleCategories.clear();
      for (var c in response.data['records']['shop_minis']) {
        Category temp = Category.fromJson(c);
        miniCategories.add(temp);
      }
      for (var c in response.data['records']['deals_combo']) {
        Category temp = Category.fromJson(c);
        dealCategories.add(temp);
      }
      for (var c in response.data['records']['free_samples']) {
        Category temp = Category.fromJson(c);
        sampleCategories.add(temp);
      }
      notifyListeners();
      return 'getCategories';
    }
  }

  getAllCategories() async {
    final Response? response = await _dioHelper.get('category');
    if (response != null && response.data['status']) {
      categories.clear();
      for (var c in response.data['records']) {
        Category temp = Category.fromJson(c);
        categories.add(temp);
      }
      notifyListeners();
      return 'getAllCategories';
    }
  }

  Future getBrands() async {
    final Response? response = await _dioHelper.get('brand');
    if (response != null && response.data['status']) {
      brands.clear();
      for (var p in response.data['records']) {
        Brand temp = Brand.fromJson(p);
        brands.add(temp);
      }
      notifyListeners();
      return 'getBrands';
    }
  }

  Future getCoupons() async {
    final Response? response = await _dioHelper.get('coupon');
    if (response != null && response.data['status']) {
      coupons.clear();
      for (var o in response.data['records']) {
        Coupon temp = Coupon.fromRes(o);
        coupons.add(temp);
      }
      notifyListeners();
    }
  }

  Future getFeedbacks() async {
    final Response? response = await _dioHelper.get('feedback');
    if (response != null && response.data['status']) {
      feedbacks.clear();
      for (var o in response.data['records']) {
        Feedback temp = Feedback.fromRes(o);
        feedbacks.add(temp);
      }
      notifyListeners();
    }
  }

  Future getSurvayReports() async {
    final Response? response = await _dioHelper.get('reports/${loginDetails?.uId}');
    if (response != null && response.data['status']) {
      reports.clear();
      for (var o in response.data['records']) {
        SurveyReport temp = SurveyReport.fromJson(o);
        reports.add(temp);
      }
      notifyListeners();
    }
  }

  Future getGeneralSettings() async {
    final Response? response = await _dioHelper.get('generalSetting');
    if (response != null && response.data['status']) {
      if (response.data['records'].isNotEmpty) {
        appSettings = Settings.fromJson(response.data['records'][0]);
        notifyListeners();
      }
    }
  }

  Future getVendy() async {
    final Response? response = await _dioHelper.get('vending-machine');
    if (response != null && response.data['status']) {
      vendy = Vendy.fromJson(response.data['record']);
      notifyListeners();
    }
  }

  Future getFaq() async {
    final Response? response = await _dioHelper.get('faq');
    if (response != null && response.data['status']) {
      faqs.clear();
      for (var r in response.data['records']) {
        FAQ temp = FAQ.fromJson(r);
        faqs.add(temp);
      }
      notifyListeners();
    }
  }

  Future getBanners() async {
    final Response? response = await _dioHelper.get('banner');
    if (response != null && response.data['status']) {
      banners.clear();
      for (var r in response.data['records']) {
        Banner temp = Banner.fromJson(r);
        banners.add(temp);
      }
      notifyListeners();
    }
  }
}