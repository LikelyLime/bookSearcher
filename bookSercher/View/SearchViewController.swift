//
//  ViewController.swift
//  bookSercher
//
//  Created by 백시훈 on 8/2/24.
//

import UIKit

class SearchViewController: UIViewController {
    let searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        self.view.backgroundColor = .white
        searchView.searchBar.delegate = self
    }
}
extension SearchViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchBarString = searchBar.text, !searchBarString.isEmpty {
            print("Search query: \(searchBarString)")
        }
        searchBar.resignFirstResponder()
    }
}
