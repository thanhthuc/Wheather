//
//  TemperatureModel.swift
//  Wheather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import Foundation

struct DayWheatherModel: Codable {
   var id: UInt32
   var main: String
   var description: String
   var icon: String
}

struct DayDataModel: Codable {
   
   var dt: UInt32
   
   var sunrise: UInt32
   
   var sunset: UInt32
   
   var temp: TemperatureModel
   
   var feels_like: FieldLikeModel
   
   var pressure:  UInt32
   
   var humidity: UInt32
   
   var weather:[DayWheatherModel]
   
   var speed: Double
   
   var deg: Double
   
   var gust: Double
   
   var clouds: Int
   
   var pop: Double
   
   var rain: Double
   
   
}
