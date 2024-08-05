//
//  SectionHeaderView.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import Foundation
import UIKit
import SnapKit
class SectionHeaderView: UICollectionReusableView{
    static let id = "SectionHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with title: String){
        titleLabel.text = title
    }
    private func setupUI(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(10)
        }
    }
}
