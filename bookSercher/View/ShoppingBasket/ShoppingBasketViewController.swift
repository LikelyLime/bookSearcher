//
//  ShoppingBasketViewController.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/2/24.
//

import Foundation
import UIKit
class ShoppingBasketViewController: UIViewController{
    
    let shoppingBasketView = ShoppingBasketView()
    let coreData = CoreDataManager()
    var bookInfoEntitys = [BookInfoEntity]()
    var sections: [String: [BookInfoEntity]] = [:]
    var sectionTitles: [String] = []
    override func loadView() {
        view = shoppingBasketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setAction()
        loadBooks()
    }
    
    func setAction(){
        shoppingBasketView.removeAllButton.addTarget(self, action: #selector(removeAllData), for: .touchDown)
        shoppingBasketView.plusButton.addTarget(self, action: #selector(changeView), for: .touchDown)
    }
    ///tabbar 변경과 textField의 포커스
    @objc func changeView(){
        if let tabBarController = self.tabBarController,
           let searchViewController = tabBarController.viewControllers?[0] as? SearchViewController {
            tabBarController.selectedIndex = 0
            searchViewController.focusOnTextField()
        }
    }
    @objc func removeAllData(){
        coreData.deleteAllBooks()
        sections.removeAll()
        sectionTitles.removeAll()
        shoppingBasketView.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setTableView(){
        shoppingBasketView.tableView.delegate = self
        shoppingBasketView.tableView.dataSource = self
        shoppingBasketView.tableView.register(ShoppingBasketTabelCell.self, forCellReuseIdentifier: ShoppingBasketTabelCell.id)
        
    }
    func setUI(){
        loadBooks()
        shoppingBasketView.tableView.reloadData()
    }
    private func loadBooks() {
        bookInfoEntitys = coreData.retrieveBookInfos()
        sections.removeAll()
        sectionTitles.removeAll()
        for book in bookInfoEntitys {
            let title = book.title ?? ""
            let author = book.authors ?? ""
            let sectionKey = "\(title) - \(author)" // 제목과 저자를 결합하여 고유한 섹션 키 생성
            
            if sections[sectionKey] != nil {
                sections[sectionKey]?.append(book)
            } else {
                sections[sectionKey] = [book]
                sectionTitles.append(sectionKey)
            }
        }
    }
}

extension ShoppingBasketViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let title = sectionTitles[section]
        return sections[title]?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingBasketTabelCell.id, for: indexPath) as? ShoppingBasketTabelCell else {
            return UITableViewCell()
        }
        
        let title = sectionTitles[indexPath.section]
        if let book = sections[title]?[indexPath.row] {
            cell.configureUI(bookInfoEntity: book)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    /// 스와이프시 delete버튼을 만드는 메서드
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    ///스와이프로 데이터 삭제하는 메서드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let sectionKey = sectionTitles[indexPath.section]
        let components = sectionKey.split(separator: "-").map { $0.trimmingCharacters(in: .whitespaces) }
        guard components.count == 2, let bookTitle = components.first, let bookAuthor = components.last else {
            return
        }

        // Core Data에서 해당 제목과 저자로 책 삭제
        coreData.deleteData(title: String(bookTitle), author: String(bookAuthor))
        sections[sectionKey]?.remove(at: indexPath.row)

        // 데이터가 비어있으면 섹션 제거
        if sections[sectionKey]?.isEmpty == true {
            sections.removeValue(forKey: sectionKey)
            sectionTitles.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    ///footer 설정 메서드
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    ///footer 설정하여 높이만큼 section의 거리를 설정하는 메서드
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
}
