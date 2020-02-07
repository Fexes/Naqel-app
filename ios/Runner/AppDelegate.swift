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
    GMSServices .provideAPIKey("AIzaSyC1vnP9VBQFOKR75J7UR634O2xfZDfW2k8")
    

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
