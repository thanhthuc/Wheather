//
//  ViewController.swift
//  Weather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class WeatherHomeViewController: UIViewController {
   
   @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
   // MARK: - UI property
   @IBOutlet weak var tableView: UITableView!
   let searchController = UISearchController(searchResultsController: nil)
   
   // MARK: - ViewModel property
   var weatherDataViewModel: WeatherDataViewModel!
   let disposedBag = DisposeBag()
   
   // MARK: - View controller lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      setupView()
      setupSearchController()
      initViewModel()
      setupBinding()
   }
   
   private func setupSearchController() {
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search City"
      navigationItem.searchController = searchController
      definesPresentationContext = true
   }
   
   private func setupView() {
      let nib = UINib(nibName: String(describing: WeatherInfoTableViewCell.self), bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: String(describing: WeatherInfoTableViewCell.self))
      activityIndicatorView.hidesWhenStopped = true
   }
   
   private func initViewModel() {
      weatherDataViewModel = WeatherDataViewModel()
   }
   
   private func setupBinding() {
      weatherDataViewModel
         .daysWeatherObservable
         .bind(to: tableView
                  .rx
                  .items(cellIdentifier: String(describing: WeatherInfoTableViewCell.self), cellType: WeatherInfoTableViewCell.self)) {
         tableView, model, cell in
            cell.setupDataWeather(data: model)
      }
         .disposed(by: disposedBag)
      
      weatherDataViewModel
         .isLoadingDataObservable
         .bind(to: activityIndicatorView
                  .rx
                  .isAnimating)
         .disposed(by: disposedBag)
   }
}

extension WeatherHomeViewController: UISearchResultsUpdating {
   
   func updateSearchResults(for searchController: UISearchController) {
      
   }
   
}

