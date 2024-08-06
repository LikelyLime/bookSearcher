//
//  ShoppingBasketTabelCell.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import Foundation
import UIKit
import SnapKit
class ShoppingBasketTabelCell: UITableViewCell{
    static let id = "ShoppingBasketTabelCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
        [titleLabel, authorLabel, priceLabel].forEach {
            containerView.addSubview($0)
        }
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(10)
            $0.height.equalTo(containerView.snp.height)
            $0.width.equalTo(containerView.snp.width).multipliedBy(0.5)
            
        }
        authorLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(3)
            $0.height.equalTo(containerView.snp.height)
            $0.trailing.equalTo(priceLabel.snp.leading).offset(-3)
            $0.width.equalTo(70)
        }
        priceLabel.snp.makeConstraints {
            $0.trailing.equalTo(containerView.snp.trailing)
            $0.height.equalTo(containerView.snp.height)
            
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(bookInfoEntity: BookInfoEntity){
        titleLabel.text = bookInfoEntity.title
        authorLabel.text = bookInfoEntity.authors
        priceLabel.text = bookInfoEntity.price
    }
}
