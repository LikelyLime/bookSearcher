//
//  SearcherViewModel.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/6/24.
//

import Foundation
import RxSwift
class SearcherViewModel{
    
    private let disposeBag = DisposeBag()
    let bookInfoSubject = BehaviorSubject(value: [BookModel]())
    
    init(){}
    
    func retrieveBookInfo(word: String){
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(word)") else {
            return bookInfoSubject.onError(NetworkError.invailedUrl)
        }
        
        NetworkManager.shared.fetch(url: url).subscribe(onSuccess: { [weak self] (response: BookSearchResponse) in
            self?.bookInfoSubject.onNext(response.documents)
        }, onFailure: { [weak self] error in
            self?.bookInfoSubject.onError(error)
        }).disposed(by: disposeBag)
    }
}

