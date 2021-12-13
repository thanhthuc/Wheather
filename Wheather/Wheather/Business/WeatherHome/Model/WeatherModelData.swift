//
//  WeatherModelData.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import Foundation

class WeatherModelData: NSObject, Codable {
   @objc dynamic var city: CityModel
   @objc dynamic var code: String?
   @objc dynamic var message: Double
   @objc dynamic var forestcastDay: Int // number of forestcast day
   @objc dynamic var listWeatherForDays: [DayDataModel]
   
   enum WeatherModelDataKeys: String, CodingKey {
      case city = "city"
      case code = "cod"
      case forestcastDay = "cnt"
      case message = "message"
      case listWeatherForDays = "list"
   }
   
   required init(from decoder: Decoder) throws {
      let weatherDataContainer = try decoder.container(keyedBy: WeatherModelDataKeys.self)
      city = try weatherDataContainer.decode(CityModel.self, forKey: .city)
      message = try weatherDataContainer.decode(Double.self, forKey: .message)
      code = try weatherDataContainer.decode(String?.self, forKey: .code)
      forestcastDay = try weatherDataContainer.decode(Int.self, forKey: .forestcastDay)
      listWeatherForDays = try weatherDataContainer.decode([DayDataModel].self, forKey: .listWeatherForDays)
   }
}
