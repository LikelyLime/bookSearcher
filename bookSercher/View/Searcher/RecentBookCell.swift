//
//  RecentBookCell.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import UIKit
class RecentBookCell: UICollectionViewCell{
    static let id = "RecentBookCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(bookInfo: BookModel){
        var urlString = bookInfo.thumbnail
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self!.imageView.image = image
                    }
                }
            }
        }
    }
}
