//
//  NetworkManager.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import Foundation
import RxSwift

public protocol NetworkProtocol {
   var baseURLString: String { get }
   var request: URLRequest? { get }
   var method: String { get }
   var header: [String: String]? { get }
   var sampleData: Data { get }
}

public extension NetworkProtocol {
   // Default value
   var sampleData: Data {
      return Data()
   }
}

public enum WeatherService {
   case requestCity(param: [String: String])
   case requestIcon(iconPath: String)
}

extension WeatherService: NetworkProtocol {
   struct AppAPIkey {
      static let apiKey = "60c6fbeb4b93ac653c492ba806fc346d"
   }
   public var baseURLString: String {
      switch self {
         case .requestCity:
            return "https://api.openweathermap.org/data/2.5/forecast/daily"
         case .requestIcon:
            return "http://openweathermap.org/img/w/"
      }
   }
   
   public var request: URLRequest? {
      switch self {
         case .requestCity(let param):
            /*
             return "\(baseURLString)/data/2.5/forecast/daily?q=saigon&cnt=7&appid=\(AppAPIkey.apiKey)&units=metric"
             */
            var urlComps = URLComponents(string: baseURLString)!
            urlComps.queryItems = param.map({ (key, value) in
               URLQueryItem(name: key, value: value)
            })
            urlComps.queryItems?.append(URLQueryItem(name: "appid", value: AppAPIkey.apiKey))
            guard let url = urlComps.url else {
               return nil
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method
            return urlRequest
            
         case .requestIcon(let iconPath):
            let stringPath = "\(baseURLString)\(iconPath).png"
            guard let url = URL(string: stringPath) else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = method
            return request
      }
   }
   
   public var method: String {
      switch self {
         case .requestCity:
            return "GET"
         default:
            return "GET"
      }
   }
   
   public var header: [String : String]? {
      switch self {
         case .requestCity:
            return [:]
         default:
            return [:]
      }
   }
}



