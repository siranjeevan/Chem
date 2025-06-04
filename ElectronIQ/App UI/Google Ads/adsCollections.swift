import Foundation
import GoogleMobileAds
import SwiftUI

// Banner Ad View
struct AdBannerView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> BannerView {
        let bannerView = BannerView(adSize: AdSizeBanner) // Or use adSizeFor(cgSize: CGSize(width: 320, height: 50)) if defined
        bannerView.adUnitID = "ca-app-pub-7374460951052927/8744038682"
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            bannerView.rootViewController = windowScene.windows.first?.rootViewController
        }
        
        bannerView.load(Request())
        return bannerView
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
}

// Interstitial Ad Manager
class MyInterstitialAd: NSObject, ObservableObject, FullScreenContentDelegate {
    @Published var isAdReady = false
    private var interstitialAd: InterstitialAd?
    
    override init() {
        super.init()
        loadAd()
    }
    
    func loadAd() {
        print("Loading interstitial ad...")
        let request = Request()
        InterstitialAd.load(with: "ca-app-pub-3940256099942544/4411468910", request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                self.isAdReady = false
                return
            }
            print("Interstitial ad loaded successfully")
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
            self.isAdReady = true
        }
    }
    
    func presentAd(from rootViewController: UIViewController) {
        if let ad = interstitialAd {
            print("Attempting to present interstitial ad...")
            ad.present(from: rootViewController)
        } else {
            print("Interstitial ad not ready, loading a new ad...")
            loadAd()
        }
    }
    
    // MARK: GADFullScreenContentDelegate Methods
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("Interstitial ad dismissed")
        isAdReady = false
        loadAd()
    }
    
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Interstitial ad failed to present with error: \(error.localizedDescription)")
        isAdReady = false
        loadAd()
    }
}
