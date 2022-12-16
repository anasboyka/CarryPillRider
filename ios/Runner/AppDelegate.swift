import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
	GMSServices.provideAPIKey("AIzaSyAU4wureUrYsQ50e-uSH-uikK-HK8Bfw6s")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
