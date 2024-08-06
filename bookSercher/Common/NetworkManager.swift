//
//  NetworkManager.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/6/24.
//

import Foundation
import RxSwift

enum NetworkError: Error{
    case invailedUrl
    case dataFetchFail
    case decodingFail
}


// 싱글톤 네트워크 매니저
class NetworkManager{
    static let shared = NetworkManager()
    private let apiKey = "f058fdd1f12c6afc2089457548925562"
    private init(){}
    
    func fetch<T: Decodable>(url: URL) -> Single<T>{
        return Single.create{ observer in
            let session = URLSession(configuration: .default)
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = ["Authorization": "KakaoAK \(self.apiKey)"]
            session.dataTask(with: urlRequest){ data, response, error in
                
                if let error = error {
                    observer(.failure(error))
                    return
                }
                
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    observer(.failure(NetworkError.dataFetchFail))
                    return
                }
                
                do{
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer(.success(decodedData))
                }catch{
                    observer(.failure(NetworkError.decodingFail))
                }
                
            }.resume()
            return Disposables.create()
        }
    }
}

