//
//  ViewController.swift
//  Wheather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class WheatherHomeViewController: UIViewController {
   
   // MARK: - UI property
   @IBOutlet weak var tableView: UITableView!
   let searchController = UISearchController(searchResultsController: nil)
   
   // MARK: - ViewModel property
   var wheatherDataViewModel: WheatherDataViewModel!
   
   let disposedBag = DisposeBag()
   
   // MARK: - View controller lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      setupTableView()
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
   
   private func setupTableView() {
      let nib = UINib(nibName: String(describing: WheatherInfoTableViewCell.self), bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: String(describing: WheatherInfoTableViewCell.self))
   }
   
   private func initViewModel() {
      wheatherDataViewModel = WheatherDataViewModel()
   }
   
   private func setupBinding() {
      wheatherDataViewModel
         .daysWheather
         .bind(to: tableView
                  .rx
                  .items(cellIdentifier: String(describing: WheatherInfoTableViewCell.self), cellType: WheatherInfoTableViewCell.self)) {
         tableView, model, cell in
            print(model)
      }
         .disposed(by: disposedBag)
   }
   

}

extension WheatherHomeViewController: UISearchResultsUpdating {
   
   func updateSearchResults(for searchController: UISearchController) {
      
   }
   
   
}

