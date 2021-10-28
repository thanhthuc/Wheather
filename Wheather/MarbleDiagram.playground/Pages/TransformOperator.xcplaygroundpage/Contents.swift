//: [Previous](@previous)

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

//: [Next](@next)

// MARK: - Part III: Transform operator
// 1. map
// 2. flatMap
// 3. flatMapLatest
// 4. Scan
// 5. Reduce

//let observables = Observable.of("A", "B", "C", "D", "E")

//print("===============")
//print("MAP")
//print("===============")
//observables.map { value in
//   return "result \(value)"
//}.subscribe { value in
//   print(value)
//} onError: { error in
//   print(error)
//}

//print("===============")
//print("MAP, FLATMAP, FLATMAPLATEST, CONCATMAP")
//print("===============")

//let observables = Observable.of("A", "B", "C", "D", "E")

//observables.map { value in
//   return "result: \(value)"
//}.subscribe { value in
//   print(value)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}

//observables.flatMap { value in
//   return Observable<String>.just("result\(value)")
//}.subscribe { value in
//   print(value)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}

//observables.flatMap { value in
//   return Observable<String>.create { (observer: AnyObserver<String>) in
//      DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.5) {
//         observer.onNext("result \(value)")
//         observer.onCompleted()
//      }
//      return Disposables.create()
//   }
//}.subscribe { value in
//   print(value)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}



//print("===============")
//print("FLATMAPLATEST")
//print("===============")
//
//observables
//   .flatMapLatest { string -> Observable<String> in
//      return Observable<String>.create { observer in
//         DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
//            observer.onNext(string)
//         }
//         return Disposables.create {
//            print("Disposed \(string)")
//         }
//      }
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


// https://medium.com/@jshvarts/read-marble-diagrams-like-a-pro-3d72934d3ef5

// MARK: - Scan
/*
 accumulate for each element
 */
//let observable = Observable<Int>.of(1,2,8,4,5)
//
//observable.scan(into: 0) { inoutA, element in
//   inoutA = inoutA + element
//}
//.subscribe { event in
//   print(event)
//}
/*
 1
 3
 11
 15
 20
 */




// MARK: - Reduce
// http://reactivex.io/documentation/operators/reduce.html
// http://reactivex.io/documentation/operators/sum.html
/*
 accumulate to final result
 */
//let observable = Observable<Int>.of(1,2,8,4,5)
//observable.reduce(1) {
//   result, element in
//   return result * element
//} mapResult: {
//   value in
//   return value * 2
//}
//.subscribe { event in
//   print(event)
//}

//let scoreAObservable = BehaviorRelay(value: 10)
//let scoreBObservable = BehaviorRelay(value: 20)
//let scoreCObservable = BehaviorRelay(value: 30)
//
//let observables = Observable.of(scoreAObservable, scoreBObservable, scoreCObservable)
//
//observables.flatMapLatest { observable in
//   return observable
//}
//.subscribe { event in
//   print(event)
//}
//
//scoreAObservable.accept(100)
//scoreBObservable.accept(200)
//scoreCObservable.accept(300)

//let observableTrigger = Observable<Int>.of(1,2,3)
//
//observableTrigger
//   .flatMap { value in
//      return Observable<Int>.create { observer in
//         DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
//            observer.onNext(value)
//         }
//         return Disposables.create()
//      }
//   }
//   .subscribe { value in
//      print(value)
//   } onError: { error in
//      print(error)
//   }
//   .disposed(by: disposeBag)



//let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
//button.setTitle("Button", for: .normal)
//button.backgroundColor = .brown
//
//button
//   .rx
//   .tap
//   .flatMapLatest { void in
//   return Observable<String>.create { observer in
//      DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
//         observer.onNext("Result API")
//      }
//      return Disposables.create()
//   }
//}.subscribe { event in
//   print(event)
//}
//
//PlaygroundPage.current.liveView = button
