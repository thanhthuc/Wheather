//: [Previous](@previous)

import Foundation
import RxRelay
import RxSwift
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

// Filter
let observable = Observable.of(1,2,3,4,5)

observable.filter { value in
   return value > 3
}

.subscribe { value in
   print(value)
} onError: { error in
   print(error)
} onCompleted: {
   print("Completed")
} onDisposed: {
   print("Disposed")
}


// MARK: - Debound
/*
 Only emits an item from an Observable
 if a particular timespan has passed without it emitting another item.
 ===> Note: timespan
 Wait for emiting until enought timespan, if no elemtn emiting, emit last value
 */

// = detail in marble diagram

let deboundObservable = Observable<Int>.of(1,2,3, 4, 5, 6, 7)
let intervalObservable = Observable<Int>
.interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)

Observable
   .zip(deboundObservable, intervalObservable, resultSelector: { e1, e2 in
      return "\(e1) + \(e2)"
   })
.debounce(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
.subscribe { event in
   print(event)
} onDisposed: {
   print("Disposed")
}
.disposed(by: disposeBag)


let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
button.setTitle("Debound button", for: .normal)
button.setTitleColor(.brown, for: .normal)
button
   .rx
   .tap
   .debounce(.seconds(1), scheduler: MainScheduler.instance)
   .subscribe { event in
   print("Tap!!")
}
PlaygroundPage.current.liveView = button


// MARK: - distinctUntilChanged
/*
 distinctUntilChanged() lets us emit a value if it’s different from the previous value. For instance, we could use it to emit weather (temperature) values only if it changes. Or we’d emit new soccer score only if the value has changed.
 */
print("=====distinctUntilChanged=====")
let observableDictint = Observable.of(1,2,2,3,3,2,3)

observableDictint
   .distinctUntilChanged()
   .subscribe { event in
   print(event)
}
print("=====distinctUntilChanged=====")
let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 30))

// Note: let distinctUntilChanged after debounce to have more productive
textField
   .rx
   .text
   .debounce(.seconds(1), scheduler: MainScheduler.instance)
   .distinctUntilChanged()
   .subscribe { event in
      print(event)
   }
PlaygroundPage.current.liveView = textField
