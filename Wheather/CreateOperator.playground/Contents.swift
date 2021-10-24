import UIKit
import RxRelay
import RxSwift

//https://medium.com/ios-os-x-development/learn-and-master-%EF%B8%8F-the-basics-of-rxswift-in-10-minutes-818ea6e0a05b


var greeting = "Hello, playground"
var disposedBag:DisposeBag? = DisposeBag()

// Rx là gì Con luon dien

// Rx declaritvie programing

// Truyen thong: imperative programing

//func updateText(value: String) {
//   ///
//   var lablel = UILabel()
//   lablel.text = value
//}
//
//updateText(value: "")
//updateText(value: "")
//updateText(value: "")
//////////////////////////////
//let observable = BehaviorRelay(value: "")
//var lable = UILabel()
//
//observable.accept("")
//
//observable.bind(to: lable.rx.text)

//
// Observable LifeCycle
// Observable can emit three types of events
// .next → An event that “carries” the latest (or “next”) data value.
// .completed → This event terminates the event sequence with success. It won’t emit additional events after complete
// .error → The Observable terminates with an error and will not emit additional events.
// .dispose → To explicitly cancel a subscription, call dispose() on it. After you cancel the subscription, or dispose of it, the observable in the current example will stop emitting events. The .completed and .error will automatically call this method as shown below
// */
//
//// MARK: - Part II: Create operator
//// 1. Just
//// 2. Of
//// 3. From
/// 4. Defer
//// 5. Create
////
//
//
///// Learn from the basic
//// MARK: - Part II: Create operator
//

//var permission = "Permission Photo Old"
//
//var helloSequenceJust = Observable.just(permission) // constant
//
////let helloSequenceFrom = Observable.from(["H","E","L","L","O"])
////
////let helloSequenceOf = Observable.of("Nguyen Thanh Thuc", "Tran Duy Tu")
//
//var elementObservableDefer = Observable.deferred {
//   return Observable<String>.just(permission)
//}

// change permision
// Permission Photo New

//elementObservableDefer.subscribe { string in
//   print(string)
//} onError: { error in
//
//} onCompleted: {
//
//} onDisposed: {
//   print("onDisposed")
//}
//
//permission = "Permission Photo New"


//helloSequenceJust.subscribe { value in
//   print("JUST")
//   print(value)
//} onError: { error in
//   print(error.localizedDescription)
//} onCompleted: {
//   print("Completed")
//} onDisposed: {
//   print("Disposed")
//}

//print("/////////////////////////////////")
//// Example 2: learn just
//helloSequenceFrom.subscribe { value in
//
//   print(value)
//} onError: { error in
//   print(error.localizedDescription)
//} onCompleted: {
//   print("Completed")
//} onDisposed: {
//   print("Disposed")
//}
//print("/////////////////////////////////")

//helloSequenceOf.subscribe { value in
//   print("OF")
//   print(value)
//} onError: { error in
//   print(error.localizedDescription)
//} onCompleted: {
//   print("Completed")
//} onDisposed: {
//   print("Disposed")
//}
//
/////////
//print("")
//print("/////////////////String////////////////")
//print("")
//
//print("CHECK EMPTY")
//Observable<Any>.error(NSError(domain: "", code: 1, userInfo: nil))
//Observable<Any>.empty()
//Observable<Any>.never()
//
//var elements = ["A", "B", "C"]
//
//var elementObservableCreate = Observable<[String]>.create { observer in
//
//   elements = []
//
//   if !elements.isEmpty {
//
//      observer.onNext(elements)
//
//   } else {
//
//      observer.onError(NSError(domain: "Empty", code: 0, userInfo: nil))
//
//   }
//
//   observer.onCompleted()
//
//   return Disposables.create()
//}
//
//extension ObservableType {
//   func customObservable() -> Observable<Any> {
//      return Observable.create { observer in
//
//         observer.onNext("")
//         observer.onError(NSError.init())
//         observer.onCompleted()
//
//         return Disposables.create()
//      }
//   }
//}
//
//elementObservableCreate
//   .subscribe { arrayString in
//   print(arrayString)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}


//
//elements.append("F")
//elements.append("E")
//
//elementObservableCreate.subscribe { value in
//   print(value)
//} onError: { error in
//   print(error.localizedDescription)
//} onCompleted: {
//   print("Complete ----")
//} onDisposed: {
//   print("Disposed ----")
//}
//
//


//var dataString = "Khoi tao string"
//let justObservable = Observable.just(dataString)
//
//
////justObservable.subscribe { string in
////   print(string)
////} onError: { error in
////   print(error)
////} onCompleted: {
////   print("Completed")
////} onDisposed: {
////   print("Disposed")
////}
//
//let deferObservable = Observable.deferred {
//   return Observable.just(dataString)
//}
//
//dataString = "new string"
//
//deferObservable
//   .subscribe { string in
//   print(string)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("disposed")
//}


var datasString = ["Teo", "Phuoc", "Tu", "Thuc"]
let createObservable = Observable<[String]>.create { observer in
   if datasString.isEmpty {
      observer.onError(NSError(domain: "isEmpty", code: 0, userInfo: nil))
   } else {
      observer.onNext(datasString)
   }
   observer.onCompleted()
   return Disposables.create {
      print("Disposed Observable")
   }
}

createObservable
   .subscribe { event in
      switch event {
         case .next(let string):
            print(string)
         case .completed:
            print("Completed")
         case .error(let error):
            print(error)
      }
   }
   .disposed(by: disposedBag!)

