//
//  BookModel.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/5/24.
//

import Foundation

struct SearchResponse: Codable {
    var documents: [BookModel]
}

struct BookModel: Codable {
    let title: String // 책 제목
    let authors: [String] // 책 저자
    let contents: String // 책 줄거리
    let thumbnail: String // 책 포스터
    let price: Int // 책 가격
 
}
