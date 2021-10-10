//
//  WheatherHomeViewModel.swift
//  Wheather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import RxSwift
import RxRelay

protocol WheatherDataViewModelProtocol {
   var disposedBag: DisposeBag { get }
   var daysWheather: BehaviorRelay<[DayDataModel]> { get }
   var errorMessage: BehaviorRelay<String> { get }
   func loadWheatherCitys()
}

class WheatherDataViewModel: WheatherDataViewModelProtocol {
   var errorMessage: BehaviorRelay<String>
   var daysWheather: BehaviorRelay<[DayDataModel]>
   
   var disposedBag: DisposeBag = DisposeBag()
   
   init() {
      errorMessage = BehaviorRelay(value: "")
      daysWheather = BehaviorRelay(value: [])
      loadWheatherCitys()
   }
   
   func loadWheatherCitys() {
      disposedBag = DisposeBag()
      return APIWheatherHandler
         .shared
         .request(service: .requestCity)
         .asObservable().subscribe {[weak self] (model: WheatherModelData) in
            print(model)
            self?.daysWheather.accept(model.list)
         } onError: {[weak self] (error) in
            self?.errorMessage.accept(error.localizedDescription)
         }.disposed(by: disposedBag)
   }
   
}
