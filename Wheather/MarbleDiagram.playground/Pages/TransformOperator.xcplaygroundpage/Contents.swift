//: [Previous](@previous)

import Foundation
import RxSwift
import RxRelay
import RxCocoa

let disposeBag = DisposeBag()

//: [Next](@next)

// MARK: - Part III: Transform operator
// 1. map
// 2. flatMap
// 3. flatMapLatest
// 4. Scan
// 5. Buffer
// 6. GroupBy

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


let observables = Observable.of("A", "B", "C")
observables
   .flatMapLatest { string -> Observable<String> in
      
      return Observable<String>.create { observer in
         
         DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            observer.onNext(string)
         }
         return Disposables.create {
            print("Disposed")
         }
      }
}.subscribe { score in
   print(score)
} onError: { error in
   print(error)
} onCompleted: {
   print("Complete")
} onDisposed: {
   print("Disposed")
}
.disposed(by: disposeBag)



