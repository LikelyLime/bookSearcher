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
    
    override func loadView() {
        view = shoppingBasketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    func setTableView(){
        shoppingBasketView.tableView.delegate = self
        shoppingBasketView.tableView.dataSource = self
        shoppingBasketView.tableView.register(ShoppingBasketTabelCell.self, forCellReuseIdentifier: ShoppingBasketTabelCell.id)
    }
}

extension ShoppingBasketViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingBasketTabelCell.id, for: indexPath) as? ShoppingBasketTabelCell else { return UITableViewCell() }
        return cell
    }
    
    
}
