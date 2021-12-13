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
import RxDataSources

class WeatherHomeViewController: UIViewController {
   
   deinit {
      print("Deinit view controller")
      print("Resource count \(RxSwift.Resources.total)")
   }
   
   @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
   // MARK: - UI property
   @IBOutlet weak var tableView: UITableView!
   let searchController = UISearchController(searchResultsController: nil)
   let refreshControl = UIRefreshControl()
   
   // MARK: - ViewModel property
   var weatherDataViewModel: WeatherDataViewModel!
   
   var sectioViewModel: HandleSectionViewModelProtocol!
   
   let disposedBag = DisposeBag()
   
   // MARK: - View controller lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      setupView()
      setupSearchController()
      initViewModel()
      
      
      sectioViewModel = HandleSectionViewModel()
      sectioViewModel.createDatas()
      setupBinding()
   }
   
   private func setupSearchController() {
      // searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search City"
      navigationItem.searchController = searchController
      definesPresentationContext = true
   }
   
   private func setupView() {
      let nib = UINib(nibName: String(describing: WeatherInfoTableViewCell.self), bundle: nil)
      
      tableView.register(nib, forCellReuseIdentifier: String(describing: WeatherInfoTableViewCell.self))
      activityIndicatorView.hidesWhenStopped = true
      tableView.insertSubview(refreshControl, at: 0)
      
   }
   
   private func initViewModel() {
      // Default search
      searchController.searchBar.text = "saigon"
      
      /*
       Note, review again this case if have time: weatherDataViewModel = WeatherDataViewModel(searchObservable: searchController.searchBar.rx.text.orEmpty.asObservable())
       think about why weak not success create view model and whether it have retain cycle
       */
      weatherDataViewModel = WeatherDataViewModel()
   }
   
   private func setupBinding() {
//      searchController
//         .searchBar
//         .rx
//         .text
//         .orEmpty
//         // should use throttle for smooth and continue tap=> more react
//         // should use debound for least request
//         .debounce(RxTimeInterval.milliseconds(600), scheduler: MainScheduler.instance)
//         .distinctUntilChanged()
//         .flatMapLatest({ query -> Observable<String> in
//            return Observable.just(query)
//         })
//         .subscribe {[weatherDataViewModel] query in
//            print("query flat operator: \(query)")
//            weatherDataViewModel!.loadWeatherCitys(withQuery: query, page: weatherDataViewModel!.currentPage)
//
//         } onError: { error in
//            print(error.localizedDescription)
//         } onCompleted: {
//            //         print("Complete observe Search API")
//         } onDisposed: {
//            //         print("Disposed observe Search API")
//         }
//         .disposed(by: disposedBag)
//
//      weatherDataViewModel
//         .daysWeatherObservable
//         .observe(on: MainScheduler.instance)
//         .bind(to: tableView
//                  .rx
//                  .items(cellIdentifier: String(describing: WeatherInfoTableViewCell.self), cellType: WeatherInfoTableViewCell.self)) {
//            tableView, model, cell in
//            print(Thread.current)
//            cell.setupDataWeather(data: model)
//         }
//         .disposed(by: disposedBag)
//
//      weatherDataViewModel
//         .isLoadingDataObservable
//         .observe(on: MainScheduler.instance)
//         .bind(to: activityIndicatorView.rx.isAnimating)
//         .disposed(by: disposedBag)
//
//      weatherDataViewModel
//         .isLoadingDataObservable
//         .observe(on: MainScheduler.instance)
//         .subscribe(onNext: {[refreshControl] isLoading in
//            if !isLoading {
//               refreshControl.endRefreshing()
//            }
//         }, onError: { error in
//
//         }, onCompleted: {
//
//         }, onDisposed: {
//
//         })
//         .disposed(by: disposedBag)
//
//      refreshControl
//         .rx
//         .controlEvent(.valueChanged)
//         .subscribe {[weak self] _ in
//            print("query flat operator: \(self?.searchController.searchBar.text ?? "")")
//            self?.weatherDataViewModel.loadWeatherCitys(withQuery: self?.searchController.searchBar.text ?? "", page: 0)
//         } onError: { error in
//            print(error)
//         }
//         .disposed(by: disposedBag)
//
//      tableView
//         .rx
//         .willDisplayCell
//         .subscribe {[weak self] willDisplayCellEvent in
////            self?.weatherDataViewModel.currentPage = (self?.weatherDataViewModel.currentPage)! + 1
////            self?.weatherDataViewModel.loadWeatherCitys(withQuery: self?.searchController.searchBar.text ?? "", page: self?.weatherDataViewModel.currentPage ?? 0)
//
//      } onError: { error in
//         print(error.localizedDescription)
//      }
//      .disposed(by: disposedBag)
      
      let dataSource = RxTableViewSectionedReloadDataSource<CustomSectionModel>(configureCell: { (dataSource: TableViewSectionedDataSource<CustomSectionModel>, tableView: UITableView, indexPath: IndexPath, item: CustomSectionModel.Item) -> UITableViewCell in
         
         let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherInfoTableViewCell.self), for: indexPath)
             return cell
      },
      titleForHeaderInSection: { dataSource, index in
         return dataSource.sectionModels[index].header
      },
      titleForFooterInSection: { dataSource, index in
         return dataSource.sectionModels[index].header
      })
      
      sectioViewModel
         .dataSectionObservable
         .asObservable()
         .bind(to: tableView
                  .rx
                  .items(dataSource: dataSource))
         .disposed(by: disposedBag)
   }
   
   
}
