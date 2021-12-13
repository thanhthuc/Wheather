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
   func loadWeatherCitys(withQuery query: String, page: Int)
   var currentPage: Int { get set }
}

class WeatherDataViewModel: WeatherDataViewModelProtocol {
   var daysWeatherObservable: Observable<[DayDataModel]>
   var errorMessageObservable: Observable<String>
   var isLoadingDataObservable: Observable<Bool>
   
   private var errorMessageBehaviorRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
   private var isLoadingDataBehaviorRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
   private var daysWeatherBehaviorRelay: BehaviorRelay<[DayDataModel]> = BehaviorRelay(value: [])
   private var searchObservable: Observable<String> = Observable.just("")
   
   var currentPage: Int
   
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
      currentPage = 1
      loadWeatherCitys(withQuery: "saigon", page: currentPage)
   }
   
   func loadWeatherCitys(withQuery query: String, page: Int) {
      isLoadingDataBehaviorRelay.accept(true)
      let pageItems = 6
      // default load
      var cnt: Int = 0
      if page == 0 {
         currentPage = 1
         cnt = pageItems
      } else {
         currentPage = currentPage + 1
      }
      cnt = (currentPage * pageItems)
      
      if cnt > 17 {
         cnt = 17
      }
      APIWeatherHandler
         .shared
         .request(service: .requestCity(param: ["q":query, "cnt":"\(cnt)", "units":"metric"]))
         .retry(1)
         .debug("Request")
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
