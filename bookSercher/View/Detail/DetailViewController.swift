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
    let common = Common()
    var urlString = ""
    override func loadView() {
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    /// 버튼 이벤트 선언
    func configureUI(){
        detailView.returnButton.addTarget(self, action: #selector(returnAction), for: .touchDown)
        detailView.addButton.addTarget(self, action: #selector(addAction), for: .touchDown)
    }
    ///되돌아가기 버튼 이벤트
    @objc func returnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    ///담기 버튼 이벤트
    @objc func addAction() {
        let bookInfo = coreData.retrieveBookInfo(title: detailView.titleLabel.text!, author: detailView.authorLabel.text!)
        if !bookInfo.isEmpty{
            showSnycAlert(message: "이미 같은 책이 담겨져 있습니다.", buttonTitle: "확인", buttonClickTitle: "OK"){
                return
            }
        }else{
            coreData.saveBook(title: detailView.titleLabel.text!, authors: detailView.authorLabel.text!, price: detailView.priceLabel.text!, content: detailView.contentLabel.text!, thumbnail: urlString)
            returnAction()
        }

    }
    ///이미지를 조회하여 view컴퍼넌트에 셋팅
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
