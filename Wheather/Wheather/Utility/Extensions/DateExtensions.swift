//
//  DateExtensions.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 11/10/2021.
//

import UIKit

extension Date {
   public var hour: Int {
       get {
           return Calendar.current.component(.hour, from: self)
       }
       set {
           let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
           guard allowedRange.contains(newValue) else { return }

           let currentHour = Calendar.current.component(.hour, from: self)
           let hoursToAdd = newValue - currentHour
           if let date = Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self) {
               self = date
           }
       }
   }

   public var time: String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .none
       dateFormatter.timeStyle = .short
       let dataString = dateFormatter.string(from: self)
       return dataString
   }
   
   
}
