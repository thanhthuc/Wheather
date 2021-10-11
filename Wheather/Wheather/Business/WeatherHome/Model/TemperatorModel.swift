//
//  TemperatorModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import Foundation

struct TemperatureModel: Codable {
   var day: Double
   var min: Double
   var max: Double
   var night: Double
   var eve: Double
   var morn: Double
}
