//
//  WheatherModelData.swift
//  Wheather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import Foundation

struct WheatherModelData: Codable {
   var city: CityModel
   var cod: String
   var message: Double
   var cnt: Int // number of forestcast day
   var list: [DayDataModel]
   
}
