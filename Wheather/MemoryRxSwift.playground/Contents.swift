import UIKit
import RxSwift
import RxRelay

/*
// MARK: - Memory
// withUnretained
*/

class AViewController: UIViewController {
   deinit {
      print("Deinit viewController A")
   }
   let bag = DisposeBag()

   override func viewDidLoad() {
      super.viewDidLoad()
      binding()
   }

   func binding() {

      let publishSubject = PublishSubject<Any>()
      publishSubject
         .subscribe { value in
            print(value)
         
      } onError: { error in
         print(error.localizedDescription)
      } onCompleted: {
         print("Complete")
      } onDisposed: {
         print("Disposed")
      }
      .disposed(by: bag)
      
      publishSubject.withUnretained(self).subscribe { (owner, value) in
         owner.doSomething(withString: value as! String)
      } onError: { error in
         print(error.localizedDescription)
      } onCompleted: {
         print("Completed")
      } onDisposed: {
         print("Disposed")
      }
      
//      publishSubject.subscribe(with: self) { owner, value in
//         owner.doSomething(withString: value as! String)
//      } onError: { owner, error in
//         owner.doSomethingWithError(error: error)
//      } onCompleted: { owner in
//         owner.doSomethingWithComplete()
//      } onDisposed: { owner in
//         owner.doSomethingWhenDisposed()
//      }

      publishSubject.onNext("Element")
//      publishSubject.onError(NSError(domain: "", code: 0, userInfo: nil))
//      publishSubject.onCompleted()
   }
   
   func doSomething(withString string: String) {
      print("print string element: \(string)")
   }
   
   func doSomethingWithError(error: Error) {
      
   }
   
   func doSomethingWithComplete() {
      
   }
   
   func doSomethingWhenDisposed() {
      
   }
}
var vc: AViewController? = AViewController()
vc?.binding()
vc = nil


// MARK: - Best practice memory management
/*
 If the observable completes — with either OnCompleted or OnError —
 then the subscription is already disposed for you.
 Rule of Thumb
 Don’t create a dispose bag in one class, and share it with another class
 You should always add your subscriptions to a DisposeBag, even if you know your sequences will surely terminate (even compiler will not allow you so)
 Official suggestion is to always use .disposed(by: disposeBag) even though that’s not necessary for simple bindings.
 */
