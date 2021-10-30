//
//  UserValidationViewModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 27/10/2021.
//

import Foundation
import RxSwift
import RxRelay

protocol UserValidationViewModelProtocol {
   func validUserNameObservable() -> Observable<Bool>
   func validPasswordObservable() -> Observable<Bool>
   func enableLogin() ->Observable<Bool>
   var isLoadingApiLoginUserObservable: Observable<Bool> { get }
   var userMessageErrorObservable: Observable<String> { get }
   var passwordMessageErrorObservable: Observable<String> { get }
   func loginApiObservable() -> Observable<Result<Any, Error>>
}

class UserValidationViewModel: UserValidationViewModelProtocol {
   
   // MARK: - Protocol implement
   var userMessageErrorObservable: Observable<String>
   var passwordMessageErrorObservable: Observable<String>
   var isLoadingApiLoginUserObservable: Observable<Bool>
   
   // MARK: - Private property
   private var isLoadingApiLoginUserBehavior = BehaviorRelay(value: false)
   private var userMessageErrorBehavior = BehaviorRelay(value: "")
   private var passwordMessageErrorBehavior = BehaviorRelay(value: "")
   private var usernameTextObservable: Observable<String>
   private var passwordTextObservable: Observable<String>
   
   
   init(usernameTextObservable: Observable<String>,
        passwordTextObservable: Observable<String>) {
      // init access property
      self.isLoadingApiLoginUserObservable = isLoadingApiLoginUserBehavior.asObservable()
      self.userMessageErrorObservable = userMessageErrorBehavior.asObservable()
      self.passwordMessageErrorObservable = passwordMessageErrorBehavior.asObservable()
      
      // Init injection
      self.usernameTextObservable = usernameTextObservable
      self.passwordTextObservable = passwordTextObservable
   }
   
   func validUserNameObservable() -> Observable<Bool> {
      return usernameTextObservable
         .filter {!$0.isEmpty}
         .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
         .distinctUntilChanged()
         .map {[weak self] text in
            if text.isEmail() {
               return true
            } else {
               self?.userMessageErrorBehavior.accept("Username should format like email!")
               return false
            }
         }
   }
   
   func validPasswordObservable() -> Observable<Bool> {
      return passwordTextObservable
         .filter {!$0.isEmpty}
         .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
         .distinctUntilChanged()
         .map {[weak self] text in
            if text.count > 3 {
               return true
            } else {
               self?.passwordMessageErrorBehavior.accept("password should more than 3 character")
               return false
            }
         }
   }
   
   func enableLogin() -> Observable<Bool> {
      return Observable
         .combineLatest(
            usernameTextObservable,
            passwordTextObservable) { value1, value2 in
            if value1.isEmpty || value2.isEmpty {
               return false
            }
            return value1.isEmail() && value2.count > 3
         }
   }
   
   func loginApiObservable() -> Observable<Result<Any, Error>> {
      isLoadingApiLoginUserBehavior.accept(false)
      return Observable<Result<Any, Error>>.create { observer in
         DispatchQueue.global(qos: .background)
            .asyncAfter(deadline: .now() + 1) {
               self.isLoadingApiLoginUserBehavior.accept(true)
               observer.onNext(.success(true))
               observer.onCompleted()
            }
         return Disposables.create()
      }
   }
}
