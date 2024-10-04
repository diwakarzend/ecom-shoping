'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"app-release.apk": "8a38cf4645cf928424bc179ce9d777c5",
"assets/AssetManifest.bin": "2b4b36529740b8ce968309c9d5735225",
"assets/AssetManifest.bin.json": "d07f8cc325d2ac07fa76b2a43640913f",
"assets/AssetManifest.json": "2190a3a12f9e34be2862d9e640162e74",
"assets/assets/animations/boll.gif": "68d48aa0f5e48ce9819609308a9cae9b",
"assets/assets/animations/boll1.gif": "9b410c1a65ea33769a694ad1045b8ac0",
"assets/assets/animations/boll12.gif": "5afbf21e2dd589e28c9ecbbee5556cc0",
"assets/assets/animations/loader.json": "3f3523fe1bfb0ab1ced771109844035b",
"assets/assets/animations/loading.gif": "1deae16359b6ef54c2f79ae5338eaa58",
"assets/assets/animations/logo.gif": "8b4a275b5f8a45dd369c3a0070b07214",
"assets/assets/animations/maintenance.json": "f56bd3dd6f1b639b3e7696c1fa2ffb3e",
"assets/assets/animations/no-internet.json": "5456be3d298a413e54b237c8bee9dc78",
"assets/assets/fonts/montserrat/Montserrat-Bold.ttf": "1f023b349af1d79a72740f4cc881a310",
"assets/assets/fonts/montserrat/Montserrat-ExtraBold.ttf": "bd8fb30c6473177cfb9a5544c9ad8fdb",
"assets/assets/fonts/montserrat/Montserrat-Light.ttf": "e65ae7ed560da1a63db603bd8584cfdb",
"assets/assets/fonts/montserrat/Montserrat-Medium.ttf": "b3ba703c591edd4aad57f8f4561a287b",
"assets/assets/fonts/montserrat/Montserrat-Regular.ttf": "3fe868a1a9930b59d94d2c1d79461e3c",
"assets/assets/fonts/montserrat/Montserrat-SemiBold.ttf": "fb428a00b04d4e93deb4d7180814848b",
"assets/assets/fonts/poppins/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/poppins/Poppins-ExtraBold.ttf": "d45bdbc2d4a98c1ecb17821a1dbbd3a4",
"assets/assets/fonts/poppins/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/assets/fonts/poppins/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/fonts/poppins/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/fonts/poppins/Poppins-SemiBold.ttf": "6f1520d107205975713ba09df778f93f",
"assets/assets/images/access.svg": "aaffe4fa4a6323d4482047e1afbcc358",
"assets/assets/images/app_logo.png": "b0d88bffc623b5a1f79eeedb9ce15a85",
"assets/assets/images/app_logo1.png": "0d2a025b0b6d05472da951dd1d0cb769",
"assets/assets/images/app_logo11.png": "a1398ae5a8ecf28083eaf1cde35dbe7d",
"assets/assets/images/app_logo22.png": "81750029920181b6a54c3a4f4f89b968",
"assets/assets/images/app_store.png": "b49178f7553e28496db07307431d27a2",
"assets/assets/images/auth_bg.png": "9f511a8bcc96f797d30e626ac2037e83",
"assets/assets/images/beauty.png": "811370cbf26c15c92a6e684ff917a90a",
"assets/assets/images/beauty2.png": "cc45fdb880ea164a5cb5d5f00e61dc22",
"assets/assets/images/bell.png": "86e5ea2464f4c4f47b079addf0670bde",
"assets/assets/images/bottomimage.png": "f42d180a474b705f8f59b4c7a78308c1",
"assets/assets/images/bran3.png": "06f304bf61d8f010bf57eb8d9a652236",
"assets/assets/images/brand.png": "1d088a59d6505ea27c9aa66278877df9",
"assets/assets/images/brand1.png": "4a530881584405d0855f08b02f3d0bc4",
"assets/assets/images/brand2.png": "399c5d4058083e3ac831fd4465e5d3b5",
"assets/assets/images/brand3.png": "55e9a80c484c1947de73dbe8e8010969",
"assets/assets/images/brand4.png": "3b9143577a33b4d1c9ab1e37f7f5b2ae",
"assets/assets/images/brand5.png": "fd5ae8828f33f2aaf431f534277786fb",
"assets/assets/images/brand6.png": "81a439d2036a053135abd0ddf5184621",
"assets/assets/images/brand7.png": "37e94a0ceb40988104d05b33480a79e3",
"assets/assets/images/brand8.png": "da1b1b9743247b6879ba86b8c66d9b5b",
"assets/assets/images/brand9.png": "b38989f98cebec47ce39e650b84c3394",
"assets/assets/images/brands2.png": "94e6cd64ecc382f308249e423becc0c7",
"assets/assets/images/brands4.png": "ecfb8578c7169594e5c85dd1682f4e4e",
"assets/assets/images/cart.png": "5134835e0fb7d4b1590c7d3efe8cf0b4",
"assets/assets/images/cod.png": "fca4e8e59957c12ed39264320e1b089a",
"assets/assets/images/credit_card.png": "619d3fb25fc5f6574b54913bb64b7581",
"assets/assets/images/easebuzz.svg": "893c15d544f2448de504faef2a6be3a6",
"assets/assets/images/F&B.png": "81ecc74a957d6f1979ee9ac15dd40dfe",
"assets/assets/images/F&G2.png": "81ecc74a957d6f1979ee9ac15dd40dfe",
"assets/assets/images/fab_logo.png": "81750029920181b6a54c3a4f4f89b968",
"assets/assets/images/fab_logo1.png": "d728ec6623f551585bf04824f2c29918",
"assets/assets/images/fab_logo2.png": "b443e85d5a05dc7f2096ff2d8afda998",
"assets/assets/images/face.png": "74856a4fd193a651c08b66ba4ec607e4",
"assets/assets/images/fail.png": "144b28a575e3a13b6bdd911d779a327a",
"assets/assets/images/footer_logo.png": "1d5b86723f5e1898ceec1edcb6f075dd",
"assets/assets/images/frag.png": "5782150f92f80c2830181054cfa42395",
"assets/assets/images/freg2.png": "91bfc150ff967ada8b14c01017cf5943",
"assets/assets/images/Group%252017.png": "0a665b1a76612903f754da30b2f7bb2b",
"assets/assets/images/Group_footer.png": "8f32cf9a4ccccb8f488c666bc5c6fc75",
"assets/assets/images/Group_shop.png": "f08ae457c672823f697d7de6cd713093",
"assets/assets/images/heart.png": "5f03f4075f0e56ee8957e8910ba084dd",
"assets/assets/images/hello.png": "709ebc31caf1a72b4efd2d6f83365880",
"assets/assets/images/home_small.png": "dcd44472213c2f8d1d5ab6f24c1c06b9",
"assets/assets/images/icons/deal.png": "1aa62f4eccd46ba44723b7c7295a204d",
"assets/assets/images/icons/done.png": "df570692d63926f5599701c212827fc6",
"assets/assets/images/icons/happy.png": "58ba349bed8dcc5ff3e83d56d29c2a8f",
"assets/assets/images/icons/home.png": "a5edfa43c5fe9c31fbecaed24accda78",
"assets/assets/images/icons/like.icon.svg": "2a931b0b028f85880f13c39d8733a762",
"assets/assets/images/icons/mini.png": "74b8244a564810e778eb5ee39c6a5b64",
"assets/assets/images/icons/puzzle.png": "95affa3deeb415d618c86cc0f975eaf3",
"assets/assets/images/icons/sad.png": "bb3bf3a414864d5cb0e828b9de7dca54",
"assets/assets/images/icons/sample.png": "7603b968178a6bce4fc0e1ab6bc7b236",
"assets/assets/images/image1.png": "ad5e9e5ef8d1962ae51035d5fc34075c",
"assets/assets/images/info_icon.png": "af91f592a037b5b1a166cbefe349a317",
"assets/assets/images/insta.png": "ac737d286a8ce4fb58ff07bed638eb7a",
"assets/assets/images/logo.png": "5614db40e42b609a86f4e354138d1b0e",
"assets/assets/images/logoss.png": "0a665b1a76612903f754da30b2f7bb2b",
"assets/assets/images/make2.png": "3adee3fee316bcaeff632ee41b417451",
"assets/assets/images/makeup.png": "e9b856f83cbc9b1eda563f0786e83ed4",
"assets/assets/images/master.png": "f22b8d400a245b432a187e3d57459172",
"assets/assets/images/newbanner.png": "03419dee42352d17fa758f5954df697e",
"assets/assets/images/newbanner1.png": "64fdf4c894c67e588673ae83ebe9534a",
"assets/assets/images/pikkr_logo.png": "e2def033e6886d26c37614e794f6d676",
"assets/assets/images/placeholder.svg": "46857e5cdab8d2406dd51624ef1c44d4",
"assets/assets/images/playstore.png": "730a82fdc29af2e3aacc0b23f9cb236b",
"assets/assets/images/product.png": "29151d8ca5a202b66e4bea53cab71825",
"assets/assets/images/razorpay.png": "2e7e51b9f3c5c0947bf4132edf9eefc7",
"assets/assets/images/razorpay.svg": "36ddea3c37df5758f2c63cfadfe8431f",
"assets/assets/images/shipping-cart.png": "4ad67873e8f3830bac27ffde96a31981",
"assets/assets/images/ship_rocket.png": "0dc99e13e8a683f44bd093f476507ca3",
"assets/assets/images/shooping_cart.png": "5c6090402b114188a6eda97b0ddc7415",
"assets/assets/images/shopping-bag.png": "93b4e240e13b16f5fc2677c189761613",
"assets/assets/images/signup_bg_desktop.png": "2598631b1e1e6679dc087093d1079afa",
"assets/assets/images/signup_image.png": "4fed24653921d91b24627b61e9bdd7e1",
"assets/assets/images/singup_bg_desktop_2.png": "375e63ed42012b850ac00943a51aade7",
"assets/assets/images/slider.png": "ee4f4c1f150486462fb40cbfdb9cb8d9",
"assets/assets/images/slider2.png": "21913504e826cd2b40e37d14e4a237ae",
"assets/assets/images/step1.png": "273b59f6c8aef514010e6bb1a02a2579",
"assets/assets/images/step2.png": "1310455ff240c20d23ac2b29d1b1271e",
"assets/assets/images/step3.png": "324e2d877734c082486dfb2c0faa980c",
"assets/assets/images/tick.png": "5b57f532999aa233d3f0facea395d782",
"assets/assets/images/trash_can.svg": "14482d99ce981c2df00665a9dba22b7e",
"assets/assets/images/tweet.png": "bfc27e503ce6b87898a6b590145c04be",
"assets/assets/images/update.png": "657b821d51fff0919acb5869f922f5cf",
"assets/assets/images/upi.png": "dacf5a3f1486f46634062c6c3060491c",
"assets/assets/images/user-check.png": "ef6136b91bc652e305d2b01fc24dd598",
"assets/assets/images/vendy_icon.png": "ce44f39d22061d855ac1277c8b430e97",
"assets/assets/images/view1.png": "53c1c7ba57f806d140581c87fc9494b3",
"assets/assets/images/view2.png": "ba9be1ecc3f329ae62896f0924553803",
"assets/assets/images/view3.png": "e000dede8deec7e0cafd80c321d30e81",
"assets/assets/images/view4.png": "0ca515af33d3ab1c2673b7340e9df21d",
"assets/assets/images/view5.png": "f7db15b670c108a0ff87e78bbb25710c",
"assets/assets/images/view6.png": "ff7303f5e2623e05d8c4d1c3c55f03c5",
"assets/assets/images/viewall.png": "9fe2df63cfbad7c50c56f5ca828cb218",
"assets/assets/images/visa.png": "0f674135c481605258276a9557423cf6",
"assets/assets/images/whislist%2520iicon-01.png": "2667459b7b45f1a55503783d643936f7",
"assets/assets/images/wishlist.png": "6de2334e809b230304b24415c14daf3f",
"assets/assets/images/youtube.png": "9eca8fad9aad9428db12e00f805051e6",
"assets/FontManifest.json": "fd096f7515a2282ef894602134d8efc7",
"assets/fonts/MaterialIcons-Regular.otf": "ef08c15967dfd3da18acc1277e331e1e",
"assets/NOTICES": "9e2808f4e4fcbd2118e58816a0d14a92",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/im_stepper/assets/me.jpg": "487511e754834bdf2e6771376d59707e",
"assets/packages/ionicons/assets/fonts/Ionicons.ttf": "757f33cf07178f986e73b03f8c195bd6",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "81750029920181b6a54c3a4f4f89b968",
"favicon_old.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "839c588788e72b1a962fabebf34992a1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "972d0c23bea2a34aad654369b4e085d9",
"/": "972d0c23bea2a34aad654369b4e085d9",
"main.dart.js": "4c4f489b8ccf3c7e0e76d76c6d0c9756",
"manifest.json": "9261665e7dcfb1738ce78b102cb2ae17",
"version.json": "73a0927c07281cb87121fd7ffb3634be"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
