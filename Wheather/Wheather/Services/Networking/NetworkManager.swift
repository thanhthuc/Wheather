//
//  NetworkManager.swift
//  Wheather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import Foundation
import RxSwift

public protocol NetworkProtocol {
   var baseURL: String { get }
   var path: String { get }
   var method: String { get }
   var task: URLSessionDataTask { get }
   var header: [String: String]? { get }
   var sampleData: Data { get }
}

public extension NetworkProtocol {
   // Default value
   var sampleData: Data {
      return Data()
   }
}

public enum WheatherService {
   case requestCity
   case searchCity
}

extension WheatherService: NetworkProtocol {
   public var baseURL: String {
      switch self {
         case .requestCity:
            return "https://api.openweathermap.org/"
         default:
            return "https://api.openweathermap.org/"
      }
   }
   
   public var path: String {
      switch self {
         case .requestCity:
            return "\(baseURL)/data/2.5/forecast/daily?q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric"
         default:
            return "\(baseURL)/data/2.5/forecast/daily?q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric"
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
   
   public var task: URLSessionDataTask {
      switch self {
         case .requestCity:
            return URLSessionDataTask()
         default:
            return URLSessionDataTask()
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



