import UIKit
import RxSwift
import RxCocoa
import RxRelay
import PlaygroundSupport

// MARK: - Part: Share operator

let disposedBag = DisposeBag()

// Hot Observable vs Cold observable

/*
 Example:
 Hot observable:
 -
 Cold observable:
 -
 */

// Hot:
//let observableHotCold = Observable<Double>.create { observer in
//   print("Create observable")
//   let nowSecond = Double(NSDate.now.timeIntervalSince1970)
//   observer.onNext(nowSecond)
//   return Disposables.create {
//      print("Disposed observable")
//   }
//}.share(replay: 1, scope: .whileConnected)
//
//observableHotCold.subscribe({ event in
//   print("subscribe 1: \(event.element!)")
//}).dispose()
//
//observableHotCold.subscribe({ event in
//   print("subscribe 2: \(event.element!)")
//})



//observableHotCold.connect()
/*
 subsribe 1: 1635201934
 subsribe 2: 1635201935
 */
// Question: is this observable cold or hot ?
// ======>
// Cold because it create new Obsevable and new Date and onNext everytime have subscribe

/*
 Make it become cold
 */

// Drivers and Signals: relative with share play

//struct ModelAPI {
//   var name: String
//   var phone: String
//}
//class Service {
//   static let shared = Service()
//   func getData() -> Observable<ModelAPI> {
//      print("Create observable")
//      return Observable.create { observer in
//         DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1) {
//            observer.onNext(ModelAPI(name: "Nguyen Van A", phone: "0902706778"))
//            observer.onNext(ModelAPI(name: "Nguyen Van B", phone: "0902706778"))
//            observer.onNext(ModelAPI(name: "Nguyen Van C", phone: "0902706778"))
//            observer.onCompleted()
//         }
//         return Disposables.create {}
//      }
//   }
//}
//
//let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
//button.setTitle("get data api", for: .normal)
//button.setTitleColor(.brown, for: .normal)
//button.backgroundColor = .green
//PlaygroundPage.current.liveView = button

//let rich1 = BehaviorRelay(value: 1)
//let rich2 = BehaviorRelay(value: 2)
//let rich3 = BehaviorRelay(value: 3)
//
//let observable = Observable<Int>.of(1, 2, 3)
//
//let result = observable.flatMap({ value in
//   return Observable<Int>.just(value)
//})
//.share(replay: 1, scope: .forever)
//
//let nameObservable = result.map { value in
//   return value
//}.subscribe { value in
//   print(value)
//} onError: { error in
//   print(error)
//}
//
//nameObservable.dispose()
//
//let b = result.subscribe()

//let phoneObservable = result.map { value in
//   return value
//}
//.subscribe { value in
//   print(value)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Completed")
//} onDisposed: {
//   print("Disposed")
//}
//.dispose()


// Note share image
// https://miro.medium.com/max/1400/1*BY0uOtdJCQRsCE0EezjJCQ.png

// Share image
// https://miro.medium.com/max/1400/1*HXti4XjVx6jmLos4YgCWUQ.png


// MARK: - Going deeper

//let observable =
// More agument
/*
 Side effect
 */

struct Type {
   var name: String
   var age: String
   init(name: String, age: String) {
      self.name = name
      self.age = age
   }
}
//
//class A {
//   var type: Type
//   init() {
//      type = Type(name: "rich", age: "12")
//   }
//   // Require: do not change type from external
//   // scope
//   func doSomthingWithType(completion: @escaping (Type) -> Void) {
//      completion(type)
//   }
//}
//
//class B {
//   var type: Type
//   init() {
//      type = Type(name: "moreRich", age: "13")
//   }
//}
//
//var a: A = A()
//var b: B = B()
////
/////*
//// Side effect: do ST and do not change value in progress
//// */
//a.doSomthingWithType { type in
//   var newtype = type
////   print(newtype.name)
//   newtype.name = "bill gate"
////   print(newtype.name)
//}
//
//print(a.type.name)
//
//
//let observable = Observable<Type>.of(Type(name: "A", age: "20"), Type(name: "A", age: "20"))
//   .map({ value -> Type in
//      return value
//   })
//   .do { value in
//      print("doOnNext")
//      var newV = value
//      newV.name = "bill gate"
//}
//   afterNext: { value in
//   print("afterNext")
//   print(value)
//} onError: { error in
//   print("onError")
//
//} afterError: { error in
//   print("afterError")
//
//} onCompleted: {
//   print("onCompleted")
//
//} afterCompleted: {
//   print("afterCompleted")
//
//} onSubscribe: {
//   print("onSubscribe")
//
//} onSubscribed: {
//   print("onSubscribed")
//
//} onDispose: {
//
//   print("onDispose")
//}
//   .subscribe { event in
//      print("subscribe \(event)")
//   }

