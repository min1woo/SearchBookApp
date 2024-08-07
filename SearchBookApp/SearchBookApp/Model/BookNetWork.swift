//
//  BookNetWork.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/7/24.
//

import Foundation

protocol Bookservice {
    func fechBooks(query: String, completion: @escaping (Result<[BookModel], Error>) -> Void)
}

class BookNetWork: Bookservice {
    let apiKey = "364d3c115f8fd9f5690f3f7273ddbf68"
    
    func fechBooks(query: String, completion: @escaping (Result<[BookModel], any Error>) -> Void) {
        guard !query.isEmpty else {
            completion(.success([]))
            return
        }
        
        let urlString = "https://dapi.kakao.com/v3/search/book?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "dataNilError", code: -10001, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                completion(.success(searchResponse.documents))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}

struct SearchResponse: Decodable {
    let documents: [BookModel]
}
