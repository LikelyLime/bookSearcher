//
//  Search.swift
//  bookSercher
//
//  Created by 백시훈 on 8/2/24.
//

import Foundation
import UIKit
import SnapKit
class SearchView: UIView{
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색"
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-20)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            $0.height.equalTo(44)
        }
        
    }
    
}

