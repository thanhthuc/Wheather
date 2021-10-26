import UIKit
import RxSwift
import RxRelay
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Multi threading & Sheduler
/*
 doSomethingRx()
     .subscribeOn(BackgroundScheduler)
     .doAnotherThing()
     .observeOn(ComputationScheduler)
     .doSomethingElse()
     .observeOn(MainScheduler)
     .subscribe(//...)
 
 ==> observeOn decided thread excute
 ==> Result: main thread
 */

// Networking
// Way 1:
// Using create operator

//struct UserModel: Codable {
//   var name: String
//   var email: String
//}
//
//let mockData =
//"""
//{
//    "name": "Nguyen Van A",
//    "email": "A@gmail.com",
//}
//""".data(using: String.Encoding.utf8)
//
//func obserDataFromServer() -> Observable<UserModel> {
//
//   return Observable.create { observer in
//
//      let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric"
//      let url = URL(string: urlString)!
//      let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//         guard error == nil else {
//            observer.onError(error!)
//            return
//         }
//         guard let data = mockData else {
//            observer.onError(NSError(domain: "", code: 0, userInfo: nil))
//            return
//         }
//         do {
//            let userModel = try JSONDecoder().decode(UserModel.self, from: data)
//            observer.onNext(userModel)
//            observer.onCompleted()
//         } catch let error {
//            observer.onError(error)
//         }
//      }
//      task.resume()
//      return Disposables.create()
//   }
//}
//
//obserDataFromServer().subscribe { userModel in
//   print(userModel.name)
//   print(userModel.email)
//} onError: { error in
//   print("ERROR: \(error.localizedDescription)")
//} onCompleted: {
//   print("Api chain Completed")
//} onDisposed: {
//   print("Api chain Disposed")
//}
//.disposed(by: disposeBag)
//
//
//// Way 2: using rx session
//func obserDataFromServerVer2() -> Observable<UserModel> {
//   let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric"
//   let url = URL(string: urlString)!
//
//   return Observable
//      .just(url)
//      .flatMap { urlObservable -> Observable<(response:HTTPURLResponse, data: Data)> in
//      let request = URLRequest(url: urlObservable)
//      return URLSession
//         .shared
//         .rx
//         .response(request: request)
//   }
//      .map { (response, data) -> UserModel in
//      if 200..<300 ~= response.statusCode {
//         // Parse data
//         let userModel = try JSONDecoder().decode(UserModel.self, from: mockData!)
//         return userModel
//      } else {
//         // emit error
//         throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
//      }
//   }.asObservable()
//}
//
//obserDataFromServerVer2().subscribe { usermodel in
//
//   print("API version 2")
//   print(usermodel)
//
//} onError: { error in
//   print(error.localizedDescription)
//} onCompleted: {
//   print("Completed")
//} onDisposed: {
//   print("Disposed")
//}
//.disposed(by: disposeBag)
//
//
//
//// Multi threading
//let observable = Observable<String>
//   .just("element")
//   .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
//   .observe(on: MainScheduler.instance)
//   .map({ string in
//      return "Map\(string)"
//   })
//   .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
//   .subscribe { event in
//      print(event.event)
//      print(Thread.current)
//   }

//struct PhuocModel: Codable {
//   var name: String
//   var email: String
//}
//
//func loadRequest(completion: @escaping (PhuocModel?, Error?) -> ()) {
//   let url = URL(string: "")
//   let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//
//      guard error == nil else {
//         completion(nil,error)
//         return
//      }
//      guard data != nil else {
//         completion(nil, NSError(domain: "", code: 0, userInfo: nil))
//         return
//      }
//      // Parse data
//      let decoder = JSONDecoder()
//      do {
//         let dataModel = try decoder.decode(PhuocModel.self, from: data!)
//         completion(dataModel, nil)
//      } catch let error {
//         completion(nil, error)
//      }
//   }
//   task.resume()
//}
//
//func loadReuquestObservable() -> Observable<PhuocModel> {
//   return Observable.create { observer in
//      let url = URL(string: "")!
//      let task = URLSession.shared.dataTask(with: url) { data, response, error in
//         guard error == nil else {
//            observer.onError(NSError(domain: "", code: 0, userInfo: nil))
//            return
//         }
//         guard data != nil else {
//            observer.onError(NSError(domain: "", code: 0, userInfo: nil))
//            return
//         }
//         let decoder = JSONDecoder()
//         do {
//            let dataModel = try decoder.decode(PhuocModel.self, from: data!)
//            observer.onNext(dataModel)
//            observer.onCompleted()
//         } catch let error {
//            observer.onError(error)
//         }
//      }
//      task.resume()
//      return Disposables.create {
//         print("Disposed API request")
//      }
//   }
//}
//
//func loadRequestObservble() -> Observable<PhuocModel> {
//
//   let url = URL(string: "")
//   let request = URLRequest(url: url!)
//   return URLSession
//      .shared
//      .rx
//      .response(request: request)
//      .flatMapLatest {
//         (response: HTTPURLResponse, data: Data) -> Observable<(HTTPURLResponse, Data)> in
//         return Observable.just((response, data))
//      }.map { (response, data) -> PhuocModel in
//
//         if 200..<300 ~= response.statusCode {
//            let decoder = JSONDecoder()
//            let model = try decoder.decode(PhuocModel.self, from: data)
//            return model
//         } else {
//            throw NSError(domain: "", code: 0, userInfo: nil)
//         }
//      }
//}


let searchStringSequence = Observable.of("A", "B", "C", "D", "E")
searchStringSequence.flatMapLatest { string in
   return Observable<String>.create { observer in
      // perform long task, example: perform API request, call database
      DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 4) {
         observer.onNext("string result \(string)")
         observer.onCompleted()
      }
      return Disposables.create {}
   }
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

