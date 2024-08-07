//
//  BookModel.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import Foundation
struct BookSearchResponse: Codable {
    let meta: Meta
    let documents: [BookModel]
}
struct BookModel: Codable, Equatable {
    let authors: [String]
    let contents: String
    let price: Int
    let title: String
    let thumbnail: String
    /// 연산자를 오버로딩
    static func == (lhs: BookModel, rhs: BookModel) -> Bool {
        return lhs.title == rhs.title && lhs.authors == rhs.authors
    }
}



struct Meta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
