//
//  WeatherHomeViewModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import RxSwift
import RxRelay

protocol WeatherDataViewModelProtocol {
   var disposedBag: DisposeBag { get }
   var daysWeather: BehaviorRelay<[DayDataModel]> { get }
   var errorMessage: BehaviorRelay<String> { get }
   func loadWeatherCitys()
}

class WeatherDataViewModel: WeatherDataViewModelProtocol {
   var errorMessage: BehaviorRelay<String>
   var daysWeather: BehaviorRelay<[DayDataModel]>
   
   var disposedBag: DisposeBag = DisposeBag()
   
   init() {
      errorMessage = BehaviorRelay(value: "")
      daysWeather = BehaviorRelay(value: [])
      loadWeatherCitys()
   }
   
   func loadWeatherCitys() {
      disposedBag = DisposeBag()
      return APIWeatherHandler
         .shared
         .request(service: .requestCity)
         .asObservable().subscribe {[weak self] (model: WeatherModelData) in
            print(model)
            self?.daysWeather.accept(model.listWeatherForDays)
         } onError: {[weak self] (error) in
            self?.errorMessage.accept(error.localizedDescription)
         }.disposed(by: disposedBag)
   }
   
}
