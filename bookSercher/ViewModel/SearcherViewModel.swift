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
    let bookInfoSubject = BehaviorSubject<BookSearchResponse>(value: 
                                                                BookSearchResponse(meta: Meta(isEnd: true, pageableCount: 0, totalCount: 0), documents: [])
    )
    
    init(){}
    
    func retrieveBookInfo(word: String, page: Int = 1){
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(word)&page=\(page)") else {
            return bookInfoSubject.onError(NetworkError.invailedUrl)
        }
        
        NetworkManager.shared.fetch(url: url).subscribe(onSuccess: { [weak self] (response: BookSearchResponse) in
            self?.bookInfoSubject.onNext(response)
        }, onFailure: { [weak self] error in
            self?.bookInfoSubject.onError(error)
        }).disposed(by: disposeBag)
    }
}

