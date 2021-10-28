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

let rich1 = BehaviorRelay(value: 1)
let rich2 = BehaviorRelay(value: 2)
let rich3 = BehaviorRelay(value: 3)

let observable = Observable<Int>.of(1, 2, 3)

let result = observable.flatMap({ value in
   return Observable<Int>.just(value)
})
.share(replay: 1, scope: .forever)

let nameObservable = result.map { value in
   return value
}.subscribe { value in
   print(value)
} onError: { error in
   print(error)
}

nameObservable.dispose()

let b = result.subscribe()

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

//struct Type {
//   var name: String
//   var age: String
//   init(name: String, age: String) {
//      self.name = name
//      self.age = age
//   }
//}
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
//
///*
// Side effect: do ST and do not change value in progress
// */
//a.doSomthingWithType { type in
//   var newtype = type
////   print(newtype.name)
//   newtype.name = "bill gate"
////   print(newtype.name)
//}
//
////print(a.type.name)
//
//
//let observable = Observable.of("A", "B")
//   .filter({ $0 == "A" })
//   .map({ value -> String in
//      var newV = value
//      newV.append("C")
//      return newV
//   })
//   .do { value in
//      print("doOnNext")
//      var newValue = value
//      newValue.append("ABCD")
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

//func printSecondBoundary() {
//   Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//      .delay(.milliseconds(100), scheduler: MainScheduler.instance)
//      .subscribe { index in
//         print( print("----- t\(index + 1) -----\n"))
//      } onError: { error in
//         print(error)
//      }
//
//}
//
//func delay(second: Double, offset: Double = 0.1, completion: @escaping () -> Void ) {
//   DispatchQueue.global().asyncAfter(deadline: .now() + second - offset) {
//      completion()
//   }
//}
//
//extension ObservableType {
//   func subscribePrintNext(tag: String? = nil) -> Disposable {
//      return subscribe { value in
//         if let tag = tag {
//            print("\(tag) -> \(value)")
//         } else {
//            print("\(value)")
//         }
//      }
//   }
//}
//
//
//print("---------------------o0o----------------------")
//printSecondBoundary()
//let intObservable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//
//intObservable.subscribePrintNext(tag: "Subscription A")
//delay(second: 2) {
//   intObservable.subscribePrintNext(tag: "Subscription B")
//}
//delay(second: 4) {
//   intObservable.subscribePrintNext(tag: "Subscription C")
//}
