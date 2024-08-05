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
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
    }
}


enum Section: Int, CaseIterable{
    case recentBooks
    case searchResults
    
    var title: String{
        switch self{
            case.recentBooks: return "최근 본 책"
            case.searchResults: return "검색 결과"
        }
    }
}
extension SearchViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .recentBooks:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentBookCell.id, for: indexPath) as? RecentBookCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .red
            return cell
        case .searchResults:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.id, for: indexPath) as? SearchResultCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .white
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        let sectionType = Section.allCases[indexPath.section]
        headerView.configure(with: sectionType.title)
        return headerView
    }
}

extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section){
            case .recentBooks: 
                break
            case .searchResults:
                let detailViewController = DetailViewController()
                
                present(detailViewController, animated: true)
                break
            default:
                return
        }
    }
}
