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
   func loadWeatherCitys(withQuery query: String)
   var disposeBag: DisposeBag { get }
}

class WeatherDataViewModel: WeatherDataViewModelProtocol {
   
   
   var daysWeatherObservable: Observable<[DayDataModel]>
   var errorMessageObservable: Observable<String>
   var isLoadingDataObservable: Observable<Bool>
   
   private var errorMessageBehaviorRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
   private var isLoadingDataBehaviorRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
   private var daysWeatherBehaviorRelay: BehaviorRelay<[DayDataModel]> = BehaviorRelay(value: [])
   private var searchObservable: Observable<String> = Observable.just("")
   let disposeBag = DisposeBag()
   
   // Network connection replay
   // handle error display
   // handle dispose at view controller screen
   // Cached for city
   // Hot and cold observalbe
   // Rx marble diagram understanding
   // unit test with cuckoo,
   // testing with rx
   // Solid understanding
   
   
   // compare with Combine Apple
   
   init() {
      errorMessageObservable = errorMessageBehaviorRelay.asObservable()
      isLoadingDataObservable = isLoadingDataBehaviorRelay.asObservable()
      daysWeatherObservable = daysWeatherBehaviorRelay.asObservable()
      
      // default search: saigon
      loadWeatherCitys(withQuery: "saigon")
   }
   
   func loadWeatherCitys(withQuery query: String) {
      
      isLoadingDataBehaviorRelay.accept(true)
      
      APIWeatherHandler
         .shared
         .request(service: .requestCity(param: ["q":query, "cnt":"7", "units":"metric"]))
         .subscribe { [weak self] (model: WeatherModelData) in
            self?.daysWeatherBehaviorRelay.accept(model.listWeatherForDays)
            self?.isLoadingDataBehaviorRelay.accept(false)
         } onError: {[weak self] error in
            self?.isLoadingDataBehaviorRelay.accept(false)
            self?.errorMessageBehaviorRelay.accept(error.localizedDescription)
//            print(error.localizedDescription)
         } onCompleted: {
//            print("Complete observable API API")
         } onDisposed: {
//            print("Disposed observalbe API API")
         }
         .disposed(by: disposeBag)
      
      //      return searchObservable
      //         .flatMapLatest { query -> Observable<WeatherModelData> in
      //            return
      //         }.map { [weak self] model -> [DayDataModel] in
      //            self?.isLoadingDataBehaviorRelay.accept(false)
      //            return model.listWeatherForDays
      //         }
   }
   
}
