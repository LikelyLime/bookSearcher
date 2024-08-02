//
//  RootViewController.swift
//  bookSercher
//
//  Created by 백시훈 on 8/2/24.
//

import Foundation
import UIKit
import SnapKit
class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        let child = SearchViewController()
        addChild(child)
        self.view.addSubview(child.view)
        child.view.snp.makeConstraints {
            $0.edges.equalTo(self.view.snp.edges)
        }
        child.didMove(toParent: self)
    }
}
