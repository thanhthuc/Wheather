import UIKit
import RxSwift
import RxRelay

let disposeBag = DisposeBag()

// MARK: - Part I: How many subject in RxSwift, what difference between subject and Observable

// 1. PublishSubject
// 2. BehaviorSubject
// 3. ReplaySubject
// 4. Variable (Deprecate) = BehaviorReplay

// MARK: - Public subject
let publishSubject = PublishSubject<String>()
publishSubject.onNext("Before subscribe") // Do not receive onNext event before subscribe
//publishSubject.onCompleted() // It do complete or error before subscribe

publishSubject.subscribe { event in
   print(event.event)
}.disposed(by: disposeBag)

publishSubject.onCompleted()
publishSubject.onNext("After subscribe")


// MARK: - Behavior subject
// Behavior mean it will only emit latest event for new subscribe, stores the most recent next() event
let behaviorSubject = BehaviorSubject(value: "data emit")
behaviorSubject.onNext("from")
behaviorSubject.onNext("fromA")
behaviorSubject.onNext("fromB")

behaviorSubject
   .subscribe { string in
   print(string)
   }.disposed(by: disposeBag)

behaviorSubject.onNext("from")
behaviorSubject.onNext("from1")
behaviorSubject.onNext("from2")


// MARK: - ReplaySubject
// As its name suggests, the ReplaySubject provides you the ability to replay many next events.
// Relay mean next last elements before subscribe
let relaySubject = ReplaySubject<String>.create(bufferSize: 6)
relaySubject.onNext("Replay0")
relaySubject.onNext("Replay1")
relaySubject.onNext("Replay2")
relaySubject.onNext("Replay3")
relaySubject.onNext("Replay4")
relaySubject.onNext("Replay5")
relaySubject.onNext("Replay6")
relaySubject.onNext("Replay7")
relaySubject.onNext("Replay8")

relaySubject.subscribe { event in
   print(event)
}

relaySubject.onNext("Relay ABCD")
relaySubject.onNext("Relay ABCD")
relaySubject.onNext("Relay ABCD")
relaySubject.onNext("Relay ABCD")
relaySubject.onNext("Relay ABCD")
relaySubject.onNext("Relay ABCD")
relaySubject.onNext("Relay ABCD")
relaySubject.onNext("Relay ABCD")

// MARK: - Behavior replay = Variable
/*
 Variables do not allow for early termination. In other words, you cannot send an error() or completed() event to terminate the sequence. You simply wait for the Variable to be deallocated and terminate the sequence itself in its deinit method.
 */
let behaviorReplay = BehaviorRelay(value: "ABCD")
behaviorReplay.accept("New ABCD")
behaviorReplay.accept("New ABCD")
behaviorReplay.accept("New ABCD")
behaviorReplay.subscribe { event in
   print(event.event)
}

behaviorReplay.accept("New ABCD")

