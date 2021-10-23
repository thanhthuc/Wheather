//
//  AppDelegate.swift
//  MasterFindingLeaks
//
//  Created by Nguyen Thanh Thuc on 23/10/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


   var window: UIWindow?
//   var viewControllerRoot: ViewController?
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      
//      let sb = UIStoryboard.init(name: "Main", bundle: nil)
//      viewControllerRoot = sb.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
//
//      window?.addSubview(viewControllerRoot!.view)
//      window?.rootViewController = viewControllerRoot
//      window?.makeKeyAndVisible()
      
      return true
   }

   // MARK: UISceneSession Lifecycle
   
   deinit {
   }
  

}