// replay: “How many elements would you like me to replay to new subscribers?”.
// scope:
// https://miro.medium.com/max/1400/1*ZP0rq7dS5dF2zuT_6BRSLA.png

/*
 Let's have a hot Observable we will call Active Sequence, and a cold Passive Sequence.

 Active Sequence emits items all the time , regardless of whether someone subscribed to it or not
 Passive Sequence begins issuing items upon request

 An example of a Passive Sequence is a request to the network, which begins only when we subscribe to a sequence. Examples of Active Sequence are a web-socket connection, timer events, or text produced by UITextField'om.

 */

// MARK: - publish() and his friend connect()
/*
 Connectable Observable is similar to a regular Observable, except for one point. It begins to produce elements not when they subscribe to it, but only when the operator is called on itconnect() .
 */

//let myObservable = Observable.just(1).publish()
//print("Subscribing")
//
//myObservable.subscribe(onNext: {
//    print("first = \($0)")
//})
//myObservable.subscribe(onNext: {
//    print("second = \($0)")
//})
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//    print("Calling connect after 3 seconds")
//    myObservable.connect()
//}
/* Output:
Subscribing
Calling connect after 3 seconds
first = 1
second = 1
*/

/*
 An interesting thing is how resources are cleaned up. Take a look at this code.
 */
//let myObservable = Observable<Int>
//      .interval(.seconds(1), scheduler: MainScheduler.instance)
//      .publish()
//   .refCount()
//
////myObservable.connect()
//
//print("Starting at 0 seconds")
//let mySubscription = myObservable.subscribe(onNext: {
//    print("Next A: \($0)")
//})
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//    print("Disposing at 3 seconds")
//    mySubscription.dispose()
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 6)  {
//   print("Subscribing again at 6 seconds")
//   let mySubscription2 = myObservable.subscribe(onNext: {
//      print("Next B: \($0)")
//   })
//
//   DispatchQueue.main.asyncAfter(deadline: .now() + 3)  {
//      print("Disposing after 3 seconds")
//      mySubscription2.dispose()
//   }
//}

// MARK: - Time to share replay

// https://en.wikipedia.org/wiki/Side_effect_(computer_science)

//let myObservable = Observable<Double>.create { observer in
////   print("Create Observable")
//   let time = NSDate.now.timeIntervalSince1970
//   observer.onNext(time)
//   observer.onNext(time)
//   observer.onNext(time)
//   observer.onNext(time)
//   observer.onError(NSError(domain: "", code: 0, userInfo: nil))
//   return Disposables.create {}
//}
//.share(replay: 2, scope: .whileConnected)
//.debug("source")
////.retry(3)
//
//let firstSubscribe = myObservable.subscribe { value in } onDisposed: {}
//firstSubscribe.dispose()
//let secondSubscribe = myObservable.subscribe { value in } onDisposed: {}
//let thirdSubscribe = myObservable.subscribe { value in } onDisposed: {}
//let fourthSubscribe = myObservable.subscribe { value in } onDisposed: {}
//let fifthSubscribe = myObservable.subscribe { value in } onDisposed: {}
//let sixSubscribe = myObservable.subscribe { value in } onDisposed: {}
//let sevenSubscribe = myObservable.subscribe { value in } onDisposed: {}

/*
 2021-10-29 10:12:22.073: source -> subscribed
 2021-10-29 10:12:22.077: source -> Event next(1635477142.075657)
 2021-10-29 10:12:22.086: source -> isDisposed
 2021-10-29 10:12:22.086: source -> subscribed
 2021-10-29 10:12:22.087: source -> Event next(1635477142.075657)
 2021-10-29 10:12:22.087: source -> Event next(1635477142.086582)
 2021-10-29 10:12:22.087: source -> subscribed
 2021-10-29 10:12:22.087: source -> Event next(1635477142.075657)
 2021-10-29 10:12:22.087: source -> Event next(1635477142.086582)
 2021-10-29 10:12:22.088: source -> subscribed
 2021-10-29 10:12:22.088: source -> Event next(1635477142.075657)
 2021-10-29 10:12:22.088: source -> Event next(1635477142.086582)
 2021-10-29 10:12:22.088: source -> subscribed
 2021-10-29 10:12:22.088: source -> Event next(1635477142.075657)
 2021-10-29 10:12:22.088: source -> Event next(1635477142.086582)
 */
