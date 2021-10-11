//
//  WeatherInfoTableViewCell.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 10/10/2021.
//

import UIKit
import RxSwift

class WeatherInfoTableViewCell: UITableViewCell {
   
   @IBOutlet weak var dateLabel: UILabel!
   @IBOutlet weak var averageTemperLabel: UILabel!
   @IBOutlet weak var pressureLabel: UILabel!
   @IBOutlet weak var humidityLabel: UILabel!
   @IBOutlet weak var descriptionLabel: UILabel!
   @IBOutlet weak var weatherIconImageview: UIImageView!
   
   var weatherInfoViewModel: WeatherInfoViewModelProtocol!
   let disposedBag = DisposeBag()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      weatherInfoViewModel = WeatherInfoViewModel()
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
   func setupDataWeather(data: DayDataModel) {
      
      let date = Date(timeIntervalSince1970: TimeInterval(data.day))
      dateLabel.text = "Date: \(date.time)"
      averageTemperLabel.text = "Everage temperature: \(data.temperature.everage)"
      pressureLabel.text = "Pressure: \(data.pressure)"
      humidityLabel.text = "Humidity: \(data.humidity)"
      descriptionLabel.text = "Description: \(data.weather.first?.descriptionWeather ?? "Unknow description")"
      
      guard let path = data.weather.first?.iconPath else {
         return
      }
      weatherInfoViewModel.loadImage(resourcePath: path)
      
      weatherInfoViewModel
         .imageDataObservable
         .observe(on: MainScheduler.instance)
         .subscribe {[weak self] (image) in
            self?.weatherIconImageview.image = image
      } onError: {(error) in
         // Display default image
      }
         .disposed(by: disposedBag)

   }
   
}
