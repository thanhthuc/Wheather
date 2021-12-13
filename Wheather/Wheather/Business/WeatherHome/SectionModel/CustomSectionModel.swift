//
//  CustomSectionModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 14/11/2021.
//

import UIKit
import RxSwift
import RxDataSources

struct CustomSectionModel {
   var header: String
   var items: [Item]
}

struct CellModel {
   var name: String
   var phone: String
}

extension CustomSectionModel: SectionModelType {
   typealias Item = CellModel
   init(original: CustomSectionModel, items: [CellModel]) {
      self = original
      self.items = items
   }
   
   
}
