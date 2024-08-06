//
//  DetailView.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import Foundation
import UIKit
import SnapKit

class DetailView: UIView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let common = Common()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "세이노의 가르침"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "세이노"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        return image
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "14,000원"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let returnButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("담기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 0.8)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
        
    }
    
    func setUi(bookInfo: BookModel, preview: UIImage){
        image.image = preview
        titleLabel.text = bookInfo.title
        authorLabel.text = bookInfo.authors.joined(separator: ", ")
        priceLabel.text = "\(common.formatPrice(n: bookInfo.price)) 원"
        contentLabel.text = bookInfo.contents
    }
    
    private func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [titleLabel, authorLabel, image, priceLabel].forEach {
            addSubview($0)
        }
        contentView.addSubview(contentLabel)
        [returnButton, addButton].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        authorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        image.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(80)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-80)
            $0.height.equalTo(350)
            $0.top.equalTo(authorLabel.snp.bottom).offset(30)
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(image.snp.bottom).offset(20)
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(returnButton.snp.top).offset(-10)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        contentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        returnButton.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.leading.equalTo(returnButton.snp.trailing).offset(20)
            $0.height.equalTo(80)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

