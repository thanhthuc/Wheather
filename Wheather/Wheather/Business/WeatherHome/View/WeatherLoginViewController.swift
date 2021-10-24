//
//  LoginViewController.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 24/10/2021.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class WeatherLoginViewController: UIViewController {
   
   @IBOutlet weak var buttonTestDeboundThrotto: UIButton!
   let disposeBag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      
      // throttle: interval once after each stage
      // debounce:
      // https://medium.com/fantageek/throttle-vs-debounce-in-rxswift-86f8b303d5d4
      buttonTestDeboundThrotto
         .rx
         .tap
         .throttle(RxTimeInterval.milliseconds(400), scheduler: MainScheduler.instance)
         //.debounce(RxTimeInterval.milliseconds(400), scheduler: MainScheduler.instance)
         .flatMapLatest({ value in
            // Reduce request
            return Observable<Any>.create { observe in
               
               // Task bat dong bo
               let task = URLSession.shared.dataTask(with: URL(string: "")!) { data, response, error in
                  
                  // Last data
               }
               task.resume()
               
               return Disposables.create()
            }
         })
         
         .subscribe {
            _ in
            print("Tap!!!")
         }
         .disposed(by: disposeBag)
      
      
   }
   
   
}
