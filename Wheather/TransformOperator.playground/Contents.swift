import UIKit
import RxRelay
import RxSwift

let disposeBag = DisposeBag()

// MARK: - Part III: Transform operator

// 1. map
// 2. flatMap
// 3. flatMapLatest
// 4. Scan
// 5. Buffer
// 6. GroupBy

let observable = Observable<String>.from(["Tu" ?? "", "Thuc" ?? ""])

//observable.flatMap { value -> Observable<String> in
//   return Observable.create { observer in
//      // Bat dong bo
//      // next
//      // error
//      // complete
//      observer.onNext(value)
//      observer.onCompleted()
//      return Disposables.create()
//   }
//}
//.subscribe { value in
//   print(value)
//} onError: { error in
//
//} onCompleted: {
//
//} onDisposed: {
//}

//observable.flatMapLatest { value -> Observable<String> in
//
//   return Observable.create { observer in
//      // Bat dong bo
//      // next
//      // error
//      // complete
//      observer.onNext(value)
//      observer.onCompleted()
//      return Disposables.create()
//   }
//}
//.subscribe { value in
//   print(value)
//} onError: { error in
//
//} onCompleted: {
//
//} onDisposed: {
//
//}

//var phuoc = BehaviorRelay(value: 0)
//var thanhthuc = BehaviorRelay(value: 1)
//var vanTeo = BehaviorRelay(value: 2)
//
//let observableEvents = Observable.of(phuoc, thanhthuc, vanTeo)
//
//observableEvents.flatMap { behaviorRelay -> Observable<Int> in
//   return behaviorRelay.asObservable()
//}.subscribe { value in
//   print(value)
////   self?.abcd()
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Completed")
//} onDisposed: {
//   print("Disposed")
//}
//.disposed(by: disposeBag)
//
//phuoc.accept(100)
//thanhthuc.accept(200)
//vanTeo.accept(0)

//var array = [["1"], ["2"], ["6"], ["4", "5"]]
//
//let result = array.flatMap { array in
//   return array
//}
////print(result)
//
//
//let teoScore = BehaviorRelay(value: 0)
//let giauScore = BehaviorRelay(value: 1)
//let richScrore = BehaviorRelay(value: 2)
//
//var observables = Observable.of(teoScore, giauScore, richScrore)
//
//var observablesArray = Observable.just([1, 2, 3])
//
//observablesArray.flatMap { arrayInt -> Observable<[Int]> in
//
////   let taskAsync = URLSession
//   return Observable.of(arrayInt)
//}.subscribe { array in
//   print(array)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//
//}
//
//
//
//
//
//
//observables
//   .flatMapLatest { behaviorRelay -> Observable<Int> in
//   return behaviorRelay.asObservable()
//}.subscribe { score in
//   print(score)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}
//.disposed(by: disposeBag)
//
//teoScore.accept(10)
//giauScore.accept(100)
//richScrore.accept(200)
//

let behaviorRelay = BehaviorRelay(value: 0)

behaviorRelay.accept(100)
behaviorRelay.accept(200)
behaviorRelay.accept(300)

behaviorRelay.flatMap { value in
   return Observable.just(value)
}
.subscribe { value in
   print(value.element!)
}

behaviorRelay.accept(400)
behaviorRelay.accept(500)
behaviorRelay.accept(600)
