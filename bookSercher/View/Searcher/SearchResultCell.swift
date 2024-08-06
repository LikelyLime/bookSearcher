//
//  SearchResultCell.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import UIKit
class SearchResultCell: UICollectionViewCell{
    static let id = "SearchResultCell"
    let common = Common()
    
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
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "세이노의 가르침"
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.text = "세이노"
        label.textAlignment = .left
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.text = "14,000원"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        [titleLabel, authorLabel, priceLabel].forEach {
            containerView.addSubview($0)
        }
        containerView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
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
    func configure(bookInfo: BookModel){
        titleLabel.text = bookInfo.title
        authorLabel.text = bookInfo.authors.joined(separator: ", ")
        priceLabel.text = "\(common.formatPrice(n: bookInfo.price)) 원"
    }
}
