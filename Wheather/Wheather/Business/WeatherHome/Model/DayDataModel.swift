//
//  TemperatureModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import Foundation

class DayDataModel: NSObject, Codable {
   
   @objc dynamic var day: UInt32
   @objc dynamic var sunrise: UInt32
   @objc dynamic var sunset: UInt32
   @objc dynamic var temperature: TemperatureModel
   @objc dynamic var feelsLike: FeelLikeModel
   @objc dynamic var pressure:  UInt32
   @objc dynamic var humidity: UInt32
   @objc dynamic var weather:[DayWeatherModel]
   @objc dynamic var winSpeed: Double
   @objc dynamic var clouds: Int
   @objc dynamic var rain: Double
   
   enum DayDataModelKeys: String, CodingKey {
      case day = "dt"
      case sunrise = "sunrise"
      case sunset = "sunset"
      case temperature = "temp"
      case feelsLike = "feels_like"
      case pressure = "pressure"
      case humidity = "humidity"
      case weather = "weather"
      case winSpeed = "speed"
      case rain = "rain"
      case clouds = "clouds"
   }
   
   required init(from decoder: Decoder) throws {
      
      let dayDataModelContainer = try decoder.container(keyedBy: DayDataModelKeys.self)
      day = try dayDataModelContainer.decode(UInt32.self, forKey: .day)
      sunrise = try dayDataModelContainer.decode(UInt32.self, forKey: .sunrise)
      sunset = try dayDataModelContainer.decode(UInt32.self, forKey: .sunset)
      temperature = try dayDataModelContainer.decode(TemperatureModel.self, forKey: .temperature)
      feelsLike = try dayDataModelContainer.decode(FeelLikeModel.self, forKey: .feelsLike)
      pressure = try dayDataModelContainer.decode(UInt32.self, forKey: .pressure)
      humidity = try dayDataModelContainer.decode(UInt32.self, forKey: .humidity)
      weather = try dayDataModelContainer.decode([DayWeatherModel].self, forKey: .weather)
      winSpeed = try dayDataModelContainer.decode(Double.self, forKey: .winSpeed)
      clouds = try dayDataModelContainer.decode(Int.self, forKey: .clouds)
      
      if dayDataModelContainer.contains(.rain) {
         rain = try dayDataModelContainer.decode(Double.self, forKey: .rain)
      } else {
         rain = 0.0
      }
   }
}
