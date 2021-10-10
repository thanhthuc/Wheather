//
//  NetworkError.swift
//  Wheather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import UIKit

enum NetworkingError: Error {
   case badGateway
   case timeout
   case authorization
   case badUrl
   
   func toString() -> String {
      return String(describing: self)
   }
}
