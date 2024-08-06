//
//  BookModel.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/5/24.
//

import Foundation

struct BookModel: Codable {
    let title: String?
    let authors: String?
    let contents: String?
    let thumbnail: String?
}
