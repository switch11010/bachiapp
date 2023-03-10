import UIKit
import Flutter
import GoogleMaps // 追加
import flutter_config

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey(FlutterConfigPlugin.env(for: "GOOGLE_MAPS_IOS_API_KEY")) // 追加
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
