//
//  ElectronIQApp.swift
//  ElectronIQ
//
//  Created by shamtech07 on 06/12/24.
//

import SwiftUI
import Firebase
import GoogleMobileAds
@main
struct ElectronIQApp: App {
    init(){
        FirebaseApp.configure()
        print("Initializing Google Mobile Ads...")
        MobileAds.shared.start { status in
                    print("Google Mobile Ads initialization completed with status: \(status.adapterStatusesByClassName)")
                }
        print("successfully Configured")
    }
    var body: some Scene {
        WindowGroup {
            Onboarding()
                
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MobileAds.shared.start(completionHandler: nil)
        return true
    }
}
