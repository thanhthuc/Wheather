//
//  Coordinate.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 11/10/2021.
//

import Foundation

class Coordinate: NSObject, Codable {
   @objc dynamic var longtitude: Double
   @objc dynamic var latitude: Double
   
   enum CoordinateKeys: String, CodingKey {
      case longtitude = "lon"
      case latitude = "lat"
   }
   
   required init(from decoder: Decoder) throws {
      let coordinateContainer = try decoder.container(keyedBy: CoordinateKeys.self)
      longtitude = try coordinateContainer.decode(Double.self, forKey: .longtitude)
      latitude = try coordinateContainer.decode(Double.self, forKey: .latitude)
   }
}


