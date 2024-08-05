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
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 44))
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return button
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 25
        textField.placeholder = " 검색"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        
        return textField
    }()
    let textFieldLine: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .black
        return uiView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.id)
        collectionView.register(RecentBookCell.self, forCellWithReuseIdentifier: RecentBookCell.id)
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.id)
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func createLayout() -> UICollectionViewLayout{
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createFirstSection()
            case 1:
                return self.createSecondSection()
            default:
                return nil
            }
        }
        
    }
    
    private func createFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createSecondSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func configureUI() {
        [textField, button, textFieldLine, collectionView].forEach {
            addSubview($0)
        }
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        button.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalTo(textField).inset(15)
            $0.width.height.equalTo(30)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(10)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            $0.height.equalTo(70)
        }
        textFieldLine.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(-15)
            $0.leading.equalTo(textField.snp.leading).inset(20)
            $0.trailing.equalTo(textField.snp.trailing).inset(40)
            $0.height.equalTo(1)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
}

