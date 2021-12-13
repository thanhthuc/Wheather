//
//  HandleSectionViewModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 14/11/2021.
//

import UIKit
import RxSwift
import RxDataSources
import RxRelay

// SOLID
/*
 S
 O: open close:
 L: Liskov substition: child replace parent -> detail
 I: Interface segretion: ko gop interface
 D: Dependenci inversion # dependenci inject tion
 */

protocol HandleSectionViewModelProtocol {
   
   var disposedBag: DisposeBag { get set }
   
   var dataSectionObservable: BehaviorRelay<[CustomSectionModel]> { get set }
   
   func createDatas()
}

class HandleSectionViewModel: HandleSectionViewModelProtocol {
   
   var disposedBag: DisposeBag = DisposeBag()
   
   var dataSectionObservable: BehaviorRelay<[CustomSectionModel]> = BehaviorRelay(value: [])
   
   func createDatas() {
      let cell1 = CellModel(name: "Bi", phone: "999")
      let modelSection1 = CustomSectionModel(header: "Section1", items: [cell1, cell1])
      let modelSection2 = CustomSectionModel(header: "Section2", items: [cell1, cell1])
      dataSectionObservable.accept([modelSection1, modelSection2])
   }
   
   
}
