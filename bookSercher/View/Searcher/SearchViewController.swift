//
//  ViewController.swift
//  bookSercher
//
//  Created by 백시훈 on 8/2/24.
//

import UIKit
import RxSwift
class SearchViewController: UIViewController {
    let searchView = SearchView()
    let searcherViewModel = SearcherViewModel()
    var bookInfos = [BookModel]()
    let disposeBag = DisposeBag()
    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    private func configureUI(){
        self.view.backgroundColor = .white
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.button.addTarget(self, action: #selector(retrieveBookInfo), for: .touchDown)
        
    }
    @objc func retrieveBookInfo(){
        guard let word = searchView.textField.text else {
            return
        }
        searcherViewModel.retrieveBookInfo(word: word)
    }
    
    func bind(){
        searcherViewModel.bookInfoSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] books in
            self?.bookInfos = books
            self?.searchView.collectionView.reloadData()
        }, onError: { [weak self] error in
            print(error)
        }).disposed(by: disposeBag)
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
        switch Section(rawValue: section) {
            case .recentBooks:
                return 1
            case .searchResults:
                return bookInfos.count
            default:
                return 0
        }
    }
    ///cell 구성
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
                cell.configure(bookInfo: bookInfos[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    /// collectionView 헤더 설정
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
    ///클릭 시 상세보기 화면이동
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
