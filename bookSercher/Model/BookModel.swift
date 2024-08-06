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
struct BookModel: Codable {
    let authors: [String]
    let contents: String
    let price: Int
    let title: String
    let thumbnail: String
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
