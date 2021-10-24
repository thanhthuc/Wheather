import UIKit
import RxSwift
import RxRelay

var disposeBag: DisposeBag? = DisposeBag()

// MARK: - Part I: How many subject in RxSwift, what difference between subject and Observable

// 5. Phan biet Observable vs Subject

// 1. PublishSubject
// 2. PublishRelay
// 3. BehaviorSubject
// 4. ReplaySubject
// 5. Variable (Deprecate) = BehaviorReplay

//let publishSubject = PublishSubject<String>()
//publishSubject.onNext("Teo")
//publishSubject
//   .subscribe { string in
//   print(string)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}
//.disposed(by: disposeBag!)
//publishSubject.onNext("Teo 1")
//publishSubject.onCompleted()
//

//let publishRelay = PublishRelay<String>()
//publishRelay.accept("nguyen van giau1")
//publishRelay
//   .subscribe { string in
//   print(string)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}
//.disposed(by: disposeBag!)
//
//publishRelay.accept("nguyen van giau")

//let behaviorSubject = BehaviorSubject(value: "")
//
//behaviorSubject.onNext("ABCD")
//behaviorSubject.onNext("EF")
//
//behaviorSubject
//   .subscribe { string in
//   print(string)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}
//.disposed(by: disposeBag!)
//
//behaviorSubject.onNext("ABCD")
//behaviorSubject.onNext("EF")

//let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
//
//replaySubject.onNext("ABCDE1")
//replaySubject.onNext("ABCDE2")
//replaySubject.onNext("ABCDE3")
//replaySubject.onNext("ABCDE4")
//replaySubject.onNext("ABCDE5")
//
//replaySubject
//   .subscribe { string in
//   print(string)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}
//.disposed(by: disposeBag!)
//
//replaySubject.onNext("ABCDE4")

// Replacement = Wrapper = Group = Relay
//let behaviorRelay = BehaviorRelay(value: "Giau")
//
//behaviorRelay
//   .subscribe { string in
//   print(string)
//} onError: { error in
//   print(error)
//} onCompleted: {
//   print("Complete")
//} onDisposed: {
//   print("Disposed")
//}
//.disposed(by: disposeBag!)
//
//behaviorRelay.accept("ABCD")
