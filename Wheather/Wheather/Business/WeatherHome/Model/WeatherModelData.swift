//
//  WeatherModelData.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import Foundation

struct WeatherModelData: Codable {
   var city: CityModel
   var cod: String
   var message: Double
   var cnt: Int // number of forestcast day
   var list: [DayDataModel]
   
}
