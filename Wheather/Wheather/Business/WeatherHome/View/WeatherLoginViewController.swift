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
   
   deinit {
      print("Deinit WeatherLoginViewController")
      print("disposeBag: \(disposeBag!)")
   }
   
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   @IBOutlet weak var loginButton: UIButton!
   
   @IBOutlet weak var userNameTextField: UITextField!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var validUserNameLabel: UILabel!
   @IBOutlet weak var validPasswordLabel: UILabel!
   @IBOutlet weak var buttonTestDeboundThrotto: UIButton!
   let disposeBag: DisposeBag? = DisposeBag()
   
   var userValidationViewModel: UserValidationViewModelProtocol!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      testThrottoDebounce()
      setupView()
      setupBinding()
   }
   
   func setupView() {
      activityIndicator.hidesWhenStopped = true
      validPasswordLabel.isHidden = true
      validUserNameLabel.isHidden = true
      validPasswordLabel.textColor = .systemOrange
      validUserNameLabel.textColor = .systemOrange
   }
   
   func setupBinding() {
      userValidationViewModel = UserValidationViewModel(
         usernameTextObservable: userNameTextField.rx.text.orEmpty.asObservable(),
         passwordTextObservable: passwordTextField.rx.text.orEmpty.asObservable())
      
      userValidationViewModel
         .validUserNameObservable()
         .debug()
         .bind(to: validUserNameLabel.rx.isHidden)
         .disposed(by: disposeBag!)
      
      userValidationViewModel
         .validPasswordObservable()
         .debug()
         .bind(to: validPasswordLabel.rx.isHidden)
         .disposed(by: disposeBag!)
      
      userValidationViewModel
         .userMessageErrorObservable
         .debug()
         .bind(to: validUserNameLabel.rx.text)
         .disposed(by: disposeBag!)
      
      userValidationViewModel
         .passwordMessageErrorObservable
         .debug()
         .bind(to: validPasswordLabel.rx.text)
         .disposed(by: disposeBag!)
      
      userValidationViewModel
         .enableLogin()
         .debug()
         .subscribe {[weak self] value in
            self?.loginButton.isEnabled = value
      } onError: { error in
         print(error)
      } onDisposed: {
         print("Disposed")
      }
         .disposed(by: disposeBag!)
      
      loginButton
         .rx
         .tap
         .subscribe { _ in
         
      } onDisposed: {
         print("Disposed")
      }
      .disposed(by: disposeBag!)

      
   }
   
   func testThrottoDebounce() {
      // throttle: interval once after each stage
      // debounce:
      // https://medium.com/fantageek/throttle-vs-debounce-in-rxswift-86f8b303d5d4
      buttonTestDeboundThrotto
         .rx
         .tap
         .debounce(RxTimeInterval.milliseconds(400), scheduler: MainScheduler.instance)
         .flatMapLatest({ value in
            // Reduce request
            return Observable.just(value)
         })
         .subscribe {
            _ in
            print("Tap!!!")
         }
         .disposed(by: disposeBag!)
   }
}
