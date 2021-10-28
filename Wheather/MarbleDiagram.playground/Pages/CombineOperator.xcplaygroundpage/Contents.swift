import UIKit
import RxRelay
import RxSwift
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

// MARK: - Combine
// 1. StartWith
// 2. Merge
// 3. Zip
// 4. Concat
// 5. CombineLatest


// MARK: - StartWith
/*
 emit a specified sequence of items before beginning to emit the items from the source Observable
 */
// http://reactivex.io/documentation/operators/startwith.html

//let observableStartWith = Observable<Int>.of(2,3)
//observableStartWith
//   .startWith(0)
//   .subscribe { event in
//      print(event)
//   }

//
//// MARK: - Merge
//// http://reactivex.io/documentation/operators/merge.html
//
//let observableMergeA = Observable<Int>.of(1,2,3)
//let observableMergeB = Observable<Int>.of(4,5,6)
//
//Observable
//   .merge(observableMergeA, observableMergeB)
//   .subscribe { event in
//      print(event)
//   }

//// MARK: - Zip
//// http://reactivex.io/documentation/operators/zip.html
///*
// Combines the emissions of multiple Observables together via a specified function.
// Combine by pair together
// */

//let observableMergeA = Observable<String>.of("N","T","W","E","R")
//let observableMergeB = Observable<Int>.of(4,5,6)
//Observable
//   .zip(observableMergeA, observableMergeB)
//   .subscribe { event in
//      print(event)
//   }

///*
// run each item at each stage of time, see provious result, then if it unzip, pair it
// */
//
//// MARK: - Concat
//// http://reactivex.io/documentation/operators/concat.html
///*
// Emit the items from two or more Observables without interleaving them.
// */
//let observableA = Observable.of(1,2,3,5)
//let observableB = Observable.of(3,4,5,6,7)
//observableA
//   .concat(observableB)
//   .subscribe { value in
//      print(value)
//   } onError: { error in
//      print(error)
//   }
// MARK: - Combine latest
///*
// Here we have 2 observable streams (let’s call them S1 and S2) emitted: circles with values 1, 2, 3, 4, 5 and circles with values A, B, C, D. Our combineLatest() operator concatenates the values for both and emits it in the resulting Observable (e.g. when item “1” is combined with item “A”, the result will be a “1A” emission). Whenever, any of the streams emits an item (as long as there was at least 1 item already emitted by the other source stream, the new combined item is emitted in the resulting stream
// */

//let observableA = Observable.of(1,2,3,5)
//let observableB = Observable.of(3,4,5,6,7)
//
//Observable
//   .combineLatest(observableA, observableB)
//   .subscribe { event in
//      print(event)
//   }
//   .dispose()
///*
// */
//
/*
 13
 23
 24
 34
 35
 55
 56
 57
 */
