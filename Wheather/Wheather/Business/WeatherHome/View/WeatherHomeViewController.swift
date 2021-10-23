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
import RxCocoa

class WeatherHomeViewController: UIViewController {
   
   deinit {
      print("Deinit view controller")
      print("Resource count \(RxSwift.Resources.total)")
   }
   
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
      
      testDisposed()
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
      // Default search
      searchController.searchBar.text = "saigon"
      weatherDataViewModel = WeatherDataViewModel(searchObservable: searchController.searchBar.rx.text.orEmpty.asObservable())
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
         .daysWeatherObservable
         .subscribe { models in
         print(models)
      } onError: { error in
         print(error.localizedDescription)
      } onCompleted: {
         print("Complete observable datas model")
      } onDisposed: {
         print("Disposed observable datas model")
      }
      .disposed(by: disposedBag)

      
      weatherDataViewModel
         .isLoadingDataObservable
         .observe(on: MainScheduler.instance)
         .subscribe(onNext: {[weak self] needAnimating in
            if needAnimating {
               self?.activityIndicatorView.startAnimating()
            } else {
               self?.activityIndicatorView.stopAnimating()
            }
         }, onError: { error in
            print(error.localizedDescription)
         }, onCompleted: {
            print("Complete observable loading")
         }, onDisposed: {
            print("Disposed observable loading")
         })
         .disposed(by: disposedBag)
   }
   
   func testDisposed() {
      Observable<Int>
         .interval(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
         .subscribe { value in
         print(value)
      } onError: { error in
         print(error.localizedDescription)
      } onCompleted: {
         print("Completed")
      } onDisposed: {
         print("Disposed interval observable")
      }
      .disposed(by: disposedBag)
   }
}

extension WeatherHomeViewController: UISearchResultsUpdating {
   
   func updateSearchResults(for searchController: UISearchController) {
      
   }
   
}

