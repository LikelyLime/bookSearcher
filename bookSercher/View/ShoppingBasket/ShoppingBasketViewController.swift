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
        bookInfoEntitys = coreData.fetchBooks()
        sections.removeAll()
        sectionTitles.removeAll()
        for book in bookInfoEntitys {
            let title = book.title ?? ""
            if sections[title] != nil {
                sections[title]?.append(book)
            } else {
                sections[title] = [book]
                sectionTitles.append(title)
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
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let title = sectionTitles[indexPath.section]
        coreData.deleteData(title: title)
        loadBooks()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
}
