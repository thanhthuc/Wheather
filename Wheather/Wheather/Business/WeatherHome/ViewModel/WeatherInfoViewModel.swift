//
//  WeatherInfoViewModel.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 11/10/2021.
//

import RxSwift
import RxRelay

protocol WeatherInfoViewModelProtocol {
   
   var disposedBag: DisposeBag { get }
   var imageDataObservable: Observable<UIImage> { get }
   var errorObservable: Observable<Error> { get }
   func loadImage(resourcePath: String)
   
}

class WeatherInfoViewModel: WeatherInfoViewModelProtocol {
   
   var imageDataObservable: Observable<UIImage>
   var errorObservable: Observable<Error>
   var disposedBag: DisposeBag
   private var imageDataBehaviorRelay: BehaviorRelay<UIImage> = BehaviorRelay(value: UIImage())
   private var errorBehaviorRelay: BehaviorRelay<Error> = BehaviorRelay(value: NSError(domain: "WeatherInfoViewModel", code: 0, userInfo: nil))
   
   init() {
      disposedBag = DisposeBag()
      imageDataObservable = imageDataBehaviorRelay.asObservable()
      errorObservable = errorBehaviorRelay.asObservable()
   }
   
   func loadImage(resourcePath: String) {
      APIWeatherHandler
         .shared
         .requestSpecialResoure(service: .requestIcon(iconPath: resourcePath))
         .subscribe {[weak self] (data) in
            let image = UIImage(data: data)
            guard let imageUnwrap = image else {
               self?.errorBehaviorRelay.accept(NetworkingError.badUrl)
               return
            }
            self?.imageDataBehaviorRelay.accept(imageUnwrap)
         } onError: {[weak self] (error) in
            self?.errorBehaviorRelay.accept(error)
         }
         .disposed(by: disposedBag)
   }
   
   
   
}
