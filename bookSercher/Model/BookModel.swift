//
//  BookModel.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/5/24.
//

import Foundation

struct BookModel: Codable{
    let meta: Meta
}
struct Meta: Codable{
    let totalCount: Int
    let pageableCount: Int
    let isEnd: Bool
    enum CodingKeys: String, CodingKey{
        case isEnd
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
