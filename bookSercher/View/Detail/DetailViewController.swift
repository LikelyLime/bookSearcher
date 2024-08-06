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
    let coreData = CoreDataManager()
    var urlString = ""
    override func loadView() {
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI(){
        detailView.returnButton.addTarget(self, action: #selector(returnAction), for: .touchDown)
        detailView.addButton.addTarget(self, action: #selector(addAction), for: .touchDown)
    }
    @objc func returnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addAction() {
        createData()
        returnAction()
    }
    
    func createData(){
        coreData.saveBook(title: detailView.titleLabel.text!, authors: detailView.authorLabel.text!, price: detailView.priceLabel.text!, content: detailView.contentLabel.text!, thumbnail: urlString)
        print(coreData.fetchBooks())
    }
    func setUI(bookInfo: BookModel){
        urlString = bookInfo.thumbnail
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.detailView.setUi(bookInfo: bookInfo, preview: image)
                    }
                }
            }
        }
    }
    
}
