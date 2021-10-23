//
//  LoginViewController.swift
//  MasterFindingLeaks
//
//  Created by Nguyen Thanh Thuc on 23/10/2021.
//

import UIKit

class LoginViewController: UIViewController {
   
   deinit {
      print("De init Login ViewController")
   }
   
   var completion: (() -> Void)?
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }
   
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      super.prepare(for: segue, sender: sender)
//
//
//      print("Prepare for next")
////      let nextVC = segue.destination as! ViewController
////      nextVC.rootVC = self
//   }
   
   func callCallBack() {
      completion?()
   }
   
   
   /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    }
    */
   
}
