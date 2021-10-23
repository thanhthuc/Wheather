//
//  ViewController.swift
//  MasterFindingLeaks
//
//  Created by Nguyen Thanh Thuc on 23/10/2021.
//

import UIKit

class ViewController: UIViewController {
   
   var rootVC: LoginViewController?
   
   deinit {
      print("De init ViewController")
   }

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
//      setupCallBack()
//      rootVC?.callCallBack()
   }
   
   func setupCallBack() {
      if let rootVC = rootVC {
         rootVC.completion = { [weak self] in
            self?.dosomthing()
         }
      }
   }
   
   func dosomthing() {
      print("Do somthing")
   }
   
   

   
}

