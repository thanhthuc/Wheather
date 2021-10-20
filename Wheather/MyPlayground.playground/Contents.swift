import UIKit
import RxSwift
import RxRelay
let disposeBag = DisposeBag()

/// Learn from the basic
// MARK: - Part I: Create operator

let helloSequenceJust = Observable.just(["H","E","L","L","O"])
let helloSequenceFrom = Observable.from(["H","E","L","L","O"])
let helloSequenceOf = Observable.of(["H","E","L","L","O"])

helloSequenceJust.subscribe { value in
   print("JUST")
   print(value)
} onError: { error in
   print(error.localizedDescription)
} onCompleted: {
   print("Completed")
} onDisposed: {
   print("Disposed")
}
print("/////////////////////////////////")
// Example 2: learn just
helloSequenceFrom.subscribe { value in
   print("FROM")
   print(value)
} onError: { error in
   print(error.localizedDescription)
} onCompleted: {
   print("Completed")
} onDisposed: {
   print("Disposed")
}
print("/////////////////////////////////")
helloSequenceOf.subscribe { value in
   print("OF")
   print(value)
} onError: { error in
   print(error.localizedDescription)
} onCompleted: {
   print("Completed")
} onDisposed: {
   print("Disposed")
}

///////
print("")
print("/////////////////String////////////////")
print("")

var elements = ["A", "B", "C"]

print("CHECK EMPTY")
Observable<Any>.error(NSError(domain: "", code: 1, userInfo: nil))
Observable<Any>.empty()
Observable<Any>.never()

//var elementObservable = Observable<[String]>.create { observer in
//   observer.onNext(elements)
//   observer.onCompleted()
//   return Disposables.create {}
//}
var elementObservable = Observable.deferred {
   return Observable.from(elements)
}

elements.append("F")
elements.append("E")

elementObservable.subscribe { value in
   print(value)
} onError: { error in
   print(error.localizedDescription)
} onCompleted: {
   print("Complete ----")
} onDisposed: {
   print("Disposed ----")
}

// MARK: - Part II: Multi threading & Sheduler
/*
 Schedulers
 We will start with a little bit of theory about schedulers. When we are doing some operations with Rx, by definition it is all done on the same thread. Unless you don’t change the thread manually, entry point of the chain will begin on the current thread and it will also dispose on the same thread.

 Schedulers are not really a threads, but as the name suggests they are scheduling the tasks that they are given. We have 2 types of schedulers: serial and concurrent. Below is the list with the schedulers that are already built-in:
 */





// MARK: - Part III: Transform operator

// 1. map
// 2. flatMap
// 3. flatMapLatest
// 4. Scan
// 5. Buffer
// 6. GroupBy


// MARK: - Part IV: Combine operator
// 1. StartWith
// 2. Merge
// 3. Zip
// 4. Concat
// 5. CombineLatest
// 6. SwitchLatests


// MARK: - Part V: Filter operator
// 1. Filter
// 2. DistinctUntilChanged
// 3. Debounce
// 4. TakeDuration
// 5. Skip
// 6. Throtto


// MARK: - Part VI: API reduce request & replay operator

// MARK: - Part VII: Share operator


// MARK: - Part VII: IN Practice: Search API simulate and validation simulate for FORM TEXTFIELD

