//
//  ViewController.swift
//  Wheather
//
//  Created by Nguyen Thanh Thuc on 09/10/2021.
//

import UIKit
import RealmSwift

class WheatherHomeViewController: UIViewController {
   
   let searchController = UISearchController(searchResultsController: nil)
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search City"
      navigationItem.searchController = searchController
      definesPresentationContext = true
      
   }

}

extension WheatherHomeViewController: UISearchResultsUpdating {
   
   func updateSearchResults(for searchController: UISearchController) {
      
   }
   
   
}

