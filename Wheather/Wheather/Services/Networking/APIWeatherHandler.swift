//
//  APIHandler.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import RxSwift

protocol APINetworkHandlerProtocol {
   
   func request<T: Decodable>(service: WeatherService) -> Observable<T>
   
   func requestSpecialResoure(service: WeatherService) -> Observable<Data>
   
}

class APIWeatherHandler: APINetworkHandlerProtocol {
   
   static let shared: APIWeatherHandler = APIWeatherHandler()
   
   func request<T: Decodable>(service: WeatherService) -> Observable<T> {
      
      return Observable.create { observe in
         
         guard let request = service.request else { return Disposables.create() }
         
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
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
               let weatherModelData = try decoder.decode(T.self, from: data)
               observe.onNext(weatherModelData)
               observe.onCompleted()
            } catch let error {
               print("error for parse data: \(error.localizedDescription)")
               observe.onError(error)
            }
         }
         task.resume()
         return Disposables.create {
            task.cancel()
         }
      }
   }
   
   func requestSpecialResoure(service: WeatherService) -> Observable<Data> {
      return Observable.create { observe in
         
         guard let request = service.request else { return Disposables.create() }
            
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
               observe.onError(error!)
               return
            }
            guard let data = data else {
               observe.onError(NetworkingError.badUrl)
               return
            }
            observe.onNext(data)
         }
         task.resume()
         return Disposables.create()
      }
   }
}
