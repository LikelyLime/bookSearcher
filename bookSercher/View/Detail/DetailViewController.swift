//
//  DetailViewController.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/2/24.
//

import Foundation
import UIKit
class DetailViewController: UIViewController{
    let detailView = DetailView()
    override func loadView() {
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
