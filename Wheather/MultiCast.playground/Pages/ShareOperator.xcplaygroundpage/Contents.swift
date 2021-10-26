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
let observableHotCold = Observable<Double>.create { observer in
   print("Create observable")
   let nowSecond = Double(NSDate.now.timeIntervalSince1970)
   observer.onNext(nowSecond)
   return Disposables.create {
      print("Disposed observable")
   }
}.share(replay: 1, scope: .whileConnected)

observableHotCold.subscribe({ event in
   print("subscribe 1: \(event.element!)")
}).dispose()

observableHotCold.subscribe({ event in
   print("subscribe 2: \(event.element!)")
})



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




struct ModelAPI {
   var name: String
   var phone: String
}

class Service {
   
   static let shared = Service()
   
   func getData() -> Observable<ModelAPI> {
      print("Create observable")
      return Observable.create { observer in
         DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1) {
            observer.onNext(ModelAPI(name: "Nguyen Van A", phone: "0902706778"))
            observer.onCompleted()
         }
         return Disposables.create {}
      }
   }
}

let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
button.setTitle("get data api", for: .normal)
button.setTitleColor(.brown, for: .normal)
button.backgroundColor = .green
PlaygroundPage.current.liveView = button

let result = button.rx.tap.flatMapLatest { void -> Observable<ModelAPI> in
   return Service.shared.getData()
}.share()

let nameObservable = result.map { model in
   return model.name
}

let phoneObservable = result.map { model in
   return model.phone
}

nameObservable.subscribe { value in
   print(value)
} onError: { error in
   print(error)
} onCompleted: {
   print("Completed")
} onDisposed: {
   print("Disposed")
}

phoneObservable.subscribe { value in
   print(value)
} onError: { error in
   print(error)
} onCompleted: {
   print("Completed")
} onDisposed: {
   print("Disposed")
}

// Note share image
// https://miro.medium.com/max/1400/1*BY0uOtdJCQRsCE0EezjJCQ.png

// Share image
// https://miro.medium.com/max/1400/1*HXti4XjVx6jmLos4YgCWUQ.png


// MARK: - Going deeper


// More agument
let observable = Observable.of("A", "B").share(replay: 1, scope: .forever)
// replay: “How many elements would you like me to replay to new subscribers?”.
// scope:
// https://miro.medium.com/max/1400/1*ZP0rq7dS5dF2zuT_6BRSLA.png


