//
//  TemperatureModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 11/10/2021.
//

import Foundation

class TemperatureModel: NSObject, Codable {
   @objc dynamic var day: Double
   @objc dynamic var min: Double
   @objc dynamic var max: Double
   @objc dynamic var night: Double
   @objc dynamic var everage: Double
   @objc dynamic var morning: Double
   
   enum TemperatureModelCodingKeys: String, CodingKey {
      case day = "day"
      case min = "min"
      case max = "max"
      case night = "night"
      case everage = "eve"
      case morning = "morn"
   }
   
   required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: TemperatureModelCodingKeys.self)
      day = try container.decode(Double.self, forKey: .day)
      min = try container.decode(Double.self, forKey: .min)
      max = try container.decode(Double.self, forKey: .max)
      night = try container.decode(Double.self, forKey: .night)
      everage = try container.decode(Double.self, forKey: .everage)
      morning = try container.decode(Double.self, forKey: .morning)
   }
   
}
