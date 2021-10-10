//
//  APIHandler.swift
//  Wheather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import RxSwift

protocol APINetworkHandlerProtocol {
   
   func request<T: Decodable>(service: WheatherService) -> Observable<T>
   
}

class APIWheatherHandler: APINetworkHandlerProtocol {
   
   static let shared: APIWheatherHandler = APIWheatherHandler()
   
   func request<T: Decodable>(service: WheatherService) -> Observable<T> {
      
      return Observable.create { observe in
         
         guard let url = URL(string: service.path) else { return Disposables.create() }
         
         let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
               observe.onError(error!)
               return
            }
            guard let data = data else {
               observe.onError(NetworkingError.badUrl)
               return
            }
            let decoder = JSONDecoder()
            do {
               let wheatherModelData = try decoder.decode(T.self, from: data)
               observe.onNext(wheatherModelData)
            } catch let error {
               print("error for parse data: \(error.localizedDescription)")
               observe.onError(error)
            }
         }
         task.resume()
         return Disposables.create()
      }
   }
}
