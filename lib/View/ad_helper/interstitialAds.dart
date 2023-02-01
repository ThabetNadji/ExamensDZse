import 'package:google_mobile_ads/google_mobile_ads.dart';

class interstitlaAds {
  InterstitialAd interstitialAd;
  bool isLoaded = false;
  String idAds = 'ca-app-pub-3513162147938588/4793427372';
  String idAdsTest = 'ca-app-pub-3940256099942544/1033173712';

  // constracter
  interstitlaAds() {
    initAd();
  }

  void initAd() {
    InterstitialAd.load(
        adUnitId: idAds,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: onAdLoaded, onAdFailedToLoad: onAdFailedToLoad));
  }

  void onAdFailedToLoad(LoadAdError adError) {
    onAdFailedToLoad:
    (LoadAdError adError) => interstitialAd = null;
  }

  void onAdLoaded(InterstitialAd ad) {
    interstitialAd = ad;
    isLoaded = true;
    interstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      interstitialAd.dispose();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      interstitialAd.dispose();
    });
  }
}
