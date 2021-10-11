//
//  CityModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import Foundation


struct Coordinate: Codable {
   var lon: Double
   var lat: Double
}

struct CityModel: Codable {
   
   var id: UInt32
   var name: String
   var coord: Coordinate
   var country: String
   var population: Int
   var timezone: UInt32
   
}
