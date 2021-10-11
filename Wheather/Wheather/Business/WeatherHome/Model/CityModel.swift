//
//  CityModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import Foundation
import RealmSwift

class CityModel: NSObject, Codable {
   
   @objc dynamic var id: UInt32
   @objc dynamic var name: String?
   @objc dynamic var coord: Coordinate
   @objc dynamic var country: String?
   @objc dynamic var population: Int
   @objc dynamic var timezone: UInt32
   
}
