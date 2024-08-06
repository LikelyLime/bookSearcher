//
//  SearchResultCell.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import UIKit
class SearchResultCell: UICollectionViewCell{
    static let id = "SearchResultCell"
    
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
        stackView.spacing = 10
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 1.0
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 5.0)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    func configure(bookInfo: BookModel){
        titleLabel.text = bookInfo.title
        authorLabel.text = bookInfo.authors.joined(separator: ", ")
        priceLabel.text = String(bookInfo.price)
    }
}
