//
//  WeatherHomeViewModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import RxSwift
import RxRelay

protocol WeatherDataViewModelProtocol {
   var daysWeatherObservable: Observable<[DayDataModel]> { get }
   var errorMessageObservable: Observable<String> { get }
   var isLoadingDataObservable: Observable<Bool> { get }
   func loadWeatherCitys()
}

class WeatherDataViewModel: WeatherDataViewModelProtocol {
   
   var daysWeatherObservable: Observable<[DayDataModel]>
   var errorMessageObservable: Observable<String>
   var isLoadingDataObservable: Observable<Bool>
   
   private var errorMessageBehaviorRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
   private var daysWeatherBehaviorRelay: BehaviorRelay<[DayDataModel]> = BehaviorRelay(value: [])
   private var isLoadingDataBehaviorRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
   private var searchObservable: Observable<String>
   
   
   // Network connection replay
   // handle error display
   // handle dispose at view controller screen
   init(searchObservable: Observable<String>) {
      self.searchObservable = searchObservable
      errorMessageObservable = errorMessageBehaviorRelay.asObservable()
      daysWeatherObservable = daysWeatherBehaviorRelay.asObservable()
      isLoadingDataObservable = isLoadingDataBehaviorRelay.asObservable()
      loadWeatherCitys()
   }
   
   func loadWeatherCitys() {
      isLoadingDataBehaviorRelay.accept(true)
//      APIWeatherHandler
//         .shared
//         .request(service: .requestCity(param: ["q":"saigon", "cnt":"7", "units":"metric"]))
//         .subscribe {[weak self] (model: WeatherModelData) in
//
//            print(model)
//            self?.daysWeatherBehaviorRelay.accept(model.listWeatherForDays)
//            self?.isLoadingDataBehaviorRelay.accept(false)
//
//         } onError: {[weak self] (error) in
//            self?.isLoadingDataBehaviorRelay.accept(false)
//            self?.errorMessageBehaviorRelay.accept(error.localizedDescription)
//         }
//         .disposed(by: disposedBag)
      
      self.daysWeatherObservable = searchObservable
         .flatMapLatest { query -> Observable<WeatherModelData> in
            return APIWeatherHandler
               .shared
               .request(service: .requestCity(param: ["q":query, "cnt":"7", "units":"metric"]))
         }.map { [weak self] model -> [DayDataModel] in
            self?.daysWeatherBehaviorRelay.accept(model.listWeatherForDays)
            self?.isLoadingDataBehaviorRelay.accept(false)
            return model.listWeatherForDays
         }
   }
   
}
