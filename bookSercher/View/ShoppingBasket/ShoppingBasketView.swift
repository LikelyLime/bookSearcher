//
//  ShoppingBasketView.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import Foundation
import UIKit
import SnapKit
class ShoppingBasketView: UIView{
    let removeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func configureUI(){
        backgroundColor = .white
        [removeAllButton, titleLabel, plusButton].forEach {
            stackView.addArrangedSubview($0)
        }
        [stackView, tableView].forEach {
            addSubview($0)
        }
        
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
        }
        tableView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.top.equalTo(stackView.snp.bottom).offset(80)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
