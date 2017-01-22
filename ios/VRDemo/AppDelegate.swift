//
//  AppDelegate.swift
//  VRDemo
//
//  Created by Christian Schlensker on 1/21/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    let jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index.ios", fallbackResource: nil)
    
    let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "VRDemo", initialProperties: nil, launchOptions: launchOptions)
    
    rootView?.backgroundColor = UIColor.white
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    let rootViewController = UIViewController()
    
    rootViewController.view = rootView
    
    self.window?.rootViewController = rootViewController
    
    self.window?.makeKeyAndVisible()
    
    return true
  }

}
