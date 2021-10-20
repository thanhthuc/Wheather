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
   
   var disposedBag: DisposeBag = DisposeBag()
   
   init(searchObservable: Observable<String>) {
      self.searchObservable = searchObservable
      errorMessageObservable = errorMessageBehaviorRelay.asObservable()
      daysWeatherObservable = daysWeatherBehaviorRelay.asObservable()
      isLoadingDataObservable = isLoadingDataBehaviorRelay.asObservable()
      loadWeatherCitys()
   }
   
   func loadWeatherCitys() {
      isLoadingDataBehaviorRelay.accept(true)
      APIWeatherHandler
         .shared
         .request(service: .requestCity(param: ["q":"saigon", "cnt":"7", "units":"metric"]))
         .subscribe {[weak self] (model: WeatherModelData) in
            
            print(model)
            self?.daysWeatherBehaviorRelay.accept(model.listWeatherForDays)
            self?.isLoadingDataBehaviorRelay.accept(false)
            
         } onError: {[weak self] (error) in
            self?.isLoadingDataBehaviorRelay.accept(false)
            self?.errorMessageBehaviorRelay.accept(error.localizedDescription)
         }
         .disposed(by: disposedBag)
      
//      self.searchObservable.asObservable().flatMap { string -> Observable<WeatherModelData> in
//         let city = string
//         print(city)
//         return APIWeatherHandler
//            .shared
//            .request(service: .requestCity(param: ["q":city, "cnt":"7", "units":"metric"]))
//      }
//      .distinctUntilChanged()
//      .subscribe { model in
//         print(model.city)
//      } onError: { error in
//         print(error.localizedDescription)
//      } onCompleted: {
//
//      } onDisposed: {
//
//      }.disposed(by: disposedBag)
      
      // flatmap
      // map
      // flatmap Latest
      //
      self.searchObservable.flatMap { string in
         
         
         return Observable.just(string)
         
      }.subscribe { string in
         
         print(string)
         
      } onError: { error in
         
      }.disposed(by: disposedBag)
      
   }
   
}
