//
//  DayWeatherModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 11/10/2021.
//

import Foundation

class DayWeatherModel: NSObject, Codable {
   @objc dynamic var id: UInt32
   @objc dynamic var main: String?
   @objc dynamic var descriptionWeather: String?
   @objc dynamic var iconPath: String?
   
   enum DayWeatherModelKeys: String, CodingKey {
      case id = "id"
      case main = "main"
      case descriptionWeather = "description"
      case iconPath = "icon"
   }
   
   required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: DayWeatherModelKeys.self)
      id = try container.decode(UInt32.self, forKey: .id)
      main = try container.decode(String?.self, forKey: .main)
      descriptionWeather = try container.decode(String?.self, forKey: .descriptionWeather)
      iconPath = try container.decode(String?.self, forKey: .iconPath)
   }
}
