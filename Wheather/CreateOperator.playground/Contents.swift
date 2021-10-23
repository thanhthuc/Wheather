import UIKit
import RxRelay
import RxSwift

//https://medium.com/ios-os-x-development/learn-and-master-%EF%B8%8F-the-basics-of-rxswift-in-10-minutes-818ea6e0a05b


var greeting = "Hello, playground"

/*
 Observable LifeCycle
 Observable can emit three types of events
 .next → An event that “carries” the latest (or “next”) data value.
 .completed → This event terminates the event sequence with success. It won’t emit additional events after complete
 .error → The Observable terminates with an error and will not emit additional events.
 .dispose → To explicitly cancel a subscription, call dispose() on it. After you cancel the subscription, or dispose of it, the observable in the current example will stop emitting events. The .completed and .error will automatically call this method as shown below
 */

// MARK: - Part II: Create operator
// 1. Just
// 2. Of
// 3. From
// 4. Create
// 5. Defer


/// Learn from the basic
// MARK: - Part II: Create operator

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

var elementObservableCreate = Observable<[String]>.create { observer in
   observer.onNext(elements)
   observer.onCompleted()
   return Disposables.create {}
}
var elementObservableDefer = Observable.deferred {
   return Observable.from(elements)
}

elements.append("F")
elements.append("E")

elementObservableCreate.subscribe { value in
   print(value)
} onError: { error in
   print(error.localizedDescription)
} onCompleted: {
   print("Complete ----")
} onDisposed: {
   print("Disposed ----")
}
