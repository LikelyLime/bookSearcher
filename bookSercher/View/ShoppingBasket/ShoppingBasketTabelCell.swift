//
//  ShoppingBasketTabelCell.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import Foundation
import UIKit
class ShoppingBasketTabelCell: UITableViewCell{
    static let id = "ShoppingBasketTabelCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "세이노의 가르침"
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.text = "세이노"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.text = "14,000원"
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 1.0
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 5.0)
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [titleLabel, authorLabel, priceLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        [stackView].forEach {
            contentView.addSubview($0)
        }
        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
