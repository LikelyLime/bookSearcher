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
    var recentBookInfos = [BookModel]()
    let disposeBag = DisposeBag()
    ///페이징 처리 프로퍼티
    var currentPage = 1
    var totalPage = 1
    var isLoading = false
    
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
        guard let text = searchView.textField.text else { return }
        if text.isEmpty{
            showAlert(message: "검색어를 입력해 주세요", buttonTitle: "확인", buttonClickTitle: "OK")
            return
        }
        searchView.dismissKeyboard()
        currentPage = 1
        bookInfos.removeAll()
        loadData(page: currentPage)
    }
    /// 책검색 API호출
    func loadData(page: Int) {
        isLoading = true
        searcherViewModel.retrieveBookInfo(word: searchView.textField.text ?? "", page: page)
    }
    ///데이터 바인딩 및 무한 스크롤
    func bind(){
        searcherViewModel.bookInfoSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            self.bookInfos.append(contentsOf: response.documents)
            self.totalPage = response.meta.totalCount
            self.searchView.collectionView.reloadData()
        }, onError: { [weak self] error in
            print(error)
            self?.isLoading = false
        }).disposed(by: disposeBag)
    }
    ///textField 포커스
    func focusOnTextField() {
        searchView.textField.becomeFirstResponder()
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
    //collectionView section 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recentBookInfos.isEmpty ? 1 : Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recentBookInfos.isEmpty{
            return bookInfos.count
        }else{
            switch Section(rawValue: section) {
                case .recentBooks:
                    return recentBookInfos.count
                case .searchResults:
                    return bookInfos.count
                default:
                    return 0
            }
        }
    }
    ///cell 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)
        if recentBookInfos.isEmpty{
            searchView.recentBookIsEmpty = true
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.id, for: indexPath) as? SearchResultCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .white
            cell.configure(bookInfo: bookInfos[indexPath.row])
            return cell
        }else{
            switch section {
                case .recentBooks:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentBookCell.id, for: indexPath) as? RecentBookCell else {
                        return UICollectionViewCell()
                    }
                    cell.backgroundColor = .white
                    if recentBookInfos.count != 0 {
                        cell.setUI(bookInfo: recentBookInfos[indexPath.row])
                    }
                    
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
    }
    /// collectionView 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        var sectionType = Section.allCases[indexPath.section]
        if recentBookInfos.isEmpty{
            sectionType = Section.allCases[1]
            
        }
        headerView.configure(with: sectionType.title)
        return headerView
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // 무한 스크롤을 위한 페이징 처리
        if offsetY > contentHeight - height * 2, !isLoading, currentPage < totalPage {
            currentPage += 1
            loadData(page: currentPage)
        }
    }
    ///클릭 시 상세보기 화면이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        if recentBookInfos.isEmpty {
            
            setRecentBook(bookInfo: bookInfos[indexPath.row])
            detailViewController.setUI(bookInfo: bookInfos[indexPath.row])
            present(detailViewController, animated: true)
            collectionView.reloadData()
        }else{
            switch Section(rawValue: indexPath.section){
                case .recentBooks:
                    detailViewController.setUI(bookInfo: recentBookInfos[indexPath.row])
                    setRecentBook(bookInfo: recentBookInfos[indexPath.row])
                    present(detailViewController, animated: true)
                    collectionView.reloadData()
                    break
                case .searchResults:
                    setRecentBook(bookInfo: bookInfos[indexPath.row])
                    detailViewController.setUI(bookInfo: bookInfos[indexPath.row])
                    present(detailViewController, animated: true)
                    collectionView.reloadData()
                    break
                default:
                    return
            }
        }
    }
    ///recentBookInfos 순서 맞추기
    func setRecentBook(bookInfo: BookModel) {
        if recentBookInfos.count >= 10{
            recentBookInfos.removeLast()
            recentBookInfos.insert(bookInfo, at: 0)
        }else{
            if let index = recentBookInfos.firstIndex(of: bookInfo) {
                recentBookInfos.remove(at: index)
            }
            recentBookInfos.insert(bookInfo, at: 0)
            
        }
        searchView.recentBookIsEmpty = recentBookInfos.isEmpty
        searchView.collectionView.reloadData()
    }
    
    
}
